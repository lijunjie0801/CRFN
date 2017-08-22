



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface Utility : NSObject

+(CGSize)getSizeOfContent:(NSString *)str width:(CGFloat)width font:(CGFloat)font;

+(NSString *)stringFromDate:(NSDate *)date;
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+(NSString *)encryptShow:(NSString *)content startingPosition:(NSInteger)startingPosition length:(NSInteger)length;
+(NSString *)encryptShow:(NSString *)content startingPosition:(NSInteger)startingPosition endPosition:(NSInteger)endPosition;
+(BOOL)checkPhone:(NSString *)phone;

+(NSString *)priceChange:(float )price;

//+ (NSString *)subPriceString:(NSString *)priceString withReserveNumber:(NSInteger)number;

+ (UIImage *)imageWithUIView:(UIView*)view;

//格式化银行卡字符串
+ (NSString *)subStringWithCardNo:(NSString *)cardNo;

//把json格式字符串转换成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//银行卡相关
+ (NSString *)getBankNameWithCardNo:(NSString *)cardNo;

+ (BOOL)isValidCardNo:(NSString *)cardNo;

+ (NSString *)searchBankIdWithName:(NSString *)bankName;

+ (NSArray *)bankInfoWithCardType:(NSString *)cardType;

//对一段文字显示不同的颜色
+(NSMutableAttributedString *)changTextColor:(NSString *)contentStr;
//对UILabel的字体属性的设置方法
+(UILabel *)customLabel:(NSString *)title;

//计算连个经纬度之间的距离
+(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;

@end


@interface NSString (MD5)

- (NSString *) md5;

@end
