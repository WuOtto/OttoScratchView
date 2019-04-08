//
//  ViewController.m
//  OttoScratchView
//
//  Created by halo on 2019/4/4.
//  Copyright © 2019 otto. All rights reserved.
//

#import "ViewController.h"
#import "OttoScratchView.h"

@interface ViewController ()<OttoScratchViewDelegate>

@property (nonatomic,strong) OttoScratchView * ottoScratchView;
@property (nonatomic,copy) NSString * answer;
@property (nonatomic,strong) UILabel *aLabel;
@property (nonatomic,strong) UILabel *answerLabel;
@property (nonatomic,strong) UIImageView *coverImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.answer = @"小脑斧";
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth - 272) / 2.0, (screenHeight - 82) / 2.0, 272, 82)];
    
    self.coverImageView.image = [UIImage imageNamed:@"btn_scratch_normal"];
    [self.view addSubview:self.coverImageView];
    
    self.answerLabel = [[UILabel alloc] initWithFrame:self.coverImageView.frame];
    self.answerLabel.font = [UIFont boldSystemFontOfSize:30];
    self.answerLabel.backgroundColor = [UIColor colorWithRed:254/255.0 green:194/255.0 blue:12/255.0 alpha:1.0];
    self.answerLabel.textColor = [UIColor whiteColor];
    self.answerLabel.numberOfLines = 0;
    [self.answerLabel setTextAlignment:(NSTextAlignmentCenter)];
    self.answerLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.answerLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((screenWidth - 136) / 2.0, CGRectGetMaxY(self.coverImageView.frame) + 40, 136, 41);
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [btn setBackgroundColor:[UIColor colorWithRed:103/255.0 green:170/255.0 blue:246/255.0 alpha:1]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"再刮一次" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(againAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //103 170 246
    [self ottoSetScratchView];
}

- (void)againAction{
    [self ottoSetScratchView];
}

- (void)scratchViewDone{
    [self.ottoScratchView removeFromSuperview];
    [self.answerLabel setHidden:NO];
}

- (void)ottoSetScratchView{
    [self.ottoScratchView removeFromSuperview];
    [self.answerLabel setHidden:YES];
    self.ottoScratchView = [[OttoScratchView alloc] initWithFrame:self.coverImageView.frame];
    self.ottoScratchView.delegate = self;
    self.ottoScratchView.scratchLineWidth = 14;
    self.ottoScratchView.passCount = 9;
    self.aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.coverImageView.frame.size.width, self.coverImageView.frame.size.height)];
    self.aLabel.text = self.answer;
    self.answerLabel.text = self.answer;
    self.aLabel.font = [UIFont boldSystemFontOfSize:30];
    self.aLabel.backgroundColor = [UIColor colorWithRed:254/255.0 green:194/255.0 blue:12/255.0 alpha:1.0];
    self.aLabel.textColor = [UIColor whiteColor];
    self.aLabel.numberOfLines = 0;
    [self.aLabel setTextAlignment:(NSTextAlignmentCenter)];
    self.aLabel.adjustsFontSizeToFitWidth = YES;
    [self.ottoScratchView addSubview:self.aLabel];

    [self.view addSubview:self.ottoScratchView];
}

@end
