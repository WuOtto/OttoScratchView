//
//  MainViewController.h
//  OttoScratchView
//
//  Created by halo on 2019/4/4.
//  Copyright © 2019 otto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *scratchView;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end

