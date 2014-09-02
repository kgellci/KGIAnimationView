//
//  animatorView.h
//  OnboardingTest
//
//  Created by kriser gellci on 8/28/14.
//  Copyright (c) 2014 kriser gellci. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
    /*! position and size of the view at this frame */
    CGRect frame;
    
    /*! The rotation in radians of the view at this frame */
    CGFloat rotationRads;
    
    /*! 
     The key frames animation if effective between the previous key frames
     maxEffectiveDelta and the current key frames maxEffectiveDelta.  
     
     MaxEffectiveDelta is the maximum scroll percentage to which this key frame will function.
     */
    CGFloat maxEffectiveDelta;
    
    /*! The position of the key Frame in the key frame array, used internally, should not be set externally. */
    NSUInteger position;
} KGKeyFrame;

CG_INLINE KGKeyFrame
/*!
 Initialize a new Key Frame, you should always use this method to create a new Key Frame, 
 the input is the minimum required for the key frame to function
 */
KGKeyFrameMake(CGRect frame, CGFloat maxEffectiveDelta)
{
    KGKeyFrame keyFrame;
    keyFrame.frame = frame;
    keyFrame.maxEffectiveDelta = maxEffectiveDelta;
    keyFrame.rotationRads = 0;
    return keyFrame;
}

CG_INLINE CGFloat
/*!
 Convenience method that gives the a float between two floats based on the current distance traveled between the two.
 */
CGFloatFloatBetweenFloats(CGFloat startFloat, CGFloat endFloat, CGFloat deltaDistance)
{
    return endFloat + ((startFloat - endFloat) - (startFloat - endFloat)*deltaDistance);
}

CG_INLINE CGRect
/*!
 Convenience method that gives a frame between two frames based on the current distance traveled between the two.
 */
CGRectFrameBetweenframes(CGRect startframe, CGRect endframe, CGFloat deltaDistance)
{
    CGRect frame;
    frame.origin.x = CGFloatFloatBetweenFloats(startframe.origin.x, endframe.origin.x, deltaDistance);
    frame.origin.y = CGFloatFloatBetweenFloats(startframe.origin.y, endframe.origin.y, deltaDistance);
    frame.size.width = CGFloatFloatBetweenFloats(startframe.size.width, endframe.size.width, deltaDistance);
    frame.size.height = CGFloatFloatBetweenFloats(startframe.size.height, endframe.size.height, deltaDistance);
    return frame;
}

CG_INLINE KGKeyFrame
/*!
 Convenience method that gives a key frame between two key frames based on the current distance traveled between the two.
 */
AnimationKeyFrameBetweenKeyFrames(KGKeyFrame startKeyFrame, KGKeyFrame endKeyFrame, CGFloat deltaDistance)
{
    KGKeyFrame keyFrame;
    keyFrame.frame = CGRectFrameBetweenframes(startKeyFrame.frame, endKeyFrame.frame, deltaDistance);
    keyFrame.rotationRads = CGFloatFloatBetweenFloats(startKeyFrame.rotationRads, endKeyFrame.rotationRads, deltaDistance);
    
    return keyFrame;
}

@interface KGAnimationView : UIView
/*! Array storage for all the key frames associated with the view.
 \n Use - (void)addAnimationFrame:(KGKeyFrame)animationFrame to add key frames to a view.
 */
@property (nonatomic, strong) NSMutableArray *keyFrameArray;
@property (nonatomic) KGKeyFrame prevKeyFrame, nextKeyFrame;

/*! 
 Used internally to keep track of the original transform for a view, do not set manually
 unless you know what you are doing.
 */
@property (nonatomic) CGAffineTransform originalTransform;

/*!
 Use this to tell the view to update its key frame animation.  \n\n
 
 Should pass a number between 0.0 and 1.0 which represents the overall 
 progress of the animation as a whole.  \n\n
 
 If tying to a scrollView, you will normally want to call this on each view in the
 scrollViewDidScroll delegate method.
 */
- (void)updatePositionWithPercentage:(CGFloat)percentage;

/*!
 Use this to add key frames to a view.  You should not manually add them to the key frame array.
 */
- (void)addAnimationFrame:(KGKeyFrame)animationFrame;

/*!
 Convenience method which will return a key frame from the key frame array
 */
- (KGKeyFrame)animationFrameForPosition:(NSUInteger)position;

@end
