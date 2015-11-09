/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  HelloCordova
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"
#import <Accounts/Accounts.h>
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@implementation MainViewController
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Uncomment to override the CDVCommandDelegateImpl used
        // _commandDelegate = [[MainCommandDelegate alloc] initWithViewController:self];
        // Uncomment to override the CDVCommandQueue used
        // _commandQueue = [[MainCommandQueue alloc] initWithViewController:self];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // View defaults to full size.  If you want to customize the view's size, or its subviews (e.g. webView),
    // you can do so here.
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    locationManager = [[CLLocationManager alloc] init];
    
    namel = @"noaccount";
    //ios version checking
    
    if(IS_OS_8_OR_LATER) {
        
        
        
        NSUInteger code = [CLLocationManager authorizationStatus];
        
        
        
        if (code == kCLAuthorizationStatusNotDetermined && ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                
                [locationManager  requestAlwaysAuthorization];
                
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                
                [locationManager  requestWhenInUseAuthorization];
                 } else {
                 
            }
            
        }
        
    }
    
    
    locationManager.delegate=self;
    
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    
    locationManager.distanceFilter=1000.0f;
    
    [locationManager startUpdatingLocation];
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation

{
      CLLocation *currentLocation = newLocation;
       if (currentLocation != nil) {
           lat = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
           longt = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
          
           NSString *urlString;
           data_retrived = [[NSMutableArray alloc] init];
           
           urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%@,%@&sensor=true",lat,longt];
           
           NSLog(@" -=-=-=-=-=-==-%@",urlString);
           NSURL *requestURL = [NSURL URLWithString:urlString];
           NSError* error = nil;
           NSLog(@"-=-=-=-=---= :%@", urlString);
           NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
           if (signeddataURL != nil)
           {
           NSMutableDictionary *result = [NSJSONSerialization
                                          JSONObjectWithData:signeddataURL //1
                                          
                                          options:kNilOptions
                                          error:&error];
           
           for(NSMutableDictionary *dict in result)
           {
               [data_retrived addObject:dict];
               
           }
           
           streetAdd = [[[result objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"];
       
           NSLog(@"........%@",[[[result objectForKey:@"results"] objectAtIndex:0] objectForKey:@"formatted_address"] );
           
           //[locationManager stopUpdatingLocation];
           NSString* jsString3 = [NSString stringWithFormat:@"var street = \"%@\";",streetAdd];
           [theWebViewLL stringByEvaluatingJavaScriptFromString:jsString3];
           [super webViewDidFinishLoad:theWebViewLL];
           }
    }
    
    // this creates a MKReverseGeocoder to find a placemark using the found coordinates

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
 - (UIWebView*) newCordovaViewWithFrame:(CGRect)bounds
 {
 return[super newCordovaViewWithFrame:bounds];
 }
 */

#pragma mark UIWebDelegate implementation

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    theWebViewLL = theWebView;
    
    NSString* jsString = [NSString stringWithFormat:@"var lat = \"%@\";",lat];
    [theWebView stringByEvaluatingJavaScriptFromString:jsString];
    
    NSString* jsString2 = [NSString stringWithFormat:@"var longt = \"%@\";",longt];
    [theWebView stringByEvaluatingJavaScriptFromString:jsString2];
    
    NSString* jsString3 = [NSString stringWithFormat:@"var street = \"%@\";",streetAdd];
    [theWebView stringByEvaluatingJavaScriptFromString:jsString3];
    
    NSString* jsString4 = [NSString stringWithFormat:@"var nameL = \"%@\";",namel];
    [theWebView stringByEvaluatingJavaScriptFromString:jsString4];
    
    // Black base color for background matches the native apps
    theWebView.backgroundColor = [UIColor blackColor];
    
    return [super webViewDidFinishLoad:theWebView];
}

/* Comment out the block below to over-ride */

/*
 
 - (void) webViewDidStartLoad:(UIWebView*)theWebView
 {
 return [super webViewDidStartLoad:theWebView];
 }
 
 - (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
 {
 return [super webView:theWebView didFailLoadWithError:error];
 }
 
 - (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
 {
 return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
 }
 */

- (BOOL)webView:(UIWebView *)webView

shouldStartLoadWithRequest:(NSURLRequest *)request

 navigationType:(UIWebViewNavigationType)navigationType {
    
    
    
    // these need to match the values defined in your JavaScript
    
    NSString *myAppScheme = @"myFakeAppName";
    
    NSString *myActionType = @"myJavascriptActionType";
    
    
    
    // ignore legit webview requests so they load normally
    
    if (![request.URL.scheme isEqualToString:myAppScheme]) {
        
        NSLog(@"isEqualToStringisEqualToStringisEqualToStringTwitter");
        
        
        [self twitter];
        
        
        return YES;
        
    }
    
    
    
    // get the action from the path
    
    NSString *actionType = request.URL.host;
    
    // deserialize the request JSON
    
    NSString *jsonDictString = [request.URL.fragment stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    
    
    // look at the actionType and do whatever you want here
    
    if ([actionType isEqualToString:myActionType]) {
        
        
        
        NSLog(@"dsfdsfjdsfjdsgfdsf.........//..............");
        
        
        
        // do something in response to your javascript action
        
        // if you used an action parameters dict, deserialize and inspect it here
        
    }
    
    
    
    
    
    // make sure to return NO so that your webview doesn't try to load your made-up URL
    
    return NO;
    
}
- (void)twitter{
    
    @try {
        
        
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            
            
        } completion:^(BOOL finished){
            
            
            
            if(!accountStore)
                
                accountStore = [[ACAccountStore alloc] init];
            ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
            [accountStore requestAccessToAccountsWithType:accountType options:NULL completion:^(BOOL granted, NSError *error) {
                
                if (granted) {
                    
                    //  Step 2:  Create a request
                    
                    NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
                    
                    
                    
                    if([accountsArray count]==0)
                        
                    {
                        
                        [imgspin setHidden:YES];
                        [spinnern stopAnimating];
                        
                        //                        alert = [[UIAlertView alloc] initWithTitle:@"Sorry!!!" message:@"Please setup your twitter account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        //                        //alert.tag=3;
                        //                        [alert show];
                        
                    }
                    
                    else
                        
                    {
                        twitterAccount = [accountsArray objectAtIndex:0];
                        
                        
                        
                        // NSString *userID = [[twitterAccount valueForKey:@"properties"] valueForKey:@"user_id"];
                        
                        NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"];
                        NSDictionary *params = @{@"screen_name" : twitterAccount.username
                                                 };
                        
                        SLRequest *request =
                        [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:params];
                        
                        
                        
                        //  Attach an account to the request
                        
                        
                        
                        [request setAccount:[accountsArray lastObject]];
                        
                        
                        
                        //  Step 3:  Execute the request
                        
                        
                        
                        [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                            
                            if (responseData) {
                                
                                if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
                                    
                                    NSError* error = nil;
                                    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                          
                                                                                         options:NSJSONReadingAllowFragments
                                                                                           error:&error];
                                    
                                    
                                    
                                    [self performSelectorOnMainThread:@selector(twitterdetails:)withObject:responseData waitUntilDone:YES];
                                    
                                } else {
                                    
                                    NSLog(@"The response status code is %ld", (long)urlResponse.statusCode);
                                    
                                }
                                
                            }
                            
                        }];
                        
                    }
                    
                }
                
                else
                    
                {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSLog(@"got no account");
                        
                    });
                    
                }
                
            }];
            
        }];
        
    }
    
    @catch (NSException *exception) {
        
        NSLog(@" Exception here is %@",exception);
        
    }
    
}

