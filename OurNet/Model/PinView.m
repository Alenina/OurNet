//
//  PinView.m
//  SkillTesting
//
//  Created by LoveStar_PC on 2/4/15.
//  Copyright (c) 2015 IT. All rights reserved.
//

#import "PinView.h"
#import "Define_Global.h"
#import "DataModelForPins.h"
@implementation PinView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/ 
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        imgBack = [[UIImageView alloc] initWithFrame:self.bounds];
        imgBack.image = [UIImage imageNamed:@"Selected Highlight.png"];
        [self addSubview:imgBack];
        
        btnBack = [[UIButton alloc] initWithFrame:self.bounds];
        [btnBack setBackgroundImage:nil forState:UIControlStateNormal];
        [btnBack addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBack];
        
        imgSelectedPin = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22 * MULTIPLY_VALUE, 22 * MULTIPLY_VALUE)];
        imgSelectedPin.center = CGPointMake(frame.size.width - 15 * MULTIPLY_VALUE, 15 * MULTIPLY_VALUE);
        imgSelectedPin.image = [UIImage imageNamed:@"Oval 12.png"];
        [self addSubview:imgSelectedPin];
        
        UIImageView * imgSelectedPin_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15 * MULTIPLY_VALUE, 15 * MULTIPLY_VALUE)];
        imgSelectedPin_1.center = CGPointMake(imgSelectedPin.frame.size.width / 2, imgSelectedPin.frame.size.height / 2);
        imgSelectedPin_1.image = [UIImage imageNamed:@"Fill 519.png"];
        [imgSelectedPin addSubview:imgSelectedPin_1];
        
        lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(5 * MULTIPLY_VALUE, 5 * MULTIPLY_VALUE, frame.size.width - 10 * MULTIPLY_VALUE, 15 * MULTIPLY_VALUE)];
        lblTitle.text = @"";
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.textAlignment = NSTextAlignmentLeft;
        lblTitle.font = [UIFont systemFontOfSize:13 * MULTIPLY_VALUE];
        [self addSubview:lblTitle];
        
        lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(5 * MULTIPLY_VALUE, 25 * MULTIPLY_VALUE, frame.size.width - 10 * MULTIPLY_VALUE, frame.size.height - 30 * MULTIPLY_VALUE)];
        lblDescription.text = @"";
        lblDescription.textColor = [UIColor whiteColor];
        lblDescription.textAlignment = NSTextAlignmentLeft;
        lblDescription.font = [UIFont systemFontOfSize:10 * MULTIPLY_VALUE];
        lblDescription.numberOfLines = 0;
        lblDescription.lineBreakMode = NSLineBreakByWordWrapping;
        [self addSubview:lblDescription];
   
        imgBack.hidden = YES;
        imgSelectedPin.hidden = YES;
        
    }
    return self;
}
- (void) setContentWithData:(DataModelForPins *) model
{
    lblTitle.text = model.title;
    lblDescription.text = [NSString stringWithFormat:@"%@,\n%@,\n%@,\n%@,\n%@", model.semiAddress, model.streetAddress, model.city, model.state, model.phoneNumber];
    
}
- (void) setSelectedWithFlag:(BOOL) flagSelected
{

    imgBack.hidden = NO;
    imgSelectedPin.hidden = NO;
    [UIView animateWithDuration:0.6 animations:^{
        imgBack.alpha = flagSelected;
        imgSelectedPin.alpha = flagSelected;
    } completion:^(BOOL finished) {
        imgBack.hidden = !flagSelected;
        imgSelectedPin.hidden = !flagSelected;
    }];

}
- (void) onClick
{
    [self.delegate onClickWithTag:self.pinID];
}

@end
