//
//  MembersParserCSV.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 3/11/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MembersParserCSV.h"
#import "ApplicationData.h"

@implementation MembersParserCSV

- (NSMutableArray*)parseFile:(NSString*)aFile
{
    membersList = [[NSMutableArray alloc] init];

    NSString* file = [ApplicationData sharedApplicationData].csvFilePath;
    
    CHCSVParser *newP = [[[CHCSVParser alloc] initWithContentsOfCSVFile:file] autorelease];
    [newP setDelegate:self];
    //    [newP setRecognizesBackslashesAsEscapes:NO];
    //    [newP setSanitizesFields:YES];
    
    [newP parse];
    //[newP release];

    return membersList;
}

- (void) parser:(CHCSVParser *)parser didStartDocument:(NSString *)csvFile {
    	NSLog(@"parser started: %@", csvFile);
}
- (void) parser:(CHCSVParser *)parser didStartLine:(NSUInteger)lineNumber {
    	NSLog(@"Starting line: %lu", lineNumber);
}
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex {
    if (fieldIndex == 0) {
        printf("\t%s", [field UTF8String]);
    } else {
        printf(",%s", [field UTF8String]);
    }
}
- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber {
    //	NSLog(@"Ending line: %lu", lineNumber);
    printf("\n");
}
- (void) parser:(CHCSVParser *)parser didEndDocument:(NSString *)csvFile {
    	NSLog(@"parser ended: %@", csvFile);
}
- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"ERROR: %@", error);
}

@end
