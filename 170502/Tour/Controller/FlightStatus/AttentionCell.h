

#import <UIKit/UIKit.h>
#import "AttentionModel.h"

@interface AttentionCell : UITableViewCell

@property(nonatomic,copy)NSMutableDictionary * celldict;
@property(nonatomic,copy)NSMutableArray * flightarr;

@property(nonatomic,strong)UILabel * dateLabel;

@property(nonatomic,strong)UILabel * dayLabel;

@property(nonatomic,strong)UILabel * weekLabel;


@property(nonatomic,strong)UILabel * flightnumLabel;

@property(nonatomic,strong)UILabel * fromtimeLabel;

@property(nonatomic,strong)UILabel * totimeLabel;

@property(nonatomic,strong)UILabel * syLabel;

@property(nonatomic,strong)UILabel * ywlabel;


@property(nonatomic,strong)UILabel * syLabel1;

@property(nonatomic,strong)UILabel * fromcityLabel;

@property(nonatomic,strong)UILabel * tocityLabel;

@property(nonatomic,strong)UILabel * fromflycityLabel;

@property(nonatomic,strong)UILabel * toflycityLabel;

@property(nonatomic,strong)UIImageView * lineimage;

@property(nonatomic,strong)UIImageView * flightlogoimage;

@property(nonatomic,strong)UIImageView * flystatusimage;

- (void)setCellWithModel:(AttentionModel *)app;

@end
