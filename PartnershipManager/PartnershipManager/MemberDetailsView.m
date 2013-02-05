//
//  MemberDetailsView.m
//  PartnershipManager
//
//  Created by Bob Emmanuel Esebamen on 12/6/12.
//  Copyright (c) 2012 Bob Emmanuel Esebamen. All rights reserved.
//

#import "MemberDetailsView.h"
#import "PersonData.h"

@implementation MemberDetailsView

- (id)initWithFrame:(CGRect)frame andPersonData:(PersonData*)data andNaviBar:(UINavigationBar*)bar
{
    self = [super initWithFrame:frame andNaviBar:bar];
    if (self) {
        personData = data;
        // Initialization code
        tableView.delegate = self;
        tableView.dataSource = self;

    }
    self.title = @"Personal Details";
    [super initializeNavigationBarWith:title];

    return self;
}

/* Returns header for the section */
-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;// @"Personal Details";
}


/* Creates cell for a single row */
-(UITableViewCell *) tableView:(UITableView *)tabView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = indexPath.row;
    
    if(row==0){
        NSString *temp =@"Name:  " ;
        temp = [temp stringByAppendingString:personData.name];
        return [self createPersonDetailsCellData:temp];
    }else if(row==1){
        NSString *temp =@"Surname:  " ;
        temp = [temp stringByAppendingString:personData.surName];
        return [self createPersonDetailsCellData:temp ];
    }else if(row==2){
        NSString *temp =@"Date of Birth:  " ;
        temp = [temp stringByAppendingString:personData.dateOfBirth];
        return [self createPersonDetailsCellData:temp];
    }else if(row==3){
        NSString *temp =@"Sex:  " ;
        temp = [temp stringByAppendingString:personData.sex];
        return [self createPersonDetailsCellData:temp];
    }else if(row==4){
        NSString *temp =@"Mobile Phone:  " ;
        temp = [temp stringByAppendingString:personData.mobilePhone];
        return [self createPersonDetailsCellData:temp];
    }else if(row==5){
        NSString *temp =@"Telephone:  " ;
        temp = [temp stringByAppendingString:personData.telephone];
        return [self createPersonDetailsCellData:temp];
    }else if(row==6){
        NSString *temp =@"Email:  " ;
        temp = [temp stringByAppendingString:personData.email];
        return [self createPersonDetailsCellData:temp];
    }else if(row==7){
        NSString *temp =@"Cell:  " ;
        temp = [temp stringByAppendingString:personData.cell];
        return [self createPersonDetailsCellData:temp];
    }else if(row==8){
        NSString *temp =@"Address:  " ;
        temp = [temp stringByAppendingString:personData.address];
        return [self createPersonDetailsCellData:temp];
    }
    
    return nil;
}

/* Number of rows per section */
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 8;
    
}

-(UITableViewCell*) createPersonDetailsCellData:(NSString*)s {
    //    const float kCellHeight = 60.0;
    static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
      //  cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.userInteractionEnabled = NO;
        
        UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(2,2,310.0, 60)] ;
        // desc.font = 12;
        desc.textColor = [UIColor whiteColor];
        desc.backgroundColor = [UIColor clearColor];
        desc.textAlignment = NSTextAlignmentLeft;
        desc.numberOfLines = 1;
        desc.text = s;
        [cell.contentView addSubview:desc];
        [cell.contentView sizeToFit];
    }
    
	return cell;
}

@end
