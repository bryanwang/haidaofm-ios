//
//  AppUtil.h
//  meizhai-iphone
//
//  Created by YUXIN YANG on 12-3-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CCNSNotificationCenter.h"
#import "AFHTTPClient.h"

@interface AppUtil : NSObject

+(NSString*)intToString:(int)value;
+(NSString*)doubleToString:(double)value;
+(NSString*)floatToString:(float)value;
+(NSString *)md5:(NSString *)str;

//大小变化动画
+ (CAAnimation *)animationWithScaleFrom:(CGFloat) from To:(CGFloat) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime;

//位置变化动画
+ (CAAnimation *)animationMoveFrom:(CGPoint) from To:(CGPoint) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime;

//透明度变化动画
+ (CAAnimation *)animationWithOpacityFrom:(CGFloat) from To:(CGFloat) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime;


//跳转到appstore 评论页
+ (void)redirectToAppStoreCommentsPage;

+ (UIColor *)makeColorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

@end


#pragma Paging
@interface Paging : NSObject

@property(nonatomic) int pageSize;
@property(nonatomic) long rowCount;//总记录数
@property(nonatomic) long current;//当前页
@property(nonatomic) long pageCount;//总页数
@property(nonatomic) BOOL isEnd; //是否所有加载完成
@property(nonatomic) BOOL isLoading; //是否正在加载

- (id)initPagingWithPageSize: (int)size;

@end


enum {
    MODEL_IPHONE_SIMULATOR,
    MODEL_IPOD_TOUCH,
    MODEL_IPHONE,
    MODEL_IPHONE_3G,
    MODEL_IPAD
};

#pragma Device Detection
@interface DeviceDetection : NSObject

+ (uint) detectDevice;
+ (NSString *) returnDeviceName:(BOOL)ignoreSimulator;
+ (BOOL) isIPodTouch;
+ (BOOL) isOS4;
+ (BOOL) canSendSms;

@end

#pragma HPDraw slider
@interface HDDraw: NSObject
+ (void)redrawSlider: (UISlider *)slider;
@end

#pragma Photo picker
@protocol HDPhotoPickerDelegate;
@interface HDPhotoPicker : NSObject <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) id <HDPhotoPickerDelegate> delegate;
@property (nonatomic, strong) UIActionSheet *actionSheet;

- (void)createPhotoPickerActionSheet;


@end

@protocol HDPhotoPickerDelegate
@optional
- (void)didPhotoChoosed: (UIImage *)photo;
@end



#pragma HDForm
@protocol HDFormDeleagte;

@interface HDForm : NSObject <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UIToolbar *keyboardToolbar;
@property (strong, nonatomic) UIDatePicker *birthdayDatePicker;
@property (strong, nonatomic) UIPickerView *genderPickerView;

@property (strong, nonatomic)id <HDFormDeleagte> delegate;

@property (readwrite) int fieldCount;

- (void)animateView:(NSUInteger)tag;
- (void)goToNext: (NSInteger)tag;
- (void)restViewFrame;

@end

@protocol HDFormDeleagte
@optional
- (void)setBirthdayData;
- (void)setGenderData;
@end

@interface HDHttpClient : AFHTTPClient

+ (HDHttpClient *)shareIntance;

@end

typedef void(^weiboSignInSuccessCallback)();

@interface HDUserInfo : NSObject

+ (BOOL) hasSignIn;
+ (NSDictionary *) fetchUserInfo;
+ (void) logOutCurrentUser;
+ (void)saveTheUserInfo: (NSDictionary *)info;
+ (void)signInWithWeiboAccountBySuccessCallback: (weiboSignInSuccessCallback)success;
@end

