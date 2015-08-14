//
//  Tools.m
//  youmai
//
//  Created by bu88 on 14-10-27.
//  Copyright (c) 2014年 lindu. All rights reserved.
//

#import "Tools.h"
//#import "UMSocial.h"

@implementation Tools

+ (BOOL) isIphone4s {
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (size.width == 320.0f && size.height == 480.0f) {
        return YES;
    }
    return NO;
}

+ (void) myHud:(NSString *)str inView:(UIView *)view {
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.margin=12.0;
    [view addSubview:hud];
    hud.labelText = str;
    [hud show:YES];
    [hud hide:YES afterDelay:1.5];
}

+ (void) myAlert:(NSString *)str {
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"注意" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)myAlert:(NSString *)str target:(id)target 
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:target cancelButtonTitle:nil otherButtonTitles:@"确定",@"取消", nil];
    [alert show];
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (ZYWeekDayEnum) todayIs {
    NSDateFormatter *fmtter =[[NSDateFormatter alloc] init];
    [fmtter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [fmtter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [fmtter setDateFormat:@"EEE"];
    NSString* dayString = [fmtter stringFromDate:[NSDate date]];
    if (nil == dayString) {
        return UnKnow;
    }
    
    if ([dayString hasPrefix:@"Mon"]) {
        return Monday;
    }
    if ([dayString hasPrefix:@"Tue"]) {
        return Tuesday;
    }
    if ([dayString hasPrefix:@"Wed"]) {
        return Wednesday;
    }
    if ([dayString hasPrefix:@"Thu"]) {
        return Thursday;
    }
    if ([dayString hasPrefix:@"Fri"]) {
        return Friday;
    }
    if ([dayString hasPrefix:@"Sat"]) {
        return Saturday;
    }
    if ([dayString hasPrefix:@"Sun"]) {
        return Sunday;
    }
    return UnKnow;
}

+ (BOOL) isMobileNum:(NSString*)mobileNum {
    if([self isBlankString: mobileNum]){
        return NO;
    }
    
    if(mobileNum.length > 11){
        return NO;
    }
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,134,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

+ (void)searchBarToClearWithSearchBar:(UISearchBar *)searchBar {
    for (UIView *view in searchBar.subviews) {
        if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending){
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                break;
            }
        }else{
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
                break;
            }
        }
    }
}

+ (BOOL) isPureInt:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return ([scan scanInt:&val] && [scan isAtEnd]);
}

+ (NSMutableAttributedString *) getAttributedStringWithString:(NSString *)string {
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor groupTableViewBackgroundColor] range:NSMakeRange(0, string.length)];
    return attri;
}

+ (void) showMBProgressHUD {
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

+ (void) hideMBProgressHUD {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

+ (UITableView *)tableViewWithFrame:(CGRect)frame style:(UITableViewStyle)style delegate:(id)delegete dataSource:(id)dataSource
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:style];
   // tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollEnabled = YES;
   // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.delegate = delegete;
    tableView.dataSource = dataSource;
    return tableView;
}

+ (CGSize)stringSizeWithString:(NSString *)str attributes:(NSDictionary *)attributes {
    return [str sizeWithAttributes:attributes];
}

+ (CGSize)stringSizeWithSting:(NSString *)str Font:(UIFont *)stringFont boundRect:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: stringFont};
    CGSize strSize = [str boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return strSize;
}



#pragma mark - 友盟分享,target不能为nil

//+ (void)umShareWithTarget:(id)target shareText:(NSString *)text shareImage:(UIImage *)image 
//{
//    UIImage *tempImage=image;
//    if(tempImage==nil)
//        tempImage=IMAGE(@"person_icon");
//    if(text==nil)
//        text=@"P2N信息发布系统";
//    [UMSocialSnsService presentSnsIconSheetView:target appKey:UMAppkey shareText:text shareImage:tempImage shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToSms] delegate:target];
//}

@end
