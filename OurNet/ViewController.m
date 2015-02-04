//
//  ViewController.m
//  NewTesting
//
//  Created by LoveStar_PC on 2/4/15.
//  Copyright (c) 2015 IT. All rights reserved.
//

#import "ViewController.h"
#import "Define_Global.h"
#import "DataModelForPins.h"
#import "PinView.h"

@interface ViewController ()<PinViewDelegate>
{
    UIScrollView * scrollView;
    NSMutableArray *arrayViewsForPin;
    NSMutableArray *arrayButtonsForPin;
    
    UIImageView * selectedImage;

}
@property (weak, nonatomic) IBOutlet UIView *viewMapBack;

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIImageView * imgMap = [[UIImageView alloc] initWithFrame:self.viewMapBack.bounds];
    imgMap.image = [UIImage imageNamed:@"Map.png"];
    [self.viewMapBack addSubview:imgMap];
    
    arrayViewsForPin = [[NSMutableArray alloc] init];
    arrayButtonsForPin = [[NSMutableArray alloc] init];

    [arrayButtonsForPin addObject:[self createPinWithPosition:CGPointMake(0.45, 0.35) withTag:0]];
    [arrayButtonsForPin addObject:[self createPinWithPosition:CGPointMake(0.5, 0.5) withTag:1]];
    [arrayButtonsForPin addObject:[self createPinWithPosition:CGPointMake(0.28, 0.47) withTag:2]];
    [arrayButtonsForPin addObject:[self createPinWithPosition:CGPointMake(0.77, 0.63) withTag:3]];
    [arrayButtonsForPin addObject:[self createPinWithPosition:CGPointMake(0.85, 0.82) withTag:4]];
    [arrayButtonsForPin addObject:[self createPinWithPosition:CGPointMake(0.8, 0.48) withTag:5]];
   
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10 * MULTIPLY_VALUE, SCREEN_WIDTH - HEIGHT_SCROLL - 5 * MULTIPLY_VALUE, SCREEN_HEIGHT - 20 * MULTIPLY_VALUE, HEIGHT_SCROLL)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.scrollEnabled = YES;
    [scrollView setShowsHorizontalScrollIndicator:YES];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.height * 6, scrollView.frame.size.height);
    [self.view addSubview:scrollView];

    for (NSInteger i = 0; i < 6; i ++) {
        
        DataModelForPins * newDataForPins = [[DataModelForPins alloc] init];
        newDataForPins.title = @"UK Headquarters";
        newDataForPins.semiAddress = @"11 New Field Budiness Part";
        newDataForPins.streetAddress = @"Stinsford Road, Poole";
        newDataForPins.city = @"Dorset, BH17 ONF";
        newDataForPins.state = @"United Kingdom";
        newDataForPins.phoneNumber = @"+44 (0) 1202 621511";
        
        PinView * newPin = [[PinView alloc] initWithFrame:CGRectMake(0, 0, HEIGHT_SCROLL * 1.3, HEIGHT_SCROLL)];
        newPin.center = CGPointMake(newPin.frame.size.width * (i + 0.5), newPin.frame.size.height / 2);
        newPin.pinID = i;
        newPin.delegate = self;
        [newPin setContentWithData:newDataForPins];
        [scrollView addSubview:newPin];
        [arrayViewsForPin addObject:newPin];
        
//        [self setSelectWithIndex:i];

    }
    
    selectedImage = [[UIImageView alloc] initWithFrame:CGRectMake(-100, 0, 22 * MULTIPLY_VALUE, 22 * MULTIPLY_VALUE)];
    selectedImage.image = [UIImage imageNamed:@"Oval 12.png"];
    [self.viewMapBack addSubview:selectedImage];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIButton *) createPinWithPosition:(CGPoint) point withTag:(NSInteger) tag
{
    UIButton * btnPin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15 * MULTIPLY_VALUE, 15 * MULTIPLY_VALUE)];
    btnPin.center = CGPointMake(point.x * self.viewMapBack.frame.size.width, point.y * self.viewMapBack.frame.size.height);
    [btnPin setBackgroundImage:[UIImage imageNamed:@"Fill 519.png"] forState:UIControlStateNormal];
    btnPin.tag = tag;
    [btnPin addTarget:self action:@selector(onPin:) forControlEvents:UIControlEventTouchUpInside];
    [self.viewMapBack addSubview:btnPin];
    
    return btnPin;
}
- (void) onPin:(UIButton *) theBtn
{
    [self setSelectWithIndex:theBtn.tag];
}
- (BOOL) setSelectWithIndex:(NSInteger) selectID
{
    selectedImage.center = ((UIButton *)arrayButtonsForPin[selectID]).center;
     
    BOOL resultExist = NO;
    for (PinView * theView in arrayViewsForPin) {
        if (theView.pinID == selectID) {
            [theView setSelectedWithFlag:YES];
            resultExist = YES;
//            [self animationScrollViewWithIndex:selectID];
            [UIView animateWithDuration:0.6 animations:^{
                [scrollView setContentOffset:CGPointMake([arrayViewsForPin indexOfObject:theView] * theView.frame.size.width, 0) animated:YES];
            } completion:^(BOOL finished) {
                
            }];
        }
        else
        {
            [theView setSelectedWithFlag:NO];
        }
    }
    return resultExist;
}
-(void)animationScrollViewWithIndex:(NSInteger) index{
    
    [self.animator removeAllBehaviors];
    BOOL flagRightDirection;
    CGFloat boundaryPointX = scrollView.contentOffset.x - index * HEIGHT_SCROLL;
    if (boundaryPointX > 0) {
        flagRightDirection = YES;
    }
    else
    {
        flagRightDirection = NO;
    }
    CGFloat gravityDirectionX = (flagRightDirection) ? 1.0 : -1.0;
    CGFloat pushMagnitude = (flagRightDirection) ? 20.0 : -20.0;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[scrollView]];
    gravityBehavior.gravityDirection = CGVectorMake(gravityDirectionX, 0.0);
    [self.animator addBehavior:gravityBehavior];
    
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[scrollView]];
    [collisionBehavior addBoundaryWithIdentifier:@"menuBoundary"
                                       fromPoint:CGPointMake(boundaryPointX, scrollView.center.y)
                                         toPoint:CGPointMake(boundaryPointX, scrollView.center.y)];
    [self.animator addBehavior:collisionBehavior];
    
    
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems:@[scrollView]
                                                                    mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.magnitude = pushMagnitude;
    [self.animator addBehavior:pushBehavior];
    
    
    UIDynamicItemBehavior *menuViewBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[scrollView]];
    menuViewBehavior.elasticity = 0.4;
    [self.animator addBehavior:menuViewBehavior];
    
}

#pragma mark - PinViewDelegate

- (void) onClickWithTag:(NSInteger) tag
{
    [self setSelectWithIndex:tag];
}

@end
