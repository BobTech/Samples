//
//  MembersParserCSV.h
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 3/11/13.
//  Copyright (c) 2013 Bob Emmanuel Esebamen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCSVParser.h"

@interface MembersParserCSV : NSObject <CHCSVParserDelegate>{

    NSMutableArray *membersList;

}

- (NSMutableArray*)parseFile:(NSString*)aFile;

@end
