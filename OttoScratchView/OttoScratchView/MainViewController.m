//
//  MainViewController.m
//  OttoScratchView
//
//  Created by halo on 2019/4/4.
//  Copyright © 2019 otto. All rights reserved.
//

#import "MainViewController.h"
#import "OttoScratchView.h"

@interface MainViewController ()<OttoScratchViewDelegate>

@property (nonatomic,strong) OttoScratchView * ottoScratchView;
@property (nonatomic,copy) NSString * answer;
@property (nonatomic,strong) UILabel *aLabel;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.answer = @"~大西几~";
    
    [self ottoSetScratchView];
}

- (void)scratchViewDone{
    [self.ottoScratchView removeFromSuperview];
    [self.answerLabel setHidden:NO];
}

- (void)ottoSetScratchView{
    [self.ottoScratchView removeFromSuperview];
    [self.answerLabel setHidden:YES];
    self.ottoScratchView = [[OttoScratchView alloc] initWithFrame:CGRectMake(0, 0, self.scratchView.frame.size.width, self.scratchView.frame.size.height)];
    self.ottoScratchView.delegate = self;

    self.ottoScratchView.scratchLineWidth = 14;
    self.ottoScratchView.passCount = 9;
    self.aLabel = [[UILabel alloc] initWithFrame:self.ottoScratchView.frame];
    self.aLabel.text = self.answer;
    self.answerLabel.text = self.answer;
    self.aLabel.font = [UIFont boldSystemFontOfSize:30];
    self.aLabel.backgroundColor = [UIColor colorWithRed:254/255.0 green:194/255.0 blue:12/255.0 alpha:1.0];
    self.aLabel.textColor = [UIColor whiteColor];
    self.aLabel.numberOfLines = 0;
    [self.aLabel setTextAlignment:(NSTextAlignmentCenter)];
    self.aLabel.adjustsFontSizeToFitWidth = YES;
    [self.ottoScratchView addSubview:self.aLabel];

    [self.scratchView insertSubview:self.ottoScratchView belowSubview:self.showButton];
    [self.showButton setHidden:NO];
}

- (IBAction)clickShowButton:(UIButton *)sender {
    [self.showButton setHidden:YES];
}

- (IBAction)recoveryAction:(UIButton *)sender {
    [self ottoSetScratchView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
