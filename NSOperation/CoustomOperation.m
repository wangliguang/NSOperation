//
//  CoustomOperation.m
//  NSOperation
//
//  Created by GG on 16/2/26.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "CoustomOperation.h"


#define kurl @"http://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/s/38/s38ga/rdgd/s38ga-rdgd-sel-201601?wid=848&hei=848&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1454777389943"


@implementation CoustomOperation

- (instancetype)initWithImageView:(UIImageView *)imageView
{
    self = [super init];
    if (self) {
        
        self.imageView = imageView;
    }
    return self;
}


- (void)main{
    
    //新建一个自动释放池，因为如果是同步操作，该方法能够自动访问到主线程的自动释放池，如果是异步执行操作，那么将无法访问到主线程的自动释放池。
    @autoreleasepool {
        
         NSLog(@"获取图片所在的线程%@",[NSThread currentThread]);
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:kurl]];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
           
            NSLog(@"更新UI所在的线程%@",[NSThread currentThread]);

            self.imageView.image = [UIImage imageWithData:imageData];
            
        }];
        
        
    }
    
}

@end
