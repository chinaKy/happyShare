//
//  NetworkManager.h
//  BaoqianliShop
//
//  Created by ky on 15/8/12.
//  Copyright (c) 2015年 ky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^SuccessBlock)(NSDictionary *resultDict);
typedef void(^FailBlock)(NSString *error);

@interface NetworkManager : NSObject

/*
 ** 初始化网络请求单例
 */
+ (instancetype)shareInstance;

/*
 ** get请求方法
 ** @param,string:请求的url,success:成功回调block,fail:失败回调block
 */
- (void)getWithUrlString:(NSString *)sting successBlock:(SuccessBlock)success failBlock:(FailBlock)fail;

/*
 ** post请求方法
 ** @param,param:post请求参数,string:请求的url,success:成功回调block,fail:失败回调block
 */
- (void)postWithParam:(NSDictionary *)param urlString:(NSString *)string successBlock:(SuccessBlock)success failBlock:(FailBlock)fail;

- (void)httpTest;

@end
