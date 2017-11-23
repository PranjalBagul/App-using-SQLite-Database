//
//  ViewController.h
//  travelCompany
//
//  Created by Student P_08 on 22/11/17.
//  Copyright © 2017 pranjal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "PicnicDB.h"
#import "myTableViewCell.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *picNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *picDurLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;

@property (weak, nonatomic) IBOutlet UITextField *picnicText;
@property (weak, nonatomic) IBOutlet UITextField *durationText;
@property (weak, nonatomic) IBOutlet UITextField *priceText;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)insertDetailsBtn:(id)sender;

@property NSArray *pArray;
@property NSArray *dArray;
@property NSArray *PriArray;
@end

