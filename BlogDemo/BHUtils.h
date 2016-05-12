//
//  BHUtils.h
//  SportZone
//
//  Created by BinHan on 15/3/19.
//  Copyright (c) 2015年 BinHan. All rights reserved.
//

#ifdef DEBUG
    #define BHLog(...) NSLog(__VA_ARGS__)
#else
    #define BHLog(...)
#endif

/**
 *  不需要缓存的时候不建议使用
 */
#define BHIMG(str) [UIImage imageNamed:(str)]

#define IOS_VERSION_ABOVE(x) ([[UIDevice currentDevice].systemVersion doubleValue] >= x) // 判断系统

#define YES_OBJ		@1.0
#define NO_OBJ		nil

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

// 是否模拟器
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

#define SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)

#define SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#define iPad ((int)[[UIScreen mainScreen] bounds].size.width==768)

#define iPhone6Plus ((int)[[UIScreen mainScreen] bounds].size.width==414)

#define iPhone6 ((int)[[UIScreen mainScreen] bounds].size.width==375)

#define iPhone ((int)[[UIScreen mainScreen] bounds].size.width==320)

/**
 *  navigationBar的高度
 */
FOUNDATION_EXTERN double const kNavBarHeight;

@interface BHUtils : NSObject

/*
 * 16进制颜色(html颜色值)字符串转为UIColor
 */
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;

/*
 *判断字符串是否为空  建议使用此方法 否则会出现莫名其妙的Bug
 */
+ (BOOL)isBlankString:(NSString *)string;

/*
 *  使用UIColor创建UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  随机出一个色值
 *
 *  @return
 */
+(UIColor *) randomColor;

/**
 *  提醒
 *
 *  @param message <#message description#>
 */
+ (void)showMessage:(NSString *)message;

/**
 *  更具系统当前时间生成随机文件名
 *
 *  @return 返回文件名
 */
+(NSString *)randFileName;

@end
