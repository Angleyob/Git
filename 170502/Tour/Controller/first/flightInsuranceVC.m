//
//  flightInsuranceVC.m
//  Tour
//
//  Created by Euet on 17/4/19.
//  Copyright © 2017年 lhy. All rights reserved.

#define insureMess1 @"保险名称：合众航意险20（7天）\r\n\n保险金额：航空意外保险责任保额80万元、意外医疗保险责任保额20万元\r\n\n保险费：20元\r\n\n保险生效时间：7天\r\n\n限购份数：未成年人最高投保1份，成年人最高投保2份\r\n\n投保范围：30天-80周岁身体健康者，均可以作为被保险人，由本人或对其具有保险利益的其他人作为投保人向本公司投保本保险。\r\n\n证件类型：身份证、军人证等有效证件\r\n\n受益人：法定\r\n\n退保规则:保险责任正式开始之前可全额退保\r\n\n其他保险说明：\r\n\n如果保险产品内容或购买后有疑问，可拨打合众人寿客服热线95515，将有专人为您解答。\r\n\n使用条款及报备文号：合众附加综合交通工具意外伤害医疗保险(2013修订)-飞机，合众综合交通工具意外伤害保险（2013修订）（飞机）\r\n\n撤单条件：您可在本保险生效日之前申请撤单，撤单成功后保险费将划转到原交费帐户；起飞生效后不得申请撤单 。保险咨询、理赔报案电话： 合众人寿保险公司客服电话95515或登录http://www.unionlife.com.cn/";

#define insureMess2 @"保险名称：都邦航意险\r\n\n限购份数：限购2份\r\n\n保额：保额50万，10天有效 \r\n\n保险金额额：20元\r\n\n被保人年龄限制：28天至75周岁\r\n\n保险生效时间：次日凌晨\r\n\n理赔验证流程：登录www.dbic.com.cn进行查询";


#import "flightInsuranceVC.h"

@interface flightInsuranceVC ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    //保险类型1的视图
    UIView * insurView1;
    
    UIView *view1;
    //用于判断是否被选择
    int type1;
    
    UIImageView * selectImv1;
    UILabel * insurlabel;
    UILabel * insurpricelabel;
    UILabel * insurMeslabel;
    UIView * line1;
    UIButton * insurMesbut;
    //保险类型2的视图
    UIView * insurView2;
    //用于判断是否被选择
    int type2;
    UIImageView * selectImv2;
    UILabel * insurlabel2;
    UILabel * insurpricelabel2;
    UILabel * insurMeslabel2;
    UIView * line2;
    UIButton * insurMesbut2;
    // 购买的份数label
    UILabel * partNum;
    // 购买的份数
//    NSString * Num;
    
    
    NSMutableArray * insurearray;
    
    
    NSArray*_arr;
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    NSString * seatstring;
    UIButton * butclear;
    UIButton * butchange;
    
    
    //保险信息查询
    NSString *messageInsur;
    //保险简述
    NSString *mesInsur;
    
    UIScrollView *scrollView;
    
    UIView * _infoconnetview;
    UILabel* tglabel1;
    


}
@end

