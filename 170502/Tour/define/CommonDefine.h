//
//  CommonDefine.h
//  城市列表
//
//  Created by 蒙奇D路飞 on 16/9/19.
//  Copyright © 2016年 com.smh.pcn. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG

#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<（文件名）%s : （行号）%d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-----*🙂*-----*😡*---*😂*----*💔*-----**----\n\n");                                               \
} while (0)
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
#else
#define NSLog(FORMAT, ...) nil
#define NSLogRect(rect) nil
#define NSLogSize(size) nil
#define NSLogPoint(point) nil
#endif

//clolor

#define pricecolor [UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1]

//是否IOS7
#define IOS_7 ( [[UIDevice currentDevice].systemVersion doubleValue] >= 7.0f)
#define IOS_8 ( [[UIDevice currentDevice].systemVersion doubleValue] >= 8.0f)
// UI高度常量
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenFull [UIScreen mainScreen].bounds


#define CGRectSetX(rect, x) rect = CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height)
#define CGRectSetY(rect, y) rect = CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height)
#define CGRectSetWidth(rect, w) rect = CGRectMake(rect.origin.x, rect.origin.y, w, rect.size.height)
#define CGRectSetHeight(rect, h) rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, h)
//GRB
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:alphaValue]




#endif /* CommonDefine_h */
