//
//  PicnicDB.m
//  travelCompany
//
//  Created by Student P_08 on 22/11/17.
//  Copyright © 2017 pranjal. All rights reserved.
//

#import "PicnicDB.h"

@implementation PicnicDB
+(instancetype)sharedObject
{
    PicnicDB static *obj;
    if(obj==nil)
    {
        obj=[[PicnicDB alloc]init];
    }
    return obj;
}
-(NSString *)getDatabasePath
{
    NSString *dbpath;
    NSArray *pathDir=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    dbpath=[pathDir objectAtIndex:0];
    dbpath =[dbpath stringByAppendingString:@"/sqlitePicnicDatabase.db"];
    return dbpath;
}
-(BOOL)executeQuery:(NSString *)query
{
    BOOL success=0;
    const char *CQuery=[query UTF8String];
    NSString *dbPath=[self getDatabasePath];
    sqlite3_stmt *stmt;
    const char *pathOfDatabase=[dbPath UTF8String];
    if(sqlite3_open(pathOfDatabase, & PicnicDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(PicnicDatabase, CQuery, -1, &stmt, nil)!=SQLITE_OK)
        {
            NSLog(@"Database not able to prepare stmt %s",sqlite3_errmsg(PicnicDatabase));
        }
        else
        {
            if(sqlite3_step(stmt)==SQLITE_DONE)
            {
                success=1;
            }
        }
    }
    else
    {
        NSLog(@"Database not able to Open %s",sqlite3_errmsg(PicnicDatabase));
    }
    sqlite3_close(PicnicDatabase);
    sqlite3_finalize(stmt);
    
    return success;
}
-(void)createDatabase
{
    NSString *createQuery=@"create table if not exists picnicTable(PicName text,dur text,price text)";
    BOOL createSuccess=[self executeQuery:createQuery];
    if(createSuccess==YES)
    {
        NSLog(@"Database successfully created");
    }
    else
    {
        NSLog(@"Database not Created");
    }
    
}
-(void)getAllTasks:(NSString *)query
{
    self.PicNameMutableArray=[[NSMutableArray alloc]init];
    self.PicDurMutableArray=[[NSMutableArray alloc]init];
    self.PicPriceMutableArray=[[NSMutableArray alloc]init];
    const char *CQuery=[query UTF8String];
    NSString *dbPath=[self getDatabasePath];
    sqlite3_stmt *stmt;
    const char *pathOfDatabase=[dbPath UTF8String];
    if(sqlite3_open(pathOfDatabase, &PicnicDatabase)==SQLITE_OK)
    {
        if(sqlite3_prepare_v2(PicnicDatabase, CQuery, -1, &stmt, nil)!=SQLITE_OK)
        {
            NSLog(@"Database not able to prepare stmt %s",sqlite3_errmsg(PicnicDatabase));
        }
        else
        {
            while(sqlite3_step(stmt)==SQLITE_ROW)
            {
                const unsigned char *picnName=sqlite3_column_text(stmt, 0) ;
                NSString *task=[NSString stringWithFormat:@"%s",picnName];
                const unsigned char *dur=sqlite3_column_text(stmt, 1) ;
                NSString *task1=[NSString stringWithFormat:@"%s",dur];
                const unsigned char *rs=sqlite3_column_text(stmt, 2) ;
                NSString *task2=[NSString stringWithFormat:@"%s",rs];
                
                [self.PicNameMutableArray addObject:task];
                [self.PicDurMutableArray addObject:task1];
                [self.PicPriceMutableArray addObject:task2];
                
            }
        }
    }
    else
    {
        NSLog(@"Database not able to Open %s",sqlite3_errmsg(PicnicDatabase));
    }
    sqlite3_finalize(stmt);
    sqlite3_close(PicnicDatabase);
    
    NSLog(@"Picnic Name Array contains %@",self.PicNameMutableArray);
    NSLog(@"Duration Array contains %@",self.PicDurMutableArray);
    NSLog(@"Price Array contains %@",self.PicPriceMutableArray);
}



@end