//function to fetch twitter details

- (void)twitterdetails:(NSData *)responseData {
    
    NSLog(@"details");
    
    @try {
        
        NSError* error = nil;
        
        json1 = [NSJSONSerialization JSONObjectWithData:responseData //1
                                                options:NSJSONReadingAllowFragments
                                                  error:&error];
        
        
        
        namel = twitterAccount.username;
        emailTwit = [json1 objectForKey:@"email"];
        scrnm = [json1 objectForKey:@"screen_name"];
        twitterid = [json1 objectForKey:@"id"];
        prof_img = [json1 objectForKey:@"profile_image_url"];
        
        NSLog(@"....///.....%@......///.....%@........////......%@........////......%@........////......%@",namel,emailTwit,scrnm,twitterid,prof_img);
        
        NSString* jsString3 = [NSString stringWithFormat:@"var nameL = \"%@\";",namel];
        [theWebViewLL stringByEvaluatingJavaScriptFromString:jsString3];
        
        return [super webViewDidFinishLoad:theWebViewLL];
    }
    
    @catch (NSException *exception) {
        
        NSLog(@" Exception %@",exception);
        
        // [self dismissError:@" There is an issue with your connectivity"];
        
    }
    
}


@end

@implementation MainCommandDelegate

/* To override the methods, uncomment the line in the init function(s)
 in MainViewController.m
 */

#pragma mark CDVCommandDelegate implementation

- (id)getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (NSString*)pathForResource:(NSString*)resourcepath
{
    return [super pathForResource:resourcepath];
}

@end

@implementation MainCommandQueue

/* To override, uncomment the line in the init function(s)
 in MainViewController.m
 */
- (BOOL)execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

@end
