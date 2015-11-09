//
//  LoginViewController.h
//  InstagramUnsignedAuthentication
//
//  Created by user on 11/13/14.
//  Copyright (c) 2014 Neuron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *loginWebView;
    IBOutlet UIActivityIndicatorView* loginIndicator;
    IBOutlet UILabel *loadingLabel;
}
@property(strong,nonatomic)NSString *typeOfAuthentication;
-(void)startLogin;
@end
