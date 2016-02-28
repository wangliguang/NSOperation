//
//  CoustomOperation.h
//  NSOperation
//
//  Created by GG on 16/2/26.
//  Copyright © 2016年 GG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CoustomOperation : NSOperation

//接收传进来的图片对象
@property (nonatomic,retain) UIImageView *imageView;

//在该该类对象初始化时，将图片试图对象传到类中。
- (instancetype)initWithImageView:(UIImageView *)imageView;

@end
