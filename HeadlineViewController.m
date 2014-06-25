//
//  HeadlineViewController.m
//  HomeworkPaper
//
//  Created by Tom Gulik on 6/23/14.
//  Copyright (c) 2014 Tom Gulik. All rights reserved.
//

#import "HeadlineViewController.h"

@interface HeadlineViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *newsFeed;
@property (weak, nonatomic) IBOutlet UIView *headlineView;


@property (assign, nonatomic) int startPos;
@property (assign, nonatomic) int endPos;

- (IBAction)panNewsFeed:(UIPanGestureRecognizer *)sender;
- (IBAction)panHeadlines:(UIPanGestureRecognizer *)sender;


@end

@implementation HeadlineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.endPos = 720;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)panNewsFeed:(UIPanGestureRecognizer *)sender {
    CGPoint translaton = [sender translationInView:self.view];
    //NSLog(@"translation: %@", NSStringFromCGPoint(translaton));
    CGPoint location = [sender locationInView:self.view];
    
    if(sender.state == UIGestureRecognizerStateBegan){
        //self.startPos = location.x;
        NSLog(@"Start: %f",location.x);
    } else if(sender.state == UIGestureRecognizerStateChanged) {
        CGPoint center = self.newsFeed.center;
        center.x = self.endPos + translaton.x;
        self.newsFeed.center = center;
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        self.endPos = self.endPos + translaton.x;
        
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:0 animations:^{
            CGPoint center = self.newsFeed.center;
            center.x = center.x + translaton.x;
            self.newsFeed.center = center;
        } completion:nil];
        
        if(self.endPos<-350){
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:0 animations:^{
                CGPoint center = self.newsFeed.center;
                center.x = -350;
                self.newsFeed.center = center;
            } completion:nil];
        } else if(self.endPos>720){
            [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.5 options:0 animations:^{
                CGPoint center = self.newsFeed.center;
                center.x = 720;
                self.newsFeed.center = center;
            } completion:nil];
        }
    }
    
    
}

- (IBAction)panHeadlines:(UIPanGestureRecognizer *)sender {
    CGPoint translation   = [sender translationInView:sender.view];
    CGPoint touchlocation = [sender locationInView:sender.view];
    
    if(sender.state == UIGestureRecognizerStateBegan){
        [UIView animateWithDuration:1 animations:^{
            CGPoint center = self.headlineView.center;
            center.y = touchlocation.y;
            self.startPos = touchlocation.y;
            self.headlineView.center = center;
        } completion:nil];
    } else if(sender.state == UIGestureRecognizerStateChanged){
        //NSLog(@" %f",self.headlineView.frame.size.height);
        NSLog(@" %f",touchlocation.y);
        //if(touchlocation.y<100){
            CGPoint center = self.headlineView.center;
            center.y = self.startPos + touchlocation.y;
            self.headlineView.center = center;
        //}
        
    } else if(sender.state == UIGestureRecognizerStateEnded){
        int newPos = 0;
        if(translation.y > 100) {
            newPos = 810;
        } else {
            newPos = 280;
        }
        //NSLog(@"New POS: %d",newPos);
        [UIView animateWithDuration:1 animations:^{
            CGPoint center = self.headlineView.center;
            center.y = newPos;
            self.headlineView.center = center;
        } completion: nil];
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
