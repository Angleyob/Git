//
//  addMenViewController.h
//  Tour
//
//  Created by Euet on 16/12/21.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addMenViewController : UIViewController
@property (weak, nonatomic) NSMutableDictionary  * messageDict;
@property (strong, nonatomic) IBOutlet UILabel *card;
@property(nonatomic,assign)int type;
@property(nonatomic,copy)NSMutableArray * countryArr;

@end
