//
//  PicnicDB.h
//  travelCompany
//
//  Created by Student P_08 on 22/11/17.
//  Copyright © 2017 pranjal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PicnicDB : NSObject
{
    sqlite3 *PicnicDatabase;
}
+(instancetype)sharedObject;
-(NSString *)getDatabasePath;
-(void)createDatabase;
-(BOOL)executeQuery:(NSString *)query;
-(void)getAllTasks:(NSString *)query;

@property NSMutableArray *PicNameMutableArray;
@property NSMutableArray *PicDurMutableArray;
@property NSMutableArray *PicPriceMutableArray;


@end
