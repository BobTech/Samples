//
//  MemberDataParser.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/19/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MemberDataParser.h"
#import "TBXML.h"
#import "PersonData.h"


#define kMembersEntry @"members"
#define kMemberEntry @"member"
#define kPersonEntry @"person"
#define kPersonIDEntry @"person_id"
#define kNameEntry @"name"
#define kSurnameEntry @"surname"
#define kMobileEntry @"mobilephone"
#define kTelephoneEntry @"telephone"
#define kEmailEntry @"email"
#define kSexEntry @"sex"
#define kCellEntry @"cell"
#define kBirthDateEntry @"date_birth"
#define kAddressEntry @"address"
#define kPartnershipsEntry @"partnerships"
#define kPartnershipEntry @"partnership"
#define kPartnershipMonthNameEntry @"partnership_month"
#define kPartnershipArmEntry @"partnership_arm"
#define kPartnershipNameEntry @"partnership_name"
#define kMonthGivingEntry @"month_giving"

#define kMonthEntry @"month"
#define kTotalGivingEntry @"month_total"
#define kYearEntry @"year"



@implementation MemberDataParser

/* Constructor */
-(id) init {
	appData = nil;
	return self;
}

/* Destructor */
-(void) dealloc {
	[super dealloc];
}

/* Loads and parses the note XML */
-(bool)loadXML:(AppDataManager*)dataMgr dataUrl:(NSString *)sUrl {
	//DebugLog(@"loadXML() called with URL: %@", sUrl);
    
	appData = dataMgr;
	
   /*NSArray *compArray = [sUrl componentsSeparatedByString:@"/"];
	if (compArray != nil && [compArray count] > 0) {
		DebugLog(@"Checking if file %@ exists on zip dir", [compArray objectAtIndex:[compArray count] - 1]);
		filePath = [ZipManager fileExistsOnZipPath:[compArray objectAtIndex:[compArray count] - 1]];
		DebugLog(@"File path: %@", filePath);
	}*/
    NSString *filePath = nil;

	NSURL *url = [[[NSURL alloc] initWithString:sUrl] autorelease];
	NSData *fileData = nil;
	if (filePath == nil) {
		//DebugLog(@"Initializing parser from URL: %@", url);
        NSURLRequest *theRequest=[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
        fileData = [[NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:nil] retain];
	} else {
		fileData = [[NSData alloc] initWithContentsOfFile:filePath];
		//DebugLog(@"Initializing parser from buffer with length: %10.2f", [fileData length]);
	}
	
	BOOL success = NO;
    
    if (fileData != nil) {
        success = [self parseData:fileData];
        [fileData release];
    }
	
	fileData = nil;
	
	if (success){
		//DebugLog(@"No errors in parsing XML");
	}else {
		//DebugLog(@"Error Error Error in parsing XML");
	}
	return success;
}

/* Load XML directly from data array */
-(bool) loadXML:(AppDataManager*)dataMgr fromData:(NSData *)data {
	//DebugLog(@"loadXMLfromData() called");
    
	appData = dataMgr;
	//DebugLog(@"Initializing parser from buffer with length: %10.2f", [data length]);
	
	BOOL success = NO;
    if (data != nil) {
        success = [self parseData:data];
    }
    
	if (success){
		//DebugLog(@"No errors in parsing XML");
	}else {
		//DebugLog(@"Error Error Error in parsing XML");
	}
	return success;
}

/* Parses data */
-(bool) parseData:(NSData*)data {
    [appData.membersList removeAllObjects];
    
    TBXML *tbxml = [[TBXML tbxmlWithXMLData:data] retain];
    [tbxml setXMLEncoding:NSISOLatin1StringEncoding];
    TBXMLElement *rootXMLElement = tbxml.rootXMLElement;
    TBXMLElement *element = rootXMLElement->firstChild;
    
    while (element != nil) { //member
        NSString *elementName = [TBXML elementName:element];
        
        if ([elementName isEqualToString:kMemberEntry]) {
            PersonData *tempPerson = [[PersonData alloc] init];
            TBXMLElement *memberChildElement = element->firstChild;

    
            while (memberChildElement != nil) { //person data
                NSString *elementName = [TBXML elementName:memberChildElement];
        
                if ([elementName isEqualToString:kPersonEntry]) {
            
                    TBXMLElement *personChildElement = memberChildElement->firstChild;
                    while (personChildElement != nil) {
                        elementName = [TBXML elementName:personChildElement];
                
                        if ([elementName isEqualToString:kPersonIDEntry]) {
                            NSString *tempID = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            int value = [tempID floatValue];
                            tempPerson.personID = value;
                        } else if ([elementName isEqualToString:kNameEntry]) {
                            tempPerson.name = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        }else if ([elementName isEqualToString:kSurnameEntry]) {
                            tempPerson.surName = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        } else if ([elementName isEqualToString:kMobileEntry]) {
                            tempPerson.mobilePhone= [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        } else if ([elementName isEqualToString:kTelephoneEntry]) {
                            tempPerson.telephone = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        } else if ([elementName isEqualToString:kEmailEntry]) {
                            tempPerson.email = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        } else if ([elementName isEqualToString:kSexEntry]) {
                            tempPerson.sex = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        } else if ([elementName isEqualToString:kCellEntry]) {
                            tempPerson.cell = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                        }  else if ([elementName isEqualToString:kBirthDateEntry]) {
                    
                            NSString *tempDateString= [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                            [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
                            [dateFormatter setDateStyle:NSDateFormatterLongStyle];
                            NSDate *newDate=[dateFormatter dateFromString:tempDateString];
                            tempPerson.dateOfBirth = tempDateString;

                       } else if ([elementName isEqualToString:kAddressEntry]) {
                           tempPerson.address = [[TBXML textForElement:personChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                       }                
                    personChildElement = personChildElement->nextSibling;
                }//end while loop for personChildElement
            
            } // end if for kPersonEntry
              else if ([elementName isEqualToString:kPartnershipsEntry]) {
                  
                    TBXMLElement *partnershipElement = memberChildElement->firstChild;
                    while (partnershipElement != nil) {
                        elementName = [TBXML elementName:partnershipElement];
                        
                        if ([elementName isEqualToString:kPartnershipEntry]) {
                            MonthlyPartnershipData *monthlyData = [[MonthlyPartnershipData alloc] init];
                            
                            TBXMLElement *partnershipChildElement = partnershipElement->firstChild;
                            while (partnershipChildElement != nil) {
                                elementName = [TBXML elementName:partnershipChildElement];
                                
                                if ([elementName isEqualToString:kPartnershipMonthNameEntry]) {
                                    monthlyData.name = [[TBXML textForElement:partnershipChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                    
                                }else if ([elementName isEqualToString:kYearEntry]) {
                                    monthlyData.year = [[TBXML textForElement:partnershipChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                    
                                }else if ([elementName isEqualToString:kPartnershipArmEntry]) {
                                    PartnershipData *partnershipData = [[PartnershipData alloc] init];

                                    TBXMLElement *partnershipArmChildElement = partnershipChildElement->firstChild;
                                    while (partnershipArmChildElement != nil) {
                                        elementName = [TBXML elementName:partnershipArmChildElement];
                                        if ([elementName isEqualToString:kPartnershipNameEntry]) {
                                            partnershipData.partnershipName = [[TBXML textForElement:partnershipArmChildElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                        }else if ([elementName isEqualToString:kMonthEntry]) {

                                            TBXMLElement *givingElement = partnershipArmChildElement->firstChild; //Month tag
                                            while (givingElement != nil) {
                                                elementName = [TBXML elementName:givingElement];
                                            
                                                if ([elementName isEqualToString:kMonthGivingEntry]) {
                                                    NSString * giving =[[TBXML textForElement:givingElement] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                                                [partnershipData.totalGivings addObject:giving];
                                                }
                                                givingElement = givingElement->nextSibling;
                                            } //end while giving
                                        }//end else if
                                        
                                        partnershipArmChildElement = partnershipArmChildElement->nextSibling;

                                    }//end while loop partnershipArmChild
                                    
                                    [monthlyData.partnership addObject:partnershipData];
                                    [partnershipData release];
                                    partnershipData =nil;
                               }//end else if
                                partnershipChildElement = partnershipChildElement->nextSibling;     
                             }//end while loop for partnershipChildElement
                          
                            [tempPerson.partnership.monthlyPartnershipDataList addObject:monthlyData];
                            [monthlyData release];
                            monthlyData = nil;
                        }//end if kpartnerEntry
                        partnershipElement = partnershipElement->nextSibling;
                    }//end while loop for partnershipElement
                  
                  [appData.membersList addObject:tempPerson];
                  [tempPerson release];
                  tempPerson = nil;

                } // end if for kPersonEntry
                
                
         memberChildElement = memberChildElement->nextSibling;
        }
     }
        
        element = element->nextSibling;
    }
    return TRUE;
}
@end
