//
//  hotelorderCell.h
//  Tour
//
//  Created by Euet on 17/2/18.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelorderCell : UITableViewCell

@property(nonatomic,copy)NSMutableDictionary * celldict;

@property(nonatomic,strong)UILabel * datelabel;
@property(nonatomic,strong)UILabel * weeklabel;

@property(nonatomic,strong)UILabel * citylabel;
@property(nonatomic,strong)UILabel *numlabel;

@property(nonatomic,strong)UILabel * namelabel;

@property(nonatomic,strong)UILabel * pricelabel;
@property(nonatomic,strong)UILabel * statuslabel;

@property(nonatomic,strong)UIView * viewline;

@property(nonatomic,strong)UIImageView * cityimag;

@property(nonatomic,strong)UIImageView * menimag;

@property(nonatomic,strong)UIButton * addbutton;

@end
