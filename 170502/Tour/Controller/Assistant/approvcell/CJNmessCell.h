//
//  CJNmessCell.h
//  Tour
//
//  Created by Euet on 17/2/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passageMenModel.h"
#import "passageTrainMenModel.h"

@interface CJNmessCell : UITableViewCell

@property (nonatomic,strong)UILabel * label1;
@property (nonatomic,strong)UILabel * namelabel;
@property (nonatomic,strong)UILabel * label2;
@property (nonatomic,strong)UILabel * typelabel;
@property (nonatomic,strong)UILabel * label3;
@property (nonatomic,strong)UILabel * IdNumlabel;

@property (nonatomic,strong)UIImageView * disledimage;

@property (nonatomic,strong)UIImageView* rightimage;

- (void)setCellWithModel:(passageMenModel *)app1;
- (void)setCellWithModelT:(passageTrainMenModel *)app;


@end
