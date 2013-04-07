//
//  ApplicationData.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "ApplicationData.h"
#import "Strings.h"
#import "Reachability.h"
#import "MemberDataParser.h"
#import <DropboxSDK/DropboxSDK.h>
#import "AppDelegate.h"
#import "MembersParserCSV.h"


#define kChrchA @"/partnerTempla"
#define kChrchB @""
#define kChrchALL @""


@implementation ApplicationData

@synthesize parentViewController;
@synthesize subViews;
@synthesize PartnershipTypeArrays;
@synthesize appData;
@synthesize csvFilePath;


//SYNTHESIZE_SINGLETON_FOR_CLASS(ApplicationData);

+ (ApplicationData*) sharedApplicationData {
    static ApplicationData* _one = nil;
    
    @synchronized( self ) {
        if( _one == nil ) {
            _one = [[ ApplicationData alloc ] init ];            
        }
    }
    
    return _one;
}

/* setupFileDirectory */
-(void) setupFileDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    csvFilePath = [documentsDirectory stringByAppendingPathComponent:kCSVPath];
    NSLog(@"File path: %@", csvFilePath);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:csvFilePath]){
        
        NSError* error;
        if( ! [[NSFileManager defaultManager] createDirectoryAtPath:csvFilePath withIntermediateDirectories:NO attributes:nil error:&error])
        {
            NSLog(@"[%@] ERROR: attempting to write create directory", error);
        }
    }
    
    csvFilePath = [csvFilePath stringByAppendingPathComponent:@"partner.csv"];
    [csvFilePath retain];
    NSLog(@"File path: %@", csvFilePath);
    
}


/* setupDropBoxAccount */
-(void) setupDropBoxAccount {
    //data access type :No church, Church A, B, All
    self.accessType = 0;
    
    // Set these variables before launching the app
    NSString* appKey = kAppKey;
	NSString* appSecret = kAppSecret;
	NSString *root = kAppRoot;
	
	// Look below where the DBSession is created to understand how to use DBSession in your app	
	DBSession* dbSession =
    [[[DBSession alloc]
      initWithAppKey:appKey
      appSecret:appSecret
      root:root] 
     autorelease];
    [DBSession setSharedSession:dbSession];
    
    isDownloadingCSV = NO;
    if (restClient == nil) {
        restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        restClient.delegate = self;
    }
    [self LinkToDropBox];
    
}


- (void)downloadFromDropBox:(int)aChurch {
    NSString *csvRoot= @"";
    if (aChurch == 1) {
        csvRoot = [kChrchALL stringByAppendingString:@"/"];
        [restClient loadMetadata:csvRoot];
        
        csvRoot = [kChrchALL stringByAppendingString:@"/"];
        [restClient loadMetadata:csvRoot];

    }else  if (aChurch == 2) {
        
    }else  if (aChurch == 3) {
        
    }
    [restClient loadMetadata:csvRoot];
}


/* Fetches members data chruch A */
-(void) fetchPartnershipDataForChurchA {
    appData = nil;
    appData = [[AppDataManager alloc] init] ;
    
	MembersParserCSV *partnershipParser = [[[MembersParserCSV alloc] init] autorelease];
    
    appData.membersList = [partnershipParser parseFile:self.csvFilePath];
    
	/*bool ok = [partnershipParser loadXML:appData dataUrl:partnershipXML_URL];
	if (!ok) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kLoadingErrorDialogHeader message:kLoadingErrorDialogText delegate:self cancelButtonTitle:kLoadingErrorDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
	} else {
    }*/
}

/* Fetches members data chruch B */
-(void) fetchPartnershipDataForChurchB{
    appData = nil;
    appData = [[AppDataManager alloc] init] ;
    
	MembersParserCSV *partnershipParser = [[[MembersParserCSV alloc] init] autorelease];
    
    appData.membersList = [partnershipParser parseFile:self.csvFilePath];
    
}

/* Fetches members data ALL chruch */
-(void) fetchPartnershipDataForAllChurch{
    appData = nil;
    appData = [[AppDataManager alloc] init] ;
    
	MembersParserCSV *partnershipParser = [[[MembersParserCSV alloc] init] autorelease];
    
    //add church A data
    appData.membersList = [partnershipParser parseFile:self.csvFilePath];
    
    //add church B data
    [appData.membersList addObject :[partnershipParser parseFile:self.csvFilePath] ];

}

