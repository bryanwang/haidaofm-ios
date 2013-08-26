#import "AppUtil.h"
#import "AFJSONRequestOperation.h"
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import <sys/utsname.h>
#import <ShareSDK/ShareSDK.h>

@implementation AppUtil

+ (UIColor *)makeColorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f  blue:blue/255.0f alpha:1.0f];
}

+(NSString*)intToString:(int)value{
	return [NSString stringWithFormat:@"%d",value];
}
+(NSString*)doubleToString:(double)value{
	return [NSString stringWithFormat:@"%f",value];
}
+(NSString*)floatToString:(float)value{
	return [NSString stringWithFormat:@"%f",value];
}

+(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *temp = [NSString stringWithFormat:
                      @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                      result[0], result[1], result[2], result[3],
                      result[4], result[5], result[6], result[7],
                      result[8], result[9], result[10], result[11],
                      result[12], result[13], result[14], result[15]
                      ];
    return [temp lowercaseString];
}

//位置变化动画
+ (CAAnimation *)animationMoveFrom:(CGPoint) from To:(CGPoint) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime
{
	CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	CGFloat animationDuration = duration;
	CGMutablePathRef thePath = CGPathCreateMutable();
	CGPathMoveToPoint(thePath, NULL, from.x, from.y);
	CGPathAddLineToPoint(thePath, NULL, to.x, to.y);
	bounceAnimation.path = thePath;
	bounceAnimation.duration = animationDuration;
    bounceAnimation.beginTime = beginTime;
	bounceAnimation.repeatCount=0;
	bounceAnimation.removedOnCompletion=NO;
	bounceAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	CGPathRelease(thePath);
	
	return bounceAnimation;
}

//大小变化动画
+ (CAAnimation *)animationWithScaleFrom:(CGFloat) from To:(CGFloat) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=duration;
    theAnimation.beginTime = beginTime;
    theAnimation.repeatCount=0;
    theAnimation.autoreverses=NO;
    theAnimation.fromValue=[NSNumber numberWithFloat:from];
    theAnimation.toValue=[NSNumber numberWithFloat:to];
    
    return theAnimation;
}

//透明度变化动画
+ (CAAnimation *)animationWithOpacityFrom:(CGFloat) from To:(CGFloat) to Duration:(CGFloat) duration BeginTime:(CGFloat)beginTime 
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    theAnimation.duration=duration;
    theAnimation.beginTime = beginTime;
    theAnimation.repeatCount=0;
    theAnimation.autoreverses=NO;
    theAnimation.fromValue=[NSNumber numberWithFloat:from];
    theAnimation.toValue=[NSNumber numberWithFloat:to];
    
    return theAnimation;
}

