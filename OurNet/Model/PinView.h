//
//  PinView.h
//  SkillTesting
//
//  Created by LoveStar_PC on 2/4/15.
//  Copyright (c) 2015 IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DataModelForPins;
@protocol PinViewDelegate <NSObject>

@optional
- (void) onClickWithTag:(NSInteger) tag;

@end
 
@interface PinView : UIView
{
    UIButton * btnBack;
    UIImageView * imgSelectedPin;
    UIImageView * imgBack;
    UILabel * lblTitle;
    UILabel * lblDescription;
}
@property (nonatomic, strong) id <PinViewDelegate>  delegate;

@property NSInteger pinID;

- (instancetype) initWithFrame:(CGRect)frame;
- (void) setContentWithData:(DataModelForPins *) model;
- (void) setSelectedWithFlag:(BOOL) flagSelected;


@end
