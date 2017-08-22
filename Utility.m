

#import "Utility.h"


#define IOS7OrPlus ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
static NSString* keyMobile = @"mobile";
static NSString* keyUserName = @"userName";
static NSString *keySecret = @"secret";
static NSString *keyUserid = @"userid";
static NSString *keyPassword = @"password";
static NSUserDefaults* userDefaults = nil;

@implementation Utility

+(void)initialize
{
    if (self == [Utility self]) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
}
+(NSDate *)buildDate:(NSObject *)date{
    if ([date isKindOfClass:[NSNumber class]]){
        return [NSDate dateWithTimeIntervalSince1970:([(NSNumber*)date longLongValue])];
    }else{
        return [NSDate date];
    }
}

+(NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

/**
 * 计算指定时间与当前的时间差
 * @param compareDate   某一指定时间
 * @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
 */
+(NSString *) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    NSInteger temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%@分前",@(temp)];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%@小时前",@(temp)];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%@天前",@(temp)];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%@个月前",@(temp)];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%@年前",@(temp)];
    }
    
    return  result;
}

+ (NSNumber *)numberFromDate:(NSDate *)date{
    NSTimeInterval time = [date timeIntervalSince1970];
    long long int dd = (long long int)time;
    NSNumber *dateNum = [NSNumber numberWithLongLong:dd];
    return dateNum;
}

+(CGSize)getSizeOfContent:(NSString *)str width:(CGFloat)width font:(CGFloat)font{
    CGSize size =CGSizeMake(width,CGFLOAT_MAX);
    UIFont *tfont = [UIFont systemFontOfSize:font];
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    CGSize  actualsize;
    if(IOS7OrPlus){
        actualsize =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    }
    //    else if (IOS7Below){
    //        actualsize = [str sizeWithFont:tfont constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    //    }
    //强制转化为整型(比初值偏小)，因为float型size转到view上会有一定的偏移，导致view setBounds时候 错位
    CGSize contentSize =CGSizeMake((NSInteger)actualsize.width, (NSInteger)actualsize.height + 1);
    return contentSize;
    
}

+ (NSString *)getRandomStringOfLength:(int)length
{
    NSArray *strArr = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil] ;
    NSMutableString *getStr = [[NSMutableString alloc]initWithCapacity:length];
    for(int i = 0; i < length; i++) //得到length位随机字符,可自己设长度
    {
        int index = arc4random() % ([strArr count]);  //得到数组中随机数的下标
        [getStr appendString:[strArr objectAtIndex:index]];
        
    }
    return getStr;
}

+(NSString *)encryptShow:(NSString *)content startingPosition:(NSInteger)startingPosition length:(NSInteger)length
{
    if(content.length){
        NSMutableString *mutStr  = [[NSMutableString alloc]initWithString:content];
        NSRange range     = NSMakeRange(startingPosition, length);
        NSString *temp    = [mutStr substringWithRange:range];
        NSString * string = @"";
        for(NSInteger i = 0;i< length ;i++){
            string = [string stringByAppendingString:@"*"];
        }
        [mutStr replaceOccurrencesOfString:temp withString:string options:NSCaseInsensitiveSearch range:range];
        
        return mutStr;
    }
    else
    {
        return nil;
    }
}

+(NSString *)encryptShow:(NSString *)content startingPosition:(NSInteger)startingPosition endPosition:(NSInteger)endPosition
{
    NSInteger lenght  = content.length - startingPosition - endPosition;
    NSString *mutStr = [self encryptShow:content startingPosition:startingPosition length:lenght];
    
    return mutStr;
}

//手机号以13， 15，18开头 =＝＝新增145,7和170,1,3,6,7,8号段＝＝＝ ，11个 \d 数字字符
+(BOOL)checkPhone:(NSString *)phone
{
    NSString *phoneRegex = @"^((13[0-9])|(14[5|7])|(15[^4,\\D])|(18[0,0-9])|(17[0|1|3|6|7|8]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:phone];
}


+(NSString *)priceChange:(float )price
{
    NSNumberFormatter *formatte = [[NSNumberFormatter alloc]init];
    formatte.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *str = [formatte stringFromNumber:[formatte numberFromString:[NSString stringWithFormat:@"%.2f",price]]];
    return str;
}

/*
 一段文字显示不同的颜色
 */

//+(NSMutableAttributedString *)changTextColor:(NSString *)contentStr
//{
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:contentStr];
//    
//    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
//                           [AppAppearance sharedAppearance].title2TextColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName,nil, nil];
//    
//    NSDictionary *attrs2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                            [AppAppearance sharedAppearance].mainColor,NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName,nil, nil];
//    
//    [str setAttributes:attrs range:NSMakeRange(0, 2)];
//    [str setAttributes:attrs2 range:NSMakeRange(3, str.length-3)];
//    
//    return str;
//}



+ (UIImage *)imageWithUIView:(UIView*)view
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}


+ (NSString *)subStringWithCardNo:(NSString *)cardNo
{
    if (cardNo.length) {
        NSMutableString *mutiStr = [[NSMutableString alloc] initWithString:cardNo];
        NSRange range = NSMakeRange(4, cardNo.length-8);
        NSString *occurStr = [cardNo substringWithRange:range];
        NSString *replaceStr = @"****";
        [mutiStr replaceOccurrencesOfString:occurStr withString:replaceStr options:NSCaseInsensitiveSearch range:range];
        return mutiStr;
    }
    return nil;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


//计算两个经纬度之间的距离
#define PI 3.1415926
+(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}


//对UILabel的字体属性的设置方法
+(UILabel *)customLabel:(NSString *)title
{
    UILabel *label         = [[UILabel alloc] init];
    label.backgroundColor  = [UIColor clearColor];
    label.textColor        = [AppAppearance sharedAppearance].title2TextColor;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    /*label.font = [UIFont fontWithName:@"Helvetica" size:15.f];
     @"Helvetica"是字体的样式，也就是字体的风格，相当于宋体、楷体等。
     常用的字体有Arial,Helvetica等,要加粗就在其后加"-Bold"，如，@"Helvetica-Bold"。
     */
    //label.font             = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    label.font             = [MyAdapter fontADapter:14];
    label.text             = title;
    
    return label;
}


@end



#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSString *) md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
