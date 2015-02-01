//
//  ADToastView.h
//  iOSToastView
//
//  Created by Aditya Deshmane on 02/02/15.
//  Copyright (c) 2015 Aditya Deshmane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADToastView : UIView

-(id)initToastWithMessage:(NSString*) strMessage;
-(void)show;

@end