+ (void)redirectToAppStoreCommentsPage
{
    NSString *str = [NSString stringWithFormat:
                     @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
                     APP_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

@end


@implementation DeviceDetection

+ (BOOL) isIPodTouch
{
    int model = [DeviceDetection detectDevice];
    if (model == MODEL_IPOD_TOUCH || model == MODEL_IPAD){
        //|| model == MODEL_IPHONE_SIMULATOR){
        return YES;
    }
    else {
        return NO;
    }
	
}

+ (BOOL) isOS4
{
    // TBD
    
    return YES;
    
}

+ (BOOL)canSendSms
{
    return [MFMessageComposeViewController canSendText];
}

+ (uint) detectDevice {
    NSString *model= [[UIDevice currentDevice] model];
    
    // Some iPod Touch return "iPod Touch", others just "iPod"
    
    NSString *iPodTouch = @"iPod Touch";
    NSString *iPodTouchLowerCase = @"iPod touch";
    NSString *iPodTouchShort = @"iPod";
    NSString *iPad = @"iPad";
    
    NSString *iPhoneSimulator = @"iPhone Simulator";
    
    uint detected;
    
    if ([model compare:iPhoneSimulator] == NSOrderedSame) {
        // iPhone simulator
        detected = MODEL_IPHONE_SIMULATOR;
    }
    else if ([model compare:iPad] == NSOrderedSame) {
        // iPad
        detected = MODEL_IPAD;
    } else if ([model compare:iPodTouch] == NSOrderedSame) {
        // iPod Touch
        detected = MODEL_IPOD_TOUCH;
    } else if ([model compare:iPodTouchLowerCase] == NSOrderedSame) {
        // iPod Touch
        detected = MODEL_IPOD_TOUCH;
    } else if ([model compare:iPodTouchShort] == NSOrderedSame) {
        // iPod Touch
        detected = MODEL_IPOD_TOUCH;
    } else {
        // Could be an iPhone V1 or iPhone 3G (model should be "iPhone")
        struct utsname u;
        
        // u.machine could be "i386" for the simulator, "iPod1,1" on iPod Touch, "iPhone1,1" on iPhone V1 & "iPhone1,2" on iPhone3G
        
        uname(&u);
        
        if (!strcmp(u.machine, "iPhone1,1")) {
            detected = MODEL_IPHONE;
        } else {
            detected = MODEL_IPHONE_3G;
        }
    }
    return detected;
}

+ (NSString *) returnDeviceName:(BOOL)ignoreSimulator {
    NSString *returnValue = @"Unknown";
    
    switch ([DeviceDetection detectDevice]) {
        case MODEL_IPHONE_SIMULATOR:
            if (ignoreSimulator) {
                returnValue = @"iPhone 3G";
            } else {
                returnValue = @"iPhone Simulator";
            }
            break;
        case MODEL_IPOD_TOUCH:
            returnValue = @"iPod Touch";
            break;
        case MODEL_IPHONE:
            returnValue = @"iPhone";
            break;
        case MODEL_IPHONE_3G:
            returnValue = @"iPhone 3G";
            break;
        default:
            break;
    }
    
    return returnValue;
}

@end


@implementation Paging
@synthesize pageSize, rowCount, current, pageCount, isEnd, isLoading;

- (id)initPagingWithPageSize:(int)size
{
    self = [self init];
    if (self) {
        self.pageSize = size;
        self.current = 0;
        self.isEnd = NO;
        self.isLoading = NO;
    }
    
    return self;
}

@end


@implementation HDDraw
+ (void)redrawSlider: (UISlider *)slider
{
    slider.backgroundColor = [UIColor clearColor];
    UIImage *stetchTrack = [[UIImage imageNamed:@"slierTrack.png"]
                            stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    [slider setThumbImage: [UIImage imageNamed:@"sliderKey.png"] forState:UIControlStateNormal];
    [slider setMinimumTrackImage:stetchTrack forState:UIControlStateNormal];
    [slider setMaximumTrackImage:stetchTrack forState:UIControlStateNormal];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * -0.5);
    slider.transform = trans;

}


@end



@implementation HDPhotoPicker

@synthesize delegate = _delegate;
@synthesize actionSheet = _actionSheet;

- (void)createPhotoPickerActionSheet
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"choose photo", @"")
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"take photo from camera", @""), NSLocalizedString(@"take photo from library", @""), nil];
    } else {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"choose photo", @"")
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"cancel", @"")
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"take photo from library", @""), nil];
    }
    
    [self.actionSheet showInView: ((UIViewController *)self.delegate).view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 2:
                return;
        }
    } else {
        if (buttonIndex == 1) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
	[(UIViewController *)self.delegate presentModalViewController:imagePickerController animated:YES];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissModalViewControllerAnimated:YES];
	UIImage  *photo = [info objectForKey:UIImagePickerControllerEditedImage];
	
    [self.delegate didPhotoChoosed:photo];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[(UIViewController *)self.delegate dismissModalViewControllerAnimated:YES];
}

@end




@interface HDForm() {
    UISegmentedControl *prevNext;
    UIView *baseView;
    NSInteger currentTextFieldTag;
    float currentKeyboardHeight;
}

@end

@implementation HDForm

@synthesize keyboardToolbar = _keyboardToolbar;
@synthesize fieldCount = _fieldCount;
@synthesize birthdayDatePicker = _birthdayDatePicker;
@synthesize genderPickerView = _genderPickerView;

@synthesize delegate = _delegate;

