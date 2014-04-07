//
//  UIViewController+TDSemiModalExtension.m
//  TDSemiModal
//
//  Created by Nathan  Reed on 18/10/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "UIViewController+TDSemiModalExtension.h"
#import "MasterViewController.h"
@implementation UIViewController (TDSemiModalExtension)
- (void) presentSemiModalViewController2:(TDSemiModalViewController2*)vc {
    [self presentSemiModalViewController2:vc inView:UIApplication.sharedApplication.delegate.window.rootViewController.view];
}
// Use this to show the modal view (pops-up from the bottom)
- (void) presentSemiModalViewController:(TDSemiModalViewController*)vc {
    [self presentSemiModalViewController:vc inView:UIApplication.sharedApplication.delegate.window.rootViewController.view];
}

- (void) presentSemiModalViewController:(TDSemiModalViewController*)vc inView:(UIView *)rootView {

    
 
    
	UIView* modalView = vc.view;
	UIView* coverView = vc.coverView;
    
	coverView.frame = rootView.bounds;
    coverView.alpha = 0.0f;
    
    modalView.frame = rootView.bounds;
	modalView.center = self.offscreenCenter;
	
	[rootView addSubview:coverView];
	[rootView addSubview:modalView];

    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.6];
  
	modalView.frame = CGRectMake(0, 368, modalView.frame.size.width, modalView.frame.size.height/2);

	coverView.alpha = 0.3;
    
	[UIView commitAnimations];

}


- (void) presentSemiModalViewController2:(TDSemiModalViewController2*)vc inView:(UIView *)rootView {
    
   /* MasterViewController *testTrans = [[MasterViewController alloc]init];
    
    self.test = testTrans;
    self.test.view.center = CGPointMake(self.test.view.center.x, 100);*/
    
    UIView* modalView = vc.view;
	UIView* coverView = vc.coverView;
    
	coverView.frame = rootView.bounds;
    coverView.alpha = 0.0f;
    
    modalView.frame = rootView.bounds;
	modalView.center = self.offscreenCenter;
	
	[rootView addSubview:coverView];
	[rootView addSubview:modalView];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.25];
    
	modalView.frame = CGRectMake(0, 358, modalView.frame.size.width, modalView.frame.size.height/2);

    
	coverView.alpha = 0.3;
    
	[UIView commitAnimations];
    
}

-(void) dismissSemiModalViewController:(TDSemiModalViewController*)vc {
	double animationDelay = 0.7;
	UIView* modalView = vc.view;
	UIView* coverView = vc.coverView;
    

	[UIView beginAnimations:nil context:(__bridge void *)(modalView)];
	[UIView setAnimationDuration:animationDelay];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(dismissSemiModalViewControllerEnded:finished:context:)];
	
    modalView.center = self.offscreenCenter;
	coverView.alpha = 0.0f;

	[UIView commitAnimations];

	[coverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:animationDelay];

}

- (void) dismissSemiModalViewControllerEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIView* modalView = (__bridge UIView*)context;
	[modalView removeFromSuperview];

}


-(CGPoint) offscreenCenter {
    CGPoint offScreenCenter = CGPointZero;
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
	if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		offScreenCenter = CGPointMake(offSize.height / 2.0, offSize.width * 1.5);
	} else {
		offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
	}
    
    return offScreenCenter;
}

@end
