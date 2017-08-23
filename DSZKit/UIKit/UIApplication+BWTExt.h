//
//  UIApplication+BWTExt.h
//  BWT
//
//  Created by HuHao on 15/10/2.
//  Copyright © 2015年 BWT. All rights reserved.
//

#import <UIKit/UIKit.h>

/// Returns "Documents" folder in this app's sandbox.
NSString *BWTDocumentsPath(void);

/// Returns "Library" folder in this app's sandbox.
NSString *BWTLibraryPath(void);

/// Returns "Caches" folder in this app's sandbox.
NSString *BWTCachesPath(void);


@interface UIApplication (BWTExt)


/// "Documents" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *documentsURL;

/// "Caches" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *cachesURL;

/// "Library" folder in this app's sandbox.
@property (nonatomic, readonly) NSURL *libraryURL;

/// Application's Bundle Name (show in SpringBoard).
@property (nonatomic, readonly) NSString *appBundleName;

/// Application's Bundle ID.  e.g. "com.ibireme.MyApp"
@property (nonatomic, readonly) NSString *appBundleID;

/// Application's Version.  e.g. "1.2.0"
@property (nonatomic, readonly) NSString *appVersion;

/// Application's Build number. e.g. "123"
@property (nonatomic, readonly) NSString *appBuildVersion;

/// Whether this app is priated (not from appstore).
@property (nonatomic, readonly) BOOL isPirated;

/// Whether this app is being debugged (debugger attached).
@property (nonatomic, readonly) BOOL isBeingDebugged;

/// Current thread real memory used in byte. (-1 when error occurs)
@property (nonatomic, readonly) int64_t memoryUsage;

/// Current thread CPU usage, 1.0 means 100%. (-1 when error occurs)
@property (nonatomic, readonly) float cpuUsage;

@end