@implementation flightInsuranceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    type1=-1;
    type2=-1;
    [self navtivebar];
    [self creatView];
    [self loadDta];
}
#pragma mark -自定义导航栏
-(void)navtivebar{
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"保险";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    UIButton * okbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-60, 25, 60, 20)];
    okbut.titleLabel.font=[UIFont systemFontOfSize:15];
    [okbut setTitle:@"完成" forState:UIControlStateNormal];
    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbut addTarget:self action:@selector(okbut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:okbut];
}
#pragma mark -创建视图
-(void)creatView{
    
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    UIView * view = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 104, 375, 208)]];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImageView * imageViewLogo = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(14, 13, 18, 18)]];
    imageViewLogo.image=[UIImage imageNamed:@"safe"];
    [view addSubview:imageViewLogo];
    
    UILabel * label = [UILabel new];
    label.text=@"航空意外险";
    label.adjustsFontSizeToFitWidth=YES;
    label.textColor=UIColorFromRGBA(0x333333, 1.0);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageViewLogo.mas_right).with.offset(10/SCREEN_RATE);
        make.top.equalTo(view).offset(12/SCREEN_RATE1);
        make.height.offset(21/SCREEN_RATE1);
        make.width.offset(70/SCREEN_RATE);
    }];
    UIView * viewLine = [UILabel new];
    viewLine.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [view addSubview:viewLine];
    [viewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15/SCREEN_RATE);
        make.top.mas_equalTo(imageViewLogo.mas_bottom).with.offset(11/SCREEN_RATE1);
        make.height.offset(1);
        make.width.offset(360/SCREEN_RATE);
    }];
    
    //保险类型1的视图
    insurView1  =[UIView new];
    //剪切
    insurView1.clipsToBounds=YES;
    //圆角
    insurView1.layer.cornerRadius = 5.0;
    insurView1.layer.borderWidth = 1;
    insurView1.layer.borderColor =[UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
    insurView1.backgroundColor=[UIColor whiteColor];
    [view addSubview:insurView1];
    [insurView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(25/SCREEN_RATE);
        make.top.mas_equalTo(viewLine.mas_bottom).with.offset(14/SCREEN_RATE1);
        make.height.offset(90/SCREEN_RATE1);
        make.width.offset(150/SCREEN_RATE);
    }];
    
    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)];
    [insurView1 addGestureRecognizer:tapp];
    insurView1.tag=101;
    
    selectImv1 = [UIImageView new];
    selectImv1.image=[UIImage imageNamed:@"insurance-on"];
    [insurView1 addSubview:selectImv1];
    [selectImv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(insurView1).offset(10/SCREEN_RATE);
        make.top.equalTo(insurView1).offset(20/SCREEN_RATE1);
        make.height.offset(18/SCREEN_RATE1);
        make.width.offset(18/SCREEN_RATE);
    }];

    insurlabel = [UILabel new];
    insurlabel.text=@"合众保险";
    insurlabel.adjustsFontSizeToFitWidth=YES;
    insurlabel.textColor=UIColorFromRGBA(0x333333, 1.0);
    [insurView1 addSubview:insurlabel];
    [insurlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView1);
        make.top.equalTo(insurView1).offset(3/SCREEN_RATE1);
        make.height.offset(20/SCREEN_RATE1);
        make.width.offset(56/SCREEN_RATE);
    }];
    
    insurpricelabel = [UILabel new];
    insurpricelabel.text=@"";
    insurpricelabel.adjustsFontSizeToFitWidth=YES;
    insurpricelabel.textColor=UIColorFromRGBA(0x333333, 1.0);
    [insurView1 addSubview:insurpricelabel];
    [insurpricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView1);
        make.top.mas_equalTo(insurlabel.mas_bottom).offset(3/SCREEN_RATE1);
        make.height.offset(20/SCREEN_RATE1);
        make.width.offset(56/SCREEN_RATE);
    }];
    
    insurMeslabel = [UILabel new];
    insurMeslabel.text=@"保额100万，7天有效";
    insurMeslabel.adjustsFontSizeToFitWidth=YES;
    insurMeslabel.textAlignment=NSTextAlignmentCenter;
    insurMeslabel.textColor=UIColorFromRGBA(0x333333, 1.0);
    [insurView1 addSubview:insurMeslabel];
    [insurMeslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView1);
        make.top.mas_equalTo(insurpricelabel.mas_bottom).offset(1/SCREEN_RATE1);
        make.height.offset(15/SCREEN_RATE1);
        make.width.offset(80/SCREEN_RATE);
    }];
    line1 = [UILabel new];
    line1.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [insurView1 addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView1);
        make.top.mas_equalTo(insurMeslabel.mas_bottom).with.offset(5/SCREEN_RATE1);
        make.height.offset(1);
        make.width.offset(110/SCREEN_RATE);
    }];
    insurMesbut= [UIButton new];
    insurMesbut.tag=201;
    [insurMesbut addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [insurMesbut setTitle:@"详情" forState:UIControlStateNormal];
    [insurMesbut setTitleColor:UIColorFromRGBA(0x333333, 1.0) forState:UIControlStateNormal];
    insurMesbut.titleLabel.font=[UIFont systemFontOfSize:12];
    [insurView1 addSubview:insurMesbut];
    [insurMesbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView1);
        make.top.mas_equalTo(line1.mas_bottom).offset(0);
        make.height.offset(21/SCREEN_RATE1);
        make.width.offset(110/SCREEN_RATE);
    }];
    //保险类型2的视图
    insurView2  =[UIView new];
    //剪切
    insurView2.clipsToBounds=YES;
    //圆角
    insurView2.layer.cornerRadius = 5.0;
    insurView2.layer.borderWidth = 1;
    insurView2.layer.borderColor = [UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
    insurView2.backgroundColor=[UIColor whiteColor];
    [view addSubview:insurView2];
    
    [insurView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-25/SCREEN_RATE);
        make.top.mas_equalTo(viewLine.mas_bottom).with.offset(14/SCREEN_RATE1);
        make.height.offset(90/SCREEN_RATE1);
        make.width.offset(150/SCREEN_RATE);
    }];
    
    UITapGestureRecognizer *tapp2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)];
    [insurView2 addGestureRecognizer:tapp2];
    insurView2.tag=102;
    
    selectImv2 = [UIImageView new];
    selectImv2.image=[UIImage imageNamed:@"insurance-off"];
    [insurView2 addSubview:selectImv2];
    [selectImv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(insurView2).offset(10/SCREEN_RATE);
        make.top.equalTo(insurView2).offset(20/SCREEN_RATE1);
        make.height.offset(18/SCREEN_RATE1);
        make.width.offset(18/SCREEN_RATE);
    }];
    
    insurlabel2 = [UILabel new];
    insurlabel2.text=@"都邦保险";
    insurlabel2.adjustsFontSizeToFitWidth=YES;
    insurlabel2.textColor=UIColorFromRGBA(0x333333, 1.0);
    [insurView2 addSubview:insurlabel2];
    [insurlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView2);
        make.top.equalTo(insurView2).offset(3/SCREEN_RATE1);
        make.height.offset(20/SCREEN_RATE1);
        make.width.offset(56/SCREEN_RATE);
    }];
    
    insurpricelabel2 = [UILabel new];
    insurpricelabel2.text=@"";
    insurpricelabel2.adjustsFontSizeToFitWidth=YES;
    insurpricelabel2.textColor=UIColorFromRGBA(0x333333, 1.0);
    [insurView2 addSubview:insurpricelabel2];
    [insurpricelabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView2);
        make.top.mas_equalTo(insurlabel2.mas_bottom).offset(3/SCREEN_RATE1);
        make.height.offset(20/SCREEN_RATE1);
        make.width.offset(56/SCREEN_RATE);
    }];
    
    insurMeslabel2 = [UILabel new];
    insurMeslabel2.text=@"保额50万，10天有效";
    insurMeslabel2.textAlignment=NSTextAlignmentCenter;
    insurMeslabel2.adjustsFontSizeToFitWidth=YES;
    insurMeslabel2.textColor=UIColorFromRGBA(0x333333, 1.0);
    [insurView2 addSubview:insurMeslabel2];
    [insurMeslabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView2);
        make.top.mas_equalTo(insurpricelabel2.mas_bottom).offset(1/SCREEN_RATE1);
        make.height.offset(15/SCREEN_RATE1);
        make.width.offset(80/SCREEN_RATE);
    }];
    
    line2 = [UILabel new];
    line2.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [insurView2 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView2);
        make.top.mas_equalTo(insurMeslabel2.mas_bottom).with.offset(5/SCREEN_RATE1);
        make.height.offset(1);
        make.width.offset(110/SCREEN_RATE);
    }];
    
    insurMesbut2= [UIButton new];
    insurMesbut2.tag=202;
    [insurMesbut2 addTarget:self action:@selector(onclick:) forControlEvents:UIControlEventTouchUpInside];
    [insurMesbut2 setTitle:@"详情" forState:UIControlStateNormal];
    [insurMesbut2 setTitleColor:UIColorFromRGBA(0x333333, 1.0) forState:UIControlStateNormal];
    insurMesbut2.titleLabel.font=[UIFont systemFontOfSize:12];
    [insurView2 addSubview:insurMesbut2];
    [insurMesbut2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(insurView2);
        make.top.mas_equalTo(line2.mas_bottom).offset(0);
        make.height.offset(21/SCREEN_RATE1);
        make.width.offset(110/SCREEN_RATE);
    }];


    UIView * viewLine2 = [UILabel new];
    viewLine2.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [view addSubview:viewLine2];
    [viewLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15/SCREEN_RATE);
        make.top.mas_equalTo(insurView2.mas_bottom).with.offset(15/SCREEN_RATE1);
        make.height.offset(1);
        make.width.offset(360/SCREEN_RATE);
    }];
    
   //选择份数的视图
    UIView * viewNum = [UIView new];
    viewNum.backgroundColor=[UIColor whiteColor];
    [view addSubview:viewNum];
    [viewNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(0);
        make.top.mas_equalTo(viewLine2.mas_bottom).with.offset(0);
        make.height.offset(43/SCREEN_RATE1);
        make.width.offset(375/SCREEN_RATE);
    }];
    
    UITapGestureRecognizer *tapp3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeView:)];
    [viewNum addGestureRecognizer:tapp3];
    viewNum.tag=103;
    
    UILabel * labelpartTtile = [UILabel new];
    labelpartTtile.text=@"购买份数";
    labelpartTtile.adjustsFontSizeToFitWidth=YES;
    labelpartTtile.textColor=UIColorFromRGBA(0x333333, 1.0);
    [viewNum addSubview:labelpartTtile];
    [labelpartTtile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewNum).offset(15/SCREEN_RATE);
        make.top.equalTo(viewNum).offset(11/SCREEN_RATE1);
        make.height.offset(21/SCREEN_RATE1);
        make.width.offset(56/SCREEN_RATE);
    }];

    partNum = [UILabel new];
    partNum.text=[NSString stringWithFormat:@"%@份",_Num];
    partNum.textColor=UIColorFromRGBA(0x333333, 1.0);
    [viewNum addSubview:partNum];
    [partNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewNum).offset(-35/SCREEN_RATE);
        make.bottom.equalTo(viewNum).offset(-11/SCREEN_RATE1);
        make.height.offset(21/SCREEN_RATE1);
        make.width.offset(56/SCREEN_RATE);
    }];
    
    UIImageView * changeView = [UIImageView new];
    changeView.image=[UIImage imageNamed:@"chevron"];
    [viewNum addSubview:changeView];
    [changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewNum).offset(-15/SCREEN_RATE);
        make.bottom.equalTo(viewNum).offset(-15/SCREEN_RATE1);
        make.height.offset(13/SCREEN_RATE1);
        make.width.offset(8/SCREEN_RATE);
    }];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.5;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    [self.view addSubview:effectView];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60)];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [self.view addSubview:pickerView];
    [self loadPickerData];
    effectView.hidden=YES;
    UIView * vv = [[UIView alloc] initWithFrame:CGRectMake(0,deviceScreenHeight, self.view.frame.size.width, 40)];
    vv.userInteractionEnabled=YES;
    vv.tag=133;
    vv.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:vv];
   
    butclear=[[UIButton alloc]initWithFrame:CGRectMake(5,10, 30, 20)];
    butclear.tag=211;
    [butclear addTarget:self action:@selector(picker:) forControlEvents:UIControlEventTouchUpInside];
    [butclear setTitle:@"取消" forState:UIControlStateNormal];
    [vv addSubview:butclear];
    [butclear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vv).offset(10);
        make.top.equalTo(vv).offset(10);
        make.height.offset(20);
        make.width.offset(40);
    }];
    butchange=[[UIButton alloc]initWithFrame:CGRectMake(5,10, 30, 20)];
    butchange.tag=212;
    [butchange addTarget:self action:@selector(picker:) forControlEvents:UIControlEventTouchUpInside];
    [butchange setTitle:@"确定" forState:UIControlStateNormal];
    [vv addSubview:butchange];
    [butchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(vv).offset(-10);
        make.top.equalTo(vv).offset(10);
        make.height.offset(20);
        make.width.offset(40);
    }];

    if ([_insuranceType isEqualToString:@"1"]) {
        type2=-1;
        type1=1;
        insurView1.layer.borderColor =[UIColorFromRGBA(0xee7800, 1.0) CGColor];
        selectImv1.image=[UIImage imageNamed:@"insurance-on"];
        insurlabel.textColor=UIColorFromRGBA(0x333333, 1.0);
        insurpricelabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
        insurMeslabel.textColor=UIColorFromRGBA(0x333333, 1.0);
        line1.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        [insurMesbut setTitleColor:UIColorFromRGBA(0x333333, 1.0) forState:UIControlStateNormal];
        
        insurView2.layer.borderColor =[UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
        selectImv2.image=[UIImage imageNamed:@"insurance-off"];
        insurlabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        insurpricelabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        insurMeslabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        line2.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        [insurMesbut2 setTitleColor:UIColorFromRGBA(0xb2b2b2, 1.0) forState:UIControlStateNormal];
        
    }else{
        type2=1;
        type1=-1;
        insurView2.layer.borderColor =[UIColorFromRGBA(0xee7800, 1.0) CGColor];
        selectImv2.image=[UIImage imageNamed:@"insurance-on"];
        insurlabel2.textColor=UIColorFromRGBA(0x333333, 1.0);
        insurpricelabel2.textColor=UIColorFromRGBA(0xee7800, 1.0);
        insurMeslabel2.textColor=UIColorFromRGBA(0x333333, 1.0);
        line2.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        [insurMesbut2 setTitleColor:UIColorFromRGBA(0x333333, 1.0) forState:UIControlStateNormal];
        
        insurView1.layer.borderColor =[UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
        selectImv1.image=[UIImage imageNamed:@"insurance-off"];
        insurlabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        insurpricelabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        insurMeslabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        line1.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
        [insurMesbut setTitleColor:UIColorFromRGBA(0xb2b2b2, 1.0) forState:UIControlStateNormal];
    }
    
    
    _infoconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _infoconnetview.backgroundColor=[UIColor blackColor];
    _infoconnetview.alpha=0.7;
    [self.view  addSubview:_infoconnetview];
    
    // UIView * taview1 =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 60, 375, deviceScreenHeight-60)]];
    scrollView = [[UIScrollView alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 60, 375, deviceScreenHeight)]];
    
    view1 = [[UIView alloc]init];
    [scrollView addSubview:view1];
    
    
    tglabel1 = [[UILabel alloc]init];
//    tglabel1.font=[UIFont systemFontOfSize:13];
    tglabel1.textColor=[UIColor whiteColor];
    //自动折行设置
    tglabel1.lineBreakMode = UILineBreakModeWordWrap;
    tglabel1.numberOfLines = 0;
    messageInsur =insureMess1;
   
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:messageInsur];
    
    tglabel1.attributedText=att;
    CGSize labelsize = [self attributeString:att boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT)];
    
    NSLog(@"%f",labelsize.height);
  
    view1.frame = CGRectMake(20, 0, deviceScreenWidth-40, labelsize.height+400/SCREEN_RATE1);
    scrollView.contentSize = CGSizeMake(0,labelsize.height+400/SCREEN_RATE1);
    
    [view1 addSubview:tglabel1];
   
    [tglabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(10));
        make.width.mas_equalTo(@(deviceScreenWidth-40));
        make.centerX.equalTo(view1);
    }];
    
    UITapGestureRecognizer *tab88 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab88:)];
    [scrollView addGestureRecognizer:tab88];
    [_infoconnetview addSubview:scrollView];
}
-(CGSize)attributeString:(NSAttributedString *)attString boundingRectWithSize:(CGSize)size {
    if (!attString) {
        return CGSizeZero;
    }
    return [attString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
}
#pragma mark -加载数据
-(void)loadDta{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    insurearray=[NSMutableArray new];
    //保险查询
    InsureQueryRequest * insure  = [InsureQueryRequest new];
    insure.Sycp=@"0100";
    insure.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    insure.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic InsureQueryRequest:insure success:^(id data) {
        NSLog(@"%@",data);
        [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"T"]) {
            insurearray=data[@"insuranceSpecieList"];
           
            insurpricelabel.text=[NSString stringWithFormat:@"￥%ld/份",(long)[data[@"insuranceSpecieList"][0][@"price"] intValue]];
            insurpricelabel2.text=[NSString stringWithFormat:@"￥%ld/份",(long)[data[@"insuranceSpecieList"][1][@"price"] intValue]];
        }
         } failure:^(NSError *error) {
               [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
#pragma mark -选择保险类型
-(void)changeView:(UITapGestureRecognizer*)tap{
    switch (tap.view.tag) {
        //保险类型1
        case 101:{
            if (type1==-1) {
                type2=-1;
                type1=1;
                insurView1.layer.borderColor =[UIColorFromRGBA(0xee7800, 1.0) CGColor];
                selectImv1.image=[UIImage imageNamed:@"insurance-on"];
                insurlabel.textColor=UIColorFromRGBA(0x333333, 1.0);
                insurpricelabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
                insurMeslabel.textColor=UIColorFromRGBA(0x333333, 1.0);
                line1.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                [insurMesbut setTitleColor:UIColorFromRGBA(0x333333, 1.0) forState:UIControlStateNormal];
                
                insurView2.layer.borderColor =[UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
                selectImv2.image=[UIImage imageNamed:@"insurance-off"];
                insurlabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurpricelabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurMeslabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                line2.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                [insurMesbut2 setTitleColor:UIColorFromRGBA(0xb2b2b2, 1.0) forState:UIControlStateNormal];
            }else{
                type1=-1;
                insurView1.layer.borderColor =[UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
                selectImv1.image=[UIImage imageNamed:@"insurance-off"];
                insurlabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurpricelabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurMeslabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                line1.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
                [insurMesbut setTitleColor:UIColorFromRGBA(0xb2b2b2, 1.0) forState:UIControlStateNormal];
            }
            break;
        }
        //保险类型2
        case 102:{
            if (type2==-1) {
                type2=1;
                type1=-1;
                insurView2.layer.borderColor =[UIColorFromRGBA(0xee7800, 1.0) CGColor];
                selectImv2.image=[UIImage imageNamed:@"insurance-on"];
                insurlabel2.textColor=UIColorFromRGBA(0x333333, 1.0);
                insurpricelabel2.textColor=UIColorFromRGBA(0xee7800, 1.0);
                insurMeslabel2.textColor=UIColorFromRGBA(0x333333, 1.0);
                line2.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                [insurMesbut2 setTitleColor:UIColorFromRGBA(0x333333, 1.0) forState:UIControlStateNormal];
                
                insurView1.layer.borderColor =[UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
                selectImv1.image=[UIImage imageNamed:@"insurance-off"];
                insurlabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurpricelabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurMeslabel.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                line1.backgroundColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                [insurMesbut setTitleColor:UIColorFromRGBA(0xb2b2b2, 1.0) forState:UIControlStateNormal];
            }else{
                type2=-1;
                insurView2.layer.borderColor =[UIColorFromRGBA(0xb2b2b2, 1.0) CGColor];
                selectImv2.image=[UIImage imageNamed:@"insurance-off"];
                insurlabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurpricelabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                insurMeslabel2.textColor=UIColorFromRGBA(0xb2b2b2, 1.0);
                line2.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
                [insurMesbut2 setTitleColor:UIColorFromRGBA(0xb2b2b2, 1.0) forState:UIControlStateNormal];
            }
            break;
        }
        //选择份数
        case 103:{
            [UIView animateWithDuration:0.5 animations:^{
                effectView.hidden=NO;
                // 设置view弹出来的位置
                pickerView.frame = CGRectMake(0, deviceScreenHeight-(self.view.frame.size.width/3+80), self.view.frame.size.width, self.view.frame.size.width/3+80);
                UIView * vv =(UIView*)[self.view viewWithTag:133];
                vv.frame = CGRectMake(0, deviceScreenHeight-(self.view.frame.size.width/3+120), self.view.frame.size.width, 40);
            }];
            break;
        }
        default:
            break;
    }
}
#pragma mark -返回
-(void)back:(UIButton*)but{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -完成
-(void)okbut:(UIButton*)but{
    NSMutableDictionary * dict  = [NSMutableDictionary new];
    if (type1==1) {
        NSString * str =[NSString stringWithFormat:@"%@",insurearray[0][@"price"]];
        [dict setValue:str forKey:@"inprice"];
        _InsuranceCode=insurearray[0][@"insuranceCode"];
        [dict setValue:_InsuranceCode forKey:@"insuranceCode"];
        [dict setValue:@"1"forKey:@"insuranceType"];
        [dict setValue:_Num forKey:@"num"];
    }
    if (type2==1) {
        NSString * str =[NSString stringWithFormat:@"%@",insurearray[1][@"price"]];
        [dict setValue:str forKey:@"inprice"];
        _InsuranceCode=insurearray[1][@"insuranceCode"];
        [dict setValue:_InsuranceCode forKey:@"insuranceCode"];
        [dict setValue:@"2"forKey:@"insuranceType"];
        [dict setValue:_Num forKey:@"num"];
    }
    if ((type2==-1 && type1==-1)||[_Num isEqualToString:@"0"] ) {
        [dict setValue:@"" forKey:@"inprice"];
        [dict setValue:@"" forKey:@"insuranceCode"];
    }
    if (_block) {
        _block(dict);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
  
}
-(void)picker:(UIButton*)send{
    UIView * vv=[UIView new];
    switch (send.tag) {
        case 211:
            self.tabBarController.tabBar.hidden=NO;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight-30, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            break;
        case 212:
            self.tabBarController.tabBar.hidden=NO;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight-30, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
          
            partNum.text=[NSString stringWithFormat:@"%@份",seatstring];
            _Num=seatstring;
            break;
        default:
            break;
    }
}
#pragma mark 设置滚动选择框
-(void)chick{
}
-(void)loadPickerData{
    _arr=@[@"0",@"1",@"2"];
    [pickerView reloadAllComponents];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _arr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _arr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:0];
    //    [pickerView selectRow:0 inComponent:0 animated:NO];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    seatstring = _arr[rowOne];
    //NSLog(@"%@",seatstring);
}
- (void)SelectInsureWithBlock:(SelectInsureBalock)block{
    _block=block;
}
-(void)onclick:(UIButton*)send{
    
    switch (send.tag) {
        case 201:{
            messageInsur =insureMess1;
            
            NSAttributedString *att = [[NSAttributedString alloc]initWithString:messageInsur];
            
            tglabel1.attributedText=att;
            CGSize labelsize = [self attributeString:att boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT)];
            
            view1.frame = CGRectMake(20, 0, deviceScreenWidth-40, labelsize.height+400/SCREEN_RATE1);
            scrollView.contentSize = CGSizeMake(0,labelsize.height+400/SCREEN_RATE1);

            break;
        }
        case 202:{
            messageInsur =insureMess2;
            
            NSAttributedString *att = [[NSAttributedString alloc]initWithString:messageInsur];
            
            tglabel1.attributedText=att;
            CGSize labelsize = [self attributeString:att boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT)];
            
            view1.frame = CGRectMake(20, 0, deviceScreenWidth-40, labelsize.height+400/SCREEN_RATE1);
            scrollView.contentSize = CGSizeMake(0,labelsize.height+400/SCREEN_RATE1);
           
            break;
        }
        default:
            break;
    }
    
    [UIView animateWithDuration:0.01 animations:^{
        _infoconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];

}

-(void)showGFtab88:(UITapGestureRecognizer *)tab88{
    
    [UIView animateWithDuration:0.01 animations:^{
        _infoconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.01 animations:^{
        _infoconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];

}
@end