- (void)LinkToDropBox {
    if (![[DBSession sharedSession] isLinked]) {
        AppDelegate * appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
		[[DBSession sharedSession] linkFromController:(UIViewController*) [[appDelegate window] rootViewController]];
    }
}


- (void)UnLinkToDropBox {
        [[DBSession sharedSession] unlinkAll];
        [[[[UIAlertView alloc]
           initWithTitle:@"Account Unlinked!" message:@"Your dropbox account has been unlinked"
           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
          autorelease]
         show];
}


#pragma mark DBRestClientDelegate methods

- (void)restClient:(DBRestClient*)client loadedMetadata:(DBMetadata*)metadata {
    // [photosHash release];
    // photosHash = [metadata.hash retain];
    isDownloadingCSV = YES;

    
    NSArray* validExtensions = [NSArray arrayWithObjects:@"csv", nil];
    NSMutableArray* newCSVFilesPaths = [NSMutableArray new];
    for (DBMetadata* child in metadata.contents) {
        NSString* extension = [[child.path pathExtension] lowercaseString];
        if (!child.isDirectory && [validExtensions indexOfObject:extension] != NSNotFound) {
            [newCSVFilesPaths addObject:child.path];
        }
    }
    [csvFilesPaths release];
    csvFilesPaths = newCSVFilesPaths;
    
    [self storeCSVLocally];
}

- (void)restClient:(DBRestClient*)client metadataUnchangedAtPath:(NSString*)path {
    [self storeCSVLocally];
}

- (void)restClient:(DBRestClient*)client loadMetadataFailedWithError:(NSError*)error {
    NSLog(@"restClient:loadMetadataFailedWithError: %@", [error localizedDescription]);
    // [self displayError];
    //[self setWorking:NO];
}


- (void)restClient:(DBRestClient*)client loadedFile:(NSString *)destPath {
    //[self setWorking:NO];
    NSData *data = [NSData dataWithContentsOfFile: destPath];
    [data writeToFile:destPath atomically:TRUE];
    
    isDownloadingCSV = NO;

}

- (void)storeCSVLocally {
    NSString *msg = nil;
    
    if ([csvFilesPaths count] == 0) {
        
        [[[[UIAlertView alloc]
           initWithTitle:@"No data stored in DB!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
          autorelease]
         show];
        return;
        
    } else {
        NSString* csvPath;
        if ([csvFilesPaths count] == 1) {
            csvPath = [csvFilesPaths objectAtIndex:0];
        } else {
            csvPath = [csvFilesPaths objectAtIndex:0];
            
            // alert that there is more than one stored file
            [[[[UIAlertView alloc]
               initWithTitle:@"More than one file stored in DB!" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]
              autorelease]
             show];
            
        }
        
        if(csvPath != nil) {
            NSLog(@"PATH: %@", csvPath);
            [restClient loadFile:csvPath intoPath:self.csvFilePath];
        }        
    }
}


/* Fetches members data */
-(void) fetchPartnershipData {
	MemberDataParser *partnershipParser = [[[MemberDataParser alloc] init] autorelease];
	bool ok = [partnershipParser loadXML:appData dataUrl:partnershipXML_URL];
	if (!ok) {
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kLoadingErrorDialogHeader message:kLoadingErrorDialogText delegate:self cancelButtonTitle:kLoadingErrorDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
	} else {
    }
}

/* Checks that network connection exists */
-(BOOL) checkIsNetworkAvailable {	
	Reachability *reachability = [Reachability reachabilityForInternetConnection];
	
	//DebugLog(@"Doing network status check");
	
	if([reachability currentReachabilityStatus] == NotReachable) {
		//DebugLog(@"Network not available");
		UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kNoNetworkDialogHeader message:kNoNetworkDialogText delegate:self cancelButtonTitle:kNoNetworkDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
        return NO;
	} else {
        //DebugLog(@"Network IS available");
        return YES;
	}
}

- (void)updateData
{
    if ([self checkIsNetworkAvailable]) {
      //  [appData release];
         appData = nil;
         appData = [[AppDataManager alloc] init] ;
        
        [self fetchPartnershipData];
        [appData setupData];
        
        
    }else {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:kNoNetworkDialogHeader message:kNoNetworkDialogText2 delegate:self cancelButtonTitle:kNoNetworkDialogButtonText otherButtonTitles:nil] autorelease];
		[alert show];
    }
    
}

@end
