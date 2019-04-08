//
//  OttoScratchView.h
//  OttoScratchView
//
//  Created by halo on 2019/4/4.
//  Copyright © 2019 otto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OttoScratchViewDelegate <NSObject>

- (void)scratchViewDone;

@end

@interface OttoScratchView : UIView

@property (nonatomic,assign) id <OttoScratchViewDelegate> delegate;

/**
 *  轨迹的宽度，默认为14
 */
@property (nonatomic,assign) CGFloat scratchLineWidth;
/**
 *  经过多少块撤销图层，默认为10.0，最大为16
 */
@property (nonatomic,assign) NSInteger passCount;

//- (void)initView;

@end
