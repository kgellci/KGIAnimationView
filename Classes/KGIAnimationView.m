//
//  KGIAnimationViewAnimationView.m
//
//  Created by kriser gellci on 8/28/14.
//  Copyright (c) 2014 kriser gellci. All rights reserved.
//

#import "KGIAnimationView.h"

@implementation KGIAnimationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.keyFrameArray = [NSMutableArray array];
        self.originalTransform = self.transform;
    }
    return self;
}

- (void)addAnimationFrame:(KGIKeyFrame)animationFrame {
    animationFrame.position = self.keyFrameArray.count;
    
    // If it is the first or second keyframe, set it as the prev or next keyframe
    if (animationFrame.position == 0) {
        self.prevKeyFrame = animationFrame;
    } else if (animationFrame.position == 1) {
        self.nextKeyFrame = animationFrame;
    }
    
    // Add the keyframe to the array
    [self.keyFrameArray addObject:[NSValue valueWithBytes:&animationFrame objCType:@encode(KGIKeyFrame)]];
}

// Returns the animation from from the array
- (KGIKeyFrame)animationFrameForPosition:(NSUInteger)position {
    KGIKeyFrame animationFrame;
    [((NSValue *)[self.keyFrameArray objectAtIndex:position]) getValue:&animationFrame];
    return animationFrame;
}

// percentage is between 0.0 and 1.0 and signifies the scrollviews contentOffset / (scrollviews contentSize - scrollviews height)
- (void)updatePositionWithPercentage:(CGFloat)percentage {
    // reset the transform to do any new calculations
    self.transform = self.originalTransform;
    
    // set the prev and next frames accordingly
    if (percentage > self.nextKeyFrame.maxEffectiveDelta && self.keyFrameArray.count - 1 > self.nextKeyFrame.position) {
        self.prevKeyFrame = self.nextKeyFrame;
        self.nextKeyFrame = [self animationFrameForPosition:self.nextKeyFrame.position+1];
    } else if (self.prevKeyFrame.maxEffectiveDelta > percentage && self.prevKeyFrame.position != 0) {
        self.nextKeyFrame = self.prevKeyFrame;
        self.prevKeyFrame = [self animationFrameForPosition:self.prevKeyFrame.position - 1];
    }
    
    // adjust the percentage based on the previous and next keyfarame
    CGFloat percentageAdjustment = (percentage - self.prevKeyFrame.maxEffectiveDelta)/((self.nextKeyFrame.maxEffectiveDelta - percentage)+(percentage - self.prevKeyFrame.maxEffectiveDelta));
    
    KGIKeyFrame currentFrame = KGIAnimationKeyFrameBetweenKeyFrames(self.prevKeyFrame, self.nextKeyFrame, percentageAdjustment);
    self.frame = currentFrame.frame;
    self.transform =CGAffineTransformMakeRotation(currentFrame.rotationRads);
    self.alpha = currentFrame.alpha;
}

@end
