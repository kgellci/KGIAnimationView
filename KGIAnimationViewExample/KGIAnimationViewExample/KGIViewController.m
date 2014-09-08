//
//  KGIViewController.m
//  KGIAnimationViewExample
//
//  Created by kriser gellci on 9/2/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "KGIViewController.h"
#import "KGIAnimationView.h"

@interface KGIViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) KGIAnimationView *animationView;

@end

@implementation KGIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.contentSize = CGSizeMake(0, 2000);
    [self addAnimationView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAnimationView {
    KGIAnimationView *view = [[KGIAnimationView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    view.backgroundColor = [UIColor redColor];
    
    KGIKeyFrame keyFrame = KGIKeyFrameMake(view.frame, 0.0f);
    [view addAnimationFrame:keyFrame];
    
    keyFrame = KGIKeyFrameMake(CGRectMake(0, 0, 50, 50), 0.3f);
    keyFrame.rotationRads = -0.5;
    keyFrame.alpha = 0.5f;
    [view addAnimationFrame:keyFrame];
    
    keyFrame = KGIKeyFrameMake(CGRectMake(200, 300, 300, 300), 0.6f);
    keyFrame.rotationRads = -1;
    keyFrame.alpha = 0.0f;
    [view addAnimationFrame:keyFrame];
    
    keyFrame = KGIKeyFrameMake(CGRectMake(100, 100, 50, 50), 1.0f);
    keyFrame.rotationRads = -2;
    keyFrame.alpha = 1.0f;
    [view addAnimationFrame:keyFrame];
    
    self.animationView = view;
    [self.view insertSubview:view belowSubview:self.scrollView];
    
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.animationView updatePositionWithPercentage:(scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.bounds.size.height))];
}

@end
