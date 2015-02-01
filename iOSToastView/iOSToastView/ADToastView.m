//
//  ADToastView.m
//  iOSToastView
//
//  Created by Aditya Deshmane on 02/02/15.
//  Copyright (c) 2015 Aditya Deshmane. All rights reserved.
//

#import "ADToastView.h"
#import <QuartzCore/QuartzCore.h>

//Transparancy
#define kBackgroundAlpha 0.4

//Margins
#define kToastWidth 290
#define kToastLeadingTrailingTextMargin 10
#define kToastTopBottomTextMargin 10

//BackgroundColor
#define kBackgroundColor [UIColor darkGrayColor]

//Border
#define kBorderColor [UIColor cyanColor]
#define kCornerRadius 5.0
#define kBorderWidth  2.0

//Message
#define kMessageTextColor [UIColor cyanColor]
#define kDefaultMessageFontSize 16

//Display time
#define kDisplayTime 1.5


@interface  ADToastView()
{
    UIView* _viewToast;
    NSString* _strMessage;
}

@end

@implementation ADToastView

-(id)initToastWithMessage:(NSString*) strMessage
{
    self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
    }
    
    _strMessage = strMessage;
    
    [self buildToastView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kDisplayTime * NSEC_PER_SEC), dispatch_get_main_queue(),
    ^{
        [self hide];
    });
    
    return self;
}


#pragma mark - View LifeCycle

-(void)drawRect:(CGRect)rect
{
    //Drawing the background of the toast when image is nil
    CGRect toastRect = [self getRectOfToast];
    drawRoundedRect(UIGraphicsGetCurrentContext(), toastRect, kBackgroundColor.CGColor, kBorderColor.CGColor, kBorderWidth, kCornerRadius);
}

- (void)buildToastView
{
    CGRect toastRect = [self getRectOfToast];
    
    //Add transparent background view
    UIView* shadeView = [[UIView alloc] initWithFrame:self.frame];
    shadeView.backgroundColor = [UIColor blackColor];
    shadeView.alpha = kBackgroundAlpha;
    [self addSubview: shadeView];
    
    //Add non transparent toast view
    _viewToast = [[UIView alloc] initWithFrame:toastRect];
    [_viewToast setBackgroundColor:kBackgroundColor];
    _viewToast.layer.cornerRadius = kCornerRadius;
    [self addSubview: _viewToast];
    
    //Add label for message
    CGRect frame = CGRectMake(kToastLeadingTrailingTextMargin, kToastTopBottomTextMargin, toastRect.size.width-kToastLeadingTrailingTextMargin*2, [self getHeightOfMessage]);
    
    UILabel *lblMessage = [[UILabel alloc] initWithFrame:frame];
    lblMessage.text = _strMessage;
    lblMessage.textColor = kMessageTextColor;
    lblMessage.backgroundColor = [UIColor clearColor];
    lblMessage.textAlignment = NSTextAlignmentCenter;
    lblMessage.lineBreakMode = NSLineBreakByWordWrapping;
    lblMessage.numberOfLines = 0;
    lblMessage.font = [UIFont systemFontOfSize:kDefaultMessageFontSize];
    [_viewToast addSubview:lblMessage];
}

-(void)dealloc
{
}

-(void)show
{    
    self.alpha = 0;
    __block ADToastView * tempSelf = self;
    
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    [UIView animateWithDuration:0.5 animations:
     ^{
         tempSelf.alpha = 1;
     }];
}

-(void)hide
{
    __block ADToastView * tempSelf = self;
    
    [self endEditing:YES];
    
    [UIView animateWithDuration:0.5
     animations:
     ^{
         tempSelf.alpha = 0;
     }
     completion:
     ^(BOOL f)
     {
         [tempSelf removeFromSuperview];
     }];
}

#pragma mark - Accessory Methods

-(NSInteger)getHeightOfMessage
{
    NSInteger width = kToastWidth-kToastLeadingTrailingTextMargin*2;
    UIFont* font = [UIFont systemFontOfSize:kDefaultMessageFontSize];
    
    //TODO: Remove deprecatd method sizeWithFont
    return [_strMessage sizeWithFont:font constrainedToSize:CGSizeMake(width, self.frame.size.height-kToastTopBottomTextMargin) lineBreakMode:NSLineBreakByWordWrapping].height;
}

-(CGRect)getRectOfToast
{
    NSInteger x = (self.frame.size.width - kToastWidth)/2;
    NSInteger height = kToastTopBottomTextMargin*2 +[self getHeightOfMessage];
    return CGRectMake(x, ([[UIScreen mainScreen] bounds].size.height-height)/2, kToastWidth, height);
}

#pragma mark - Drawing Methods

static void drawRoundedRect(CGContextRef context, CGRect rrect, CGColorRef fillColor, CGColorRef borderColor, CGFloat borderWidth, CGFloat cornerRadius)
{
    CGContextSetStrokeColorWithColor(context, borderColor);
    CGContextSetFillColorWithColor(context, fillColor);
    
    if (borderWidth>1)
        CGContextSetLineWidth(context, borderWidth);
    
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    {
        // Start at 1
        CGContextMoveToPoint(context, minx, midy);
        // Add an arc through 2 to 3
        CGContextAddArcToPoint(context, minx, miny, midx, miny, cornerRadius);
        // Add an arc through 4 to 5
        CGContextAddArcToPoint(context, maxx, miny, maxx, midy, cornerRadius);
        // Add an arc through 6 to 7
        CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, cornerRadius);
        // Add an arc through 8 to 9
        CGContextAddArcToPoint(context, minx, maxy, minx, midy, cornerRadius);
        // Close the path
        CGContextClosePath(context);
        
        // Fill & stroke the path
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}


@end
