//
//  YQStartButton.h
//  YQDownloadButton
//
//  Created by yingqiu huang on 2017/2/7.
//  Copyright © 2017年 yingqiu huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StartButtonDelegate <NSObject>

- (void)startDownload;

@end

@interface YQStartButton : UIButton

/*代理属性*/
@property (nonatomic,weak) id<StartButtonDelegate> delegate;

@end
