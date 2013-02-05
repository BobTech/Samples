//
//  MemberDataParser.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/19/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataManager.h"

@interface MemberDataParser : NSObject<NSXMLParserDelegate> {
	AppDataManager *appData;
}

/* Method declarations */

-(bool) loadXML:(AppDataManager*)dataMgr dataUrl:(NSString *)sUrl;
-(bool) loadXML:(AppDataManager*)dataMgr fromData:(NSData *)data;
-(bool) parseData:(NSData*)data;

@end



