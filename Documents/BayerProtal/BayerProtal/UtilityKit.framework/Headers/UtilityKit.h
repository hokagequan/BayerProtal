//
//  UtilityKit.h
//  UtilityKit
//  源码： https://github.com/yinxianwei/JEUtilityKitDemo


/*
    iOS开发常用方法类别和常用宏定义  2.1
    更新日期：2014-08-11
 */

#import <Foundation/Foundation.h>
#import "UtilityTools.pch"
#import <UIKit/UIKit.h>

@interface UtilityKit : NSObject

@end


@interface NSObject (common)

/*!
 *  九宫格坐标计算
 *
 *  @param index           视图索引
 *  @param list            九宫格列数
 *  @param rectScope       九宫格视图所在范围
 *  @param viewSize        一格视图的大小
 *  @param intervalinFirst 第一列和最后一列是否有间隔
 *
 *  @return CGRect
 */
- (CGRect)scratchableLatex:(NSInteger)index list:(NSInteger)list sizeScope:(CGRect)rectScope viewSize:(CGSize)viewSize intervalinFirst:(BOOL)intervalinFirst;

@end

#pragma mark - UILabel +

@interface UILabel (label)

/*!
 *  创建UILabel（默认背景为透明，为适配iOS6和iOS7） PS.iOS6下创建的Label背景色默认为白色
 *
 *  @param frame frame
 *
 *  @return UILabel
 */
+ (instancetype)labelWithFrame:(CGRect)frame;

@end

#pragma mark - UIAlertView+

@interface UIAlertView(AlertView)
/**
 *  简单提示
 *
 *  @param string 提示内容
 */
+(void)showMessage:(NSString *)string;

@end


#pragma mark - NSString+

@interface NSString (String)

/**
 *  将路径追加在当前软件的根目录后
 *
 *  @return 返回追加后的路径
 */
-(NSString *)appendForPath;

/**
 *  NSString模糊查找
 *
 *  @param aString 查找内容
 *
 *  @return 返回查找结果
 */
-(BOOL)isContainOfString:(NSString *)aString;

/**
 *  去除字符串空格和换行
 *
 *  注:此方法只能去除首尾空格和换行
 *
 *  @return 返回去除后的字符串
 */
-(NSString *)Trim;

/**
 *  去除指定的字符
 *
 *  @param aString 要删除的字符
 *
 *  @return 返回删除后的结果
 */
-(NSString *)removeString:(NSString *)aString;

/**
 *  获取软件的Bundleidentifier
 *
 *  @return BundleID
 */
+(NSString *)fetchBundleidentifier;

/**
 *  获取当前软件版本
 *
 *  @return 软件版本
 */
+(NSString *)fetchBundleVersion;

/**
 *  星期大小写转换
 *
 *  @param week 1-7
 *
 *  @return 一-七
 */
+(NSString *)digitUppercase:(NSString *)week;

/**
 *  时间转换 2014-12-4 -->> 4/12
 *
 *  @return string
 */
-(NSString *)time;

/**
 *  根据字符获取长度
 *
 *  @param font 字体大小
 *  @param size view的size
 *
 *  @return CGSize
 */
-(CGSize)stringSizeWithFont:(UIFont *)font size:(CGSize)size;

-(CGSize)stringSizeWithFont:(UIFont *)font size:(CGSize)size breakmode:(NSLineBreakMode)model;

/**
 *  判断路径是否存在
 */
- (BOOL)isFileExist;

/**
 *  字符串归档
 *
 *  @param path 路径
 *  @param name 名字
 */
- (void)archiveRootToPath:(NSString *)path fileName:(NSString *)name;

/**
 *  字符串反归档
 *
 *  @param path 路径
 *  @param name 名字
 *
 *  @return NSString
 */

+ (NSString *)unarchiveToPath:(NSString *)path fileName:(NSString *)name;

/*
 *  是否为身份证
 */
- (BOOL)isIdentity;

/*!
 *  @"yyyy-MM-dd HH:mm"
 *
 *  @return NSDate
 */
- (NSDate *)fromDate;

/*!
 *  计算中英混合字符个数
 *
 *  @return 长度 example: 123发  return 5 ; 1234 return 4;
 */
-  (int)convertToInt;

@end

#pragma mark - NSDictionary+

@interface NSDictionary (Dict)

/**
 *  获取软件info-plist文件内容
 *
 *  @return 文件内容
 */
+(NSDictionary *)fetchInfoPlist;

@end

#pragma mark - NSArray+

@interface NSArray (ary)

/**
 *  数组中是否含有对象
 *
 *  @param obj 对象
 *
 *  @return bool
 */
- (BOOL)isIncludeObject:(id)obj;

/**
 *  数组归档
 *
 *  @param array 需要归档的
 *  @param name  文件名
 *  @param path  路径
 */
- (void)archiveRootToPath:(NSString *)path fileName:(NSString *)name;

/**
 *  反归档
 *
 *  @param path 路径
 *  @param name 文件名
 */
+ (NSArray *)unarchiveToPath:(NSString *)path fileName:(NSString *)name;

@end

#pragma mark - NSDate +

@interface NSDate (date)

/**
 *  获取本地当前时间
 *
 *  @return NSDate
 */
+ (NSDate *)dateNow;

/*!
 *  时间大小判断
 *
 *  @param date 判断 self 是否大于 date
 *
 *  @return BOOL
 */
- (BOOL)isBiggerDate:(NSDate *)date;

/*!
 *  时间格式化
 *
 *  @return 今天:(19:00)  昨天:(昨天:19:00) 本周:(星期一) 其它:(2014-08-01 19:00)
 */
- (NSString *)showTime;


+ (NSDate *)thisWeek;


@end

#pragma mark - UIImageView

@interface UIImageView (img)

/*!
 *  简单的缓存图片（不缓存内存，不缓存本地）
 *
 *  @param url   图片地址
 *  @param image 默认图片
 */
- (void)setImageURL:(NSString *)url defaultImg:(UIImage *)image;

@end

@interface UITableView (tab)

/*!
 *  清除多余分割线
 */
- (void)clearLine;

/*!
 *  清除背景
 */
- (void)clearBackground;

@end






