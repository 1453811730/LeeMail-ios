//
//  WToast.h
//  MediaQRCode
//
//  Created by xiayp on 12-8-30.
//
//

#import <UIKit/UIKit.h>

typedef enum {
	kWTShort = 1,
	kWTLong = 5
} WToastLength;

@interface WToast : UIView

+ (WToast *)showWithText:(NSString *)text;
//+ (void)showWithText:(NSString *)text;
+ (void)showWithImage:(UIImage *)image;

+ (WToast *)showWithText:(NSString *)text ToView:(WToast *)toast;

+ (void)showWithText:(NSString *)text length:(WToastLength)length;
+ (void)showWithImage:(UIImage *)image length:(WToastLength)length;


@end
