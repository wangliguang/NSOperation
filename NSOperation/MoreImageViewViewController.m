//
//  MoreImageViewViewController.m
//  NSOperation
//
//  Created by GG on 16/3/1.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "MoreImageViewViewController.h"

#define kUrl @"http://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/s/38/s38ga/rdgd/s38ga-rdgd-sel-201601?wid=848&hei=848&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1454777389943"

@interface MoreImageViewViewController ()
{
    int imageIndex;
    
    NSOperationQueue *operationQueue;
    
    UIImage *image;
    
}
@end

@implementation MoreImageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //线程控制按钮
    [self controlBtn];
    
    //创建多个UIImageView
    self.title = @"多线程加载多张图片";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    operationQueue = [NSOperationQueue new];
    
    
    imageIndex = 100;
    
    for (int  row= 0; row<3; row++) {
        for (int list = 0; list<2; list++) {
            
            
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10+list*200, 10+row*200, 200, 200)];
            
            imageView.tag = imageIndex++;
            
            [self.view addSubview:imageView];
            
        }
    }
    
    NSBlockOperation *lastBlockOperation=[NSBlockOperation blockOperationWithBlock:^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kUrl]];
        
        image = [UIImage imageWithData:data];
        
        
        
    }];
    
    for (int index = 0; index<6; index++) {
        
        NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
         
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kUrl]];
            
            image = [UIImage imageWithData:data];
            
            [NSThread sleepForTimeInterval:0.5];
            
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
               
                UIImageView *imageView = [self.view viewWithTag:100+index];
            
                imageView.image = image;
                
                
            }];
            
            
        }];
        
        if (index != 0) {
            
            [blockOperation addDependency:operationQueue.operations[index-1]];
            
        }
        
        
        
        [operationQueue addOperation:blockOperation];
        
    }
    
    [operationQueue addOperation:lastBlockOperation];
    
    
    
}

- (void)controlBtn{
    
    
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"暂停",@"开启",@"取消"]];
    
    segment.frame = CGRectMake(50, 620, 300, 50);
    
    segment.apportionsSegmentWidthsByContent = YES;

    [self.view addSubview:segment];
    
    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
}

- (void)clickSegment:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
            
        case 0:{
            
            operationQueue.suspended = YES;
            
        }break;
            
        case 1:{
            
            operationQueue.suspended = NO;
            
        }break;
            
        case 2:{
            
            [operationQueue cancelAllOperations];
            
        };
            
    }
    
    
    
}



@end
