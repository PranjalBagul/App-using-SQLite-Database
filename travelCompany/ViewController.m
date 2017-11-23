//
//  ViewController.m
//  travelCompany
//
//  Created by Student P_08 on 22/11/17.
//  Copyright © 2017 pranjal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *selectQuery=@"select * from picnicTable";
    [[PicnicDB sharedObject]getAllTasks:selectQuery];
    self.pArray=[PicnicDB sharedObject].PicNameMutableArray;
    self.dArray=[PicnicDB sharedObject].PicDurMutableArray;
    self.PriArray=[PicnicDB sharedObject].PicPriceMutableArray;
    // Do any additional setup after loading the view, typically from a nib.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DetailCellIdentifier=@"myCell";
    myTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:DetailCellIdentifier];
    if(cell==nil)
    {
        NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"myCell" owner:self options:nil];
        cell = (myTableViewCell *) [cellObjects objectAtIndex:0];
    }
    cell.nameLbl.text=[self.pArray objectAtIndex:indexPath.row];
    cell.durationLbl.text=[self.dArray objectAtIndex:indexPath.row];
    cell.priceLbl.text=[self.PriArray objectAtIndex:indexPath.row];
    return cell;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *selectQuery=@"select * from picnicTable";
    [[PicnicDB sharedObject]getAllTasks:selectQuery];
    self.pArray=[PicnicDB sharedObject].PicNameMutableArray;
    self.dArray=[ PicnicDB sharedObject].PicDurMutableArray;
    self.PriArray=[PicnicDB sharedObject].PicPriceMutableArray;
    if(self.pArray.count>0)
    {
        self.myTableView.delegate=self;
        self.myTableView.dataSource=self;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insertDetailsBtn:(id)sender
{
    NSString *insertQuery=[NSString stringWithFormat:@"insert into picnicTable(picName,dur,price) values('%@','%@','%@')",self.picnicText.text,self.durationText.text,self.priceText.text];
    BOOL isSuccess=[[PicnicDB sharedObject]executeQuery:insertQuery];
    if(isSuccess)
    {
        NSLog(@"Record Inserted successfully");
        NSString *selectQuery=@"select * from picnicTable";
        [[PicnicDB sharedObject]getAllTasks:selectQuery];
        self.pArray=[PicnicDB sharedObject].PicNameMutableArray;
        self.dArray=[PicnicDB sharedObject].PicDurMutableArray;
        self.PriArray=[PicnicDB sharedObject].PicPriceMutableArray;
        if(self.pArray.count >0)
        {
            [self.myTableView reloadData];
        }
        self.picnicText.text=@"";
        self.durationText.text=@"";
        self.priceText.text=@"";
        
        [self.picnicText becomeFirstResponder];
    }
    else
    {
        NSLog(@"insert failed!!!");
    }
    

}
@end
