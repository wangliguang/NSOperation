//
//  ViewController.m
//  NSOperation
//
//  Created by GG on 16/2/26.
//  Copyright © 2016年 GG. All rights reserved.
//

#import "ViewController.h"
#import "CoustomOperation.h"
#define kurl @"http://store.storeimages.cdn-apple.com/8748/as-images.apple.com/is/image/AppleInc/aos/published/images/s/38/s38ga/rdgd/s38ga-rdgd-sel-201601?wid=848&hei=848&fmt=jpeg&qlt=80&op_sharpen=0&resMode=bicub&op_usm=0.5,0.5,0,0&iccEmbed=0&layer=comp&.v=1454777389943"

@interface ViewController ()
{
    UIImageView *imageView;
}
@end

@implementation ViewController

#pragma mark ---------方式一-------------

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
//    [self.view addSubview:imageView];

//    self.view.backgroundColor = [UIColor whiteColor];

//    //1.创建线程操作
//    NSInvocationOperation *invocationOperation1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperation1:) object:kurl];
//    
//    NSInvocationOperation *invocationOperation2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperation2:) object:kurl];
//    
//    //让线程操作开始执行。但是如果这样做的话这个操作将会在主线程中执行，只有将这个操作放进队列，才会开辟一个子线程并直接让这个操作在子线程中执行。
//    //[invocationOperation1 start];
//    
//    //3. 创建一个线程队列
//    NSOperationQueue *operationQueue = [NSOperationQueue new];
//    
//    //4.将创建好的线程放在线程队列中
//    [operationQueue addOperation:invocationOperation1];
//    
//    //设置线程的最大并发数
//    operationQueue.maxConcurrentOperationCount = 1;
//    
//    //设置线程之间的依赖关系
//    [invocationOperation1 addDependency:invocationOperation2];
//    
//    
//    
//    
//}
////2.实现方法选择器的方法
//- (void)invocationOperation1:(NSString *)url{
//
//    NSLog(@"invocationOperation方法所在的线程%@",[NSThread currentThread]);
//    
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kurl]];
//    
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        
//        NSLog(@"更新UI所在的线程%@",[NSThread currentThread]);

//        imageView.image = [UIImage imageWithData:data];
//        
//    
//    }];
//    
//}
//
//- (void)invocationOperation2:(NSString *)url{
//    
//    
//}




#pragma mark ----------方式二-----------



//- (void)viewDidLoad{
//    [super viewDidLoad];
//    
//    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
//    [self.view addSubview:imageView];
//    
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//    //1. 创建线程操作
//    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
//        
//       NSLog(@"blockOperation线程操作所在的线程%@",[NSThread currentThread]);
//
//        
//       NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kurl]];
//        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            
//            
//            NSLog(@"更新UI所在的线程%@",[NSThread currentThread]);
//
//            imageView.image = [UIImage imageWithData:data];
//        }];
//        
//    }];
//    //2.创建线程队列
//    NSOperationQueue *operationQueue = [NSOperationQueue new];
//
      //3.将线程操作放在线程队列中,
//    [operationQueue addOperation:blockOperation];

      //PS：简化以上步骤

//      //1. 创建一个线程队列
//      NSOperationQueue *operationQueue = [NSOperationQueue new];
//
//      //直接利用线程队列的addOperationWithBlock添加线程操作。
//      [operationQueue addOperationWithBlock:^{
//    
//      NSLog(@"更新UI所在的线程%@",[NSThread currentThread]);
//    
//      }];


//
//}






#pragma mark -----------方式三-------------

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
    [self.view addSubview:imageView];
    
    CoustomOperation *coustomOperation = [[CoustomOperation alloc] initWithImageView:(UIImageView *)imageView];
    
    NSOperationQueue *operationQueue = [NSOperationQueue new];
//
    [operationQueue addOperation:coustomOperation];
    
}

@end