- (void)setDelegate:(id<HDFormDeleagte>)delegate
{
    if (_delegate == nil) {
        _delegate = delegate;
        baseView = ((UIViewController *)self.delegate).view;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restViewFrame) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


-(void)restViewFrame
{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.3f];
    baseView.frame = CGRectMake(0.0f, 0.0f, baseView.frame.size.width, baseView.frame.size.height);
    [UIView commitAnimations];
}

- (void) goToNext: (NSInteger)tag
{
    NSInteger nextTag = tag == self.fieldCount ? self.fieldCount : tag + 1;
    UITextField *field = (UITextField *)[baseView viewWithTag:nextTag];
    [field becomeFirstResponder];
}

- (void)goToPrev: (NSInteger)tag
{
    NSInteger nextTag = tag == 1 ? 1: tag - 1;
    UITextField *field = (UITextField *)[baseView viewWithTag:nextTag];
    [field becomeFirstResponder];
}


- (id)getFirstResponder
{
    NSUInteger index = 0;
    while (index <= self.fieldCount) {
        UITextField *textField = (UITextField *)[baseView viewWithTag:index];
        if ([textField isFirstResponder]) {
            return textField;
        }
        index++;
    }
    
    return nil;
}



- (void) handleActionBarPreviousNext:(UISegmentedControl *)control
{
    id firstResponder = [self getFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        const BOOL isNext = control.selectedSegmentIndex == 1;
        isNext? [self goToNext:[firstResponder tag]]
               :[self goToPrev:[firstResponder tag]];
    }
}

- (void)handleDoneClicked:(id)sender
{
    id firstResponder = [self getFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        [firstResponder resignFirstResponder];
    }
}

- (void)animateView:(NSUInteger)tag
{
    [self updatePrevNextStatus:tag];
    currentTextFieldTag = tag;
    
    UITextField *textField = (UITextField *)[baseView viewWithTag:currentTextFieldTag];
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:0.3f];
    
    baseView.frame = CGRectMake(0.0f,
                                -textField.frame.origin.y + 80.0f < 0.0f?
                                -textField.frame.origin.y + 80.0f : 0.0f,
                                baseView.frame.size.width,
                                baseView.frame.size.height);
    
    [UIView commitAnimations];
    
}


- (void)updatePrevNextStatus:(NSUInteger)tag {
    UITextField *field = (UITextField *)[baseView viewWithTag:tag];
    field.returnKeyType = tag == self.fieldCount ? UIReturnKeyDone : UIReturnKeyNext;
    [prevNext setEnabled:tag == 1 ? NO : YES forSegmentAtIndex:0];
    [prevNext setEnabled:tag == self.fieldCount ? NO : YES forSegmentAtIndex:1];
}


- (UIToolbar *)keyboardToolbar
{
    if (_keyboardToolbar == nil) {
        _keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, baseView.bounds.size.width, KEYBOARD_TOOL_HEIGHT)];
        _keyboardToolbar.barStyle = UIBarStyleBlackOpaque;
        
        prevNext = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:NSLocalizedString(@"Previous", @""), NSLocalizedString(@"Next", @""), nil]];
        prevNext.momentary = YES;
        prevNext.segmentedControlStyle = UISegmentedControlStyleBar;
        prevNext.tintColor = [UIColor darkGrayColor];
        [prevNext addTarget:self action:@selector(handleActionBarPreviousNext:) forControlEvents:UIControlEventValueChanged];
        
        UIBarButtonItem *prevNextWrapper = [[UIBarButtonItem alloc] initWithCustomView:prevNext];
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"done", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(handleDoneClicked:)];
        
        [self.keyboardToolbar setItems:[NSArray arrayWithObjects:prevNextWrapper, flexible, doneBarItem, nil]];
    }
    
    return _keyboardToolbar;
}

- (UIPickerView *)genderPickerView
{
    if (_genderPickerView == nil) {
        _genderPickerView = [[UIPickerView alloc] init];
        _genderPickerView.delegate = self;
        _genderPickerView.showsSelectionIndicator = YES;
    }
    
    return _genderPickerView;
}

