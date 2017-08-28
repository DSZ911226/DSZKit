//
//  DSZSSKeychain+DSZExt.m
//  Pods
//
//  Created by 胡浩 on 2017/6/9.
//
//

#import "DSZSSKeychain+DSZExt.h"

#define DSZ_SERVICE_NAME @"com.DSZon.MSX"
#define DSZ_ACCESS_TOKEN @"DSZ_accessToken"
#define DSZ_IP_ADDRESS @"DSZ_ipAddress"
#define DSZ_ACCOUNT_NAME @"DSZ_AccountName"


@implementation DSZSSKeychain (DSZExt)

+ (NSString *)accessToken {
    NSString *accessToken = [self passwordForService:DSZ_SERVICE_NAME account:DSZ_ACCESS_TOKEN];

    if (!accessToken || accessToken.length == 0) {
        return @"";
    }
    return accessToken;
}

+ (NSString *)accountName {
    NSString *name = [self passwordForService:DSZ_SERVICE_NAME account:DSZ_ACCOUNT_NAME];
    
    if (!name || name.length == 0) {
        return @"";
    }
    return name;
}

+ (NSString *)ipAddress {
    return [self passwordForService:DSZ_SERVICE_NAME account:DSZ_IP_ADDRESS];
}

+ (BOOL)setAccessToken:(NSString *)accessToken {
    return [self setPassword:accessToken forService:DSZ_SERVICE_NAME account:DSZ_ACCESS_TOKEN];
}

+ (BOOL)setAccountName:(NSString *)name {
    if (name.length == 0) {
        return NO;
    }

    return [self setPassword:name forService:DSZ_SERVICE_NAME account:DSZ_ACCOUNT_NAME];
}

+ (BOOL)setIPAddress:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }

    return [self setPassword:ipAddress forService:DSZ_SERVICE_NAME account:DSZ_IP_ADDRESS];
}

+ (BOOL)deleteAccessToken {
    return [self deletePasswordForService:DSZ_SERVICE_NAME account:DSZ_ACCESS_TOKEN];
}

+ (BOOL)deleteIPAddress {
    return [self deletePasswordForService:DSZ_SERVICE_NAME account:DSZ_IP_ADDRESS];
}

@end
