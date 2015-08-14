//
//  NetworkManager.m
//  BaoqianliShop
//
//  Created by ky on 15/8/12.
//  Copyright (c) 2015年 ky. All rights reserved.
//

#import "NetworkManager.h"

static NetworkManager *networkManger=nil;

@interface NetworkManager ()

@property (nonatomic,strong) AFHTTPRequestOperationManager *httpManager;

@end

@implementation NetworkManager

#pragma mark - 初始化网络请求单例

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        networkManger=[[self alloc]init];
   });
    
   return networkManger;
}

#pragma mark - get请求

- (void)getWithUrlString:(NSString *)sting successBlock:(SuccessBlock)success failBlock:(FailBlock)fail
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if(status==AFNetworkReachabilityStatusNotReachable){
            fail(@"网络不给力");
            [Tools myHud:@"网络不给力" inView:[UIApplication sharedApplication].keyWindow];
        
        } else{
            [self.httpManager GET:sting parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options: NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:nil];
                success(dict);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                fail([error description]);
                
            }];
        }
    }];
    //启动网络监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - post请求

- (void)postWithParam:(NSDictionary *)param urlString:(NSString *)string successBlock:(SuccessBlock)success failBlock:(FailBlock)fail
{
    //检测网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        if(status==AFNetworkReachabilityStatusNotReachable){
            fail(@"网络不给力");
            [Tools myHud:@"网络不给力" inView:[UIApplication sharedApplication].keyWindow];
            
        } else{
            [self.httpManager POST:string parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options: NSJSONReadingMutableLeaves|NSJSONReadingAllowFragments error:nil];
                success(dict);
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                fail([error description]);
            }];
        }
    }];
    //启动网络监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma mark - httpTest

- (void)httpTest
{
    NSDictionary *dict=@{@"API_VERSION" :[NSNumber numberWithInt:1],@"DEVICE_ID" : [NSNumber numberWithInt:1],@"TAG" :@"terminalManageInterfaceAction_queryIndexData.action",
                         @"USER_ID" :[NSNumber numberWithInt:1]};
    
    [[NetworkManager shareInstance] postWithParam:dict urlString:@"http://183.239.150.131:8000/n2p/mobileInterface/terminalManageInterfaceAction_queryIndexData.action" successBlock:^(NSDictionary *resultDict) {
        NSLog(@"%@",@"success");
    } failBlock:^(NSString *error) {
        
        NSLog(@"%@",error);
    }];
}

#pragma mark - getter

- (AFHTTPRequestOperationManager *)httpManager
{
    if(!_httpManager){
        
        _httpManager=[AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *request = [AFHTTPRequestSerializer serializer];
        request.timeoutInterval = 10.0f;
        _httpManager.requestSerializer = request;
        _httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    return _httpManager;
}


@end
