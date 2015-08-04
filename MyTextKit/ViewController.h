//
//  ViewController.h
//  MyTextKit
//
//  Created by  ShiShu on 15-8-3.
//  Copyright (c) 2015年  ShiShu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
//筛选出指定的文字进行设置
- (void)createWord:(NSString *)word inStorage:(NSTextStorage *)storage;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

