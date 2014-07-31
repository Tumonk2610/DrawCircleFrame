//
//  DCFExampleViewController.m
//  DrawCircleFrame
//
//  Created by Natalia Osiecka on 22.7.2014.
//  Copyright (c) 2014 AppUnite. All rights reserved.
//

#import "DCFExampleViewController.h"
#import "DCFExampleView.h"
#import "NSString+Size.h"
#import "DCFButton.h"

@interface DCFExampleViewController ()

@property (nonatomic, weak) DCFExampleView *dcfExampleView;
@property (nonatomic, strong, readonly) DCFButton *button;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DCFExampleViewController

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

#pragma mark - View lifecycle

- (void)loadView {
    CGRect rect = [[UIScreen mainScreen] applicationFrame];
    
    DCFExampleView *view = [[DCFExampleView alloc] initWithFrame:rect];
    
    //local
    _dcfExampleView = view;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.f target:self selector:@selector(redrawFrame:) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - Custom methods

- (void)redrawFrame:(NSTimer *)timer {
    [_button.dcfView setHidden:NO];
    [_button.dcfView drawBezierAnimated:YES];
    [_dcfExampleView.button.dcfView drawBezierAnimated:YES];
}

- (void)setupNavigationItems {
    _button = [[DCFButton alloc] init];
    [_button.dcfView setLineColor:[UIColor greenColor]];
    
    __weak __typeof(_button)weakButton = _button;
    [_button.dcfView setCompletionBlock:^{
        [weakButton.dcfView setHidden:YES];
    }];
    
    [_button setTitle:NSLocalizedString(@"Highlight me!", nil) forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    CGSize buttonSize = [_button.titleLabel.text ios67sizeWithFont:_button.titleLabel.font constrainedToSize:CGSizeMake(200.f, 70.f)];
    _button.frame = CGRectMake(0.0, 0.0, buttonSize.width, buttonSize.height);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_button];
    [self.navigationItem setLeftBarButtonItem:item];
}

@end