- (UIDatePicker *)birthdayDatePicker
{
    if (_birthdayDatePicker == nil) {
        _birthdayDatePicker = [[UIDatePicker alloc] init];
        [_birthdayDatePicker addTarget:self action:@selector(birthdayDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
        _birthdayDatePicker.datePickerMode = UIDatePickerModeDate;
        NSDate *currentDate = [NSDate date];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        NSDate *selectedDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate  options:0];
        [_birthdayDatePicker setDate:selectedDate animated:NO];
        [_birthdayDatePicker setMaximumDate:currentDate];
    }
    
    return _birthdayDatePicker;
}



#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}


#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImage *image = row == 0 ? [UIImage imageNamed:@"male.png"] : [UIImage imageNamed:@"female.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, 32, 32);
    
    UILabel *genderLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 32)];
    genderLabel.text = [row == 0 ? NSLocalizedString(@"male", @"") : NSLocalizedString(@"female", @"") uppercaseString];
    genderLabel.textAlignment = UITextAlignmentLeft;
    genderLabel.backgroundColor = [UIColor clearColor];
    
    UIView *rowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
    [rowView insertSubview:imageView atIndex:0];
    [rowView insertSubview:genderLabel atIndex:1];
    
    return rowView;
}


- (void)birthdayDatePickerChanged:(id)sender
{
    if ([(NSObject* )self.delegate respondsToSelector:@selector(setBirthdayData)]) {
        [self.delegate setBirthdayData];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([(NSObject* )self.delegate respondsToSelector:@selector(setGenderData)]) {
        [self.delegate setGenderData];
    }
}


@end

@implementation HDHttpClient

+ (HDHttpClient *)shareIntance
{
    static HDHttpClient *sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    
    dispatch_once(&onceToken,^{
        sharedInstance = [[HDHttpClient alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    
    return sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end

@implementation HDUserInfo

+ (void)logOutCurrentUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:HAIDAO_FM_USER_INFO];
    [defaults synchronize];
    
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
}

+ (BOOL)hasSignIn
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *info = [defaults objectForKey:HAIDAO_FM_USER_INFO];
    return (info != nil && [ShareSDK hasAuthorizedWithType:ShareTypeSinaWeibo]);
}

+ (NSDictionary *)fetchUserInfo
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *info = [defaults objectForKey:HAIDAO_FM_USER_INFO];
    return info;
}

+ (void)saveTheUserInfo: (NSDictionary *)info
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:HAIDAO_FM_USER_INFO];
    [defaults synchronize];
}

+ (void)signInWithWeiboAccountBySuccessCallback: (weiboSignInSuccessCallback)success
{
    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo
                           result:^(BOOL result, id<ISSUserInfo> userInfo, id<ICMErrorInfo> error) {
                               if (result) {
                                   NSDictionary *account = [NSDictionary dictionaryWithObjectsAndKeys:userInfo.uid, @"weibo_id" , userInfo.nickname, @"screen_name", @"", @"access_token", nil];
                                   //服务端登录
                                   [[HDHttpClient shareIntance] postPath:WEIBO_SIGNIN parameters:account success:^(AFHTTPRequestOperation *operation, id JSON) {
                                       NSString *uid = [JSON objectForKey:@"uid"];
                                       NSDictionary *weiboInfo = [JSON objectForKey:@"weiboUser"];
                                       NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", [weiboInfo objectForKey:@"weibo_id"] ,@"weiboid", [weiboInfo objectForKey:@"screen_name"] , @"weibo_name", nil];
                                       [HDUserInfo saveTheUserInfo:info];
                                       [[MTStatusBarOverlay sharedInstance]postFinishMessage:@"登录成功!" duration:2.0f];
                                       
                                       success();
                                   } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                                       [[MTStatusBarOverlay sharedInstance] postErrorMessage:@"登录失败.." duration:2.0f];
                                   }];
                               }
                               else {
                                   [[MTStatusBarOverlay sharedInstance] postErrorMessage:@"微博绑定失败.." duration:2.0f];
                               }
                           }];

}

@end
