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

    
 
    
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        
        UIView* modalView = vc.view;
        UIView* coverView = vc.coverView;
        
        coverView.frame = rootView.bounds;
        coverView.alpha = 0.0f;
        
        modalView.frame = rootView.bounds;
        modalView.center = self.offscreenCenter;
        
        [rootView addSubview:coverView];
        [rootView addSubview:modalView];
        
        
        
    	modalView.frame = CGRectMake(0, 0, modalView.frame.size.width - 30, modalView.frame.size.height/2);
        
        modalView.transform = CGAffineTransformMakeTranslation(15, 80);
    
        
        coverView.alpha = 0.3;
        
    } completion:^(BOOL finished) {
        //Completion Block
    }];


}


- (void) presentSemiModalViewController2:(TDSemiModalViewController2*)vc inView:(UIView *)rootView {
    
   /* MasterViewController *testTrans = [[MasterViewController alloc]init];
    
    self.test = testTrans;
    self.test.view.center = CGPointMake(self.test.view.center.x, 100);*/
    

    
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        UIView* modalView = vc.view;
        UIView* coverView = vc.coverView;
        
        coverView.frame = rootView.bounds;
        coverView.alpha = 0.0f;
        
        modalView.frame = rootView.bounds;
        modalView.center = self.offscreenCenter;
        
        [rootView addSubview:coverView];
        [rootView addSubview:modalView];
        

        
    	modalView.frame = CGRectMake(0, 0, modalView.frame.size.width, modalView.frame.size.height/2);
        
           modalView.transform = CGAffineTransformMakeTranslation(0, +300);
        
        
        coverView.alpha = 0.3;

    } completion:^(BOOL finished) {
        //Completion Block
    }];
    

    
}

-(void) dismissSemiModalViewController:(TDSemiModalViewController*)vc {
	double animationDelay = 0.9;
    UIView* modalView = vc.view;
    UIView* coverView = vc.coverView;
    
    [UIView animateWithDuration:0.5
     
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:1.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
       
                         
                         
                         
                         
                         
                         modalView.center = self.offscreenCenter;
                         coverView.alpha = 0.0f;
                         
                         
                     }
                     completion:^(BOOL finished){
                       	[modalView removeFromSuperview];
                     }];
    
    	[coverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:animationDelay];
    

    

/*	[UIView beginAnimations:nil context:(__bridge void *)(modalView)];
	[UIView setAnimationDuration:animationDelay];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(dismissSemiModalViewControllerEnded:finished:context:)];
	
 

	[UIView commitAnimations];
*/
	[coverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:animationDelay];

}

- (void) dismissSemiModalViewControllerEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIView* modalView = (__bridge UIView*)context;
	[modalView removeFromSuperview];

}






-(CGPoint) offscreenCenter {
    CGPoint offScreenCenter = CGPointZero;
   
    // Tall Screen
            CGSize offSize = UIScreen.mainScreen.bounds.size;

        
        
        
        offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
        
        
        
    
   

    
    

    
    return offScreenCenter;
}
-(CGPoint) offscreenCenter2 {
    CGPoint offScreenCenter2 = CGPointZero;
    
    UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGSize offSize = UIScreen.mainScreen.bounds.size;
    
	if(orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
		offScreenCenter2 = CGPointMake(offSize.height / 2.0, offSize.width * 1.5);
	} else {
		offScreenCenter2 = CGPointMake(offSize.width - 25, offSize.height);
	}
    
    return offScreenCenter2;
}
@end
