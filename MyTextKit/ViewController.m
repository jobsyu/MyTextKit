//
//  ViewController.m
//  MyTextKit
//
//  Created by  ShiShu on 15-8-3.
//  Copyright (c) 2015年  ShiShu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    //指定文本的区域，默认为矩形
    NSTextContainer *_textContainer;
    //用于存储文本和文本相关的属性
    NSTextStorage *_textSorage;
}
@end

@implementation ViewController

- (void)viewDidLoad {
/* 这端代码是让文字以特定要求排版*/
    [super viewDidLoad];
    //x方向缩小10，y方向缩小20.
    CGRect textViewRect = CGRectInset(self.view.bounds,10,20);
    //存储文字的对象
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:_myTextView.text];
    //排版对象
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    //容器对象,设定文字的显示区域,默认为矩形
    _textContainer = [[NSTextContainer alloc] initWithSize:textViewRect.size];
    [layoutManager addTextContainer:_textContainer];
    [_myTextView removeFromSuperview];
    _myTextView = (UITextView *)[[UITextView alloc] initWithFrame:textViewRect textContainer:_textContainer];
    _myTextView.editable = NO;
    [self.view insertSubview:_myTextView belowSubview:_myImageView];
    [textStorage beginEditing];
    //设置凸版印刷效果
    NSDictionary *dic = @{NSTextEffectAttributeName:NSTextEffectLetterpressStyle,NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20]};
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:_myTextView.text attributes:dic];
    [textStorage setAttributedString:attString];
    [self createWord:@"北京时间" inStorage:textStorage];
    [self createWord:@"Lorem" inStorage:textStorage];
    [textStorage endEditing];
/*上面是让文字进行排版*/
    //指定环绕路径
    _myTextView.textContainer.exclusionPaths = @[[self translatedBezierPath]];/*****///这句话是让图文混排
    // Do any additional setup after loading the view, typically from a nib.
}

//获取贝塞尔曲线的路径(两个端点和端点的切线确定的图形)
- (UIBezierPath *)translatedBezierPath{
    CGRect  imageRect = [_myTextView convertRect:_myImageView.frame fromView:self.view];
    //拿到图片的贝塞尔曲线
    UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:imageRect];
    return newPath;
}

//将指定的文字放入文本存储对象中
- (void)createWord:(NSString *)word inStorage:(NSTextStorage *)storage{
    //正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:word options:0 error:nil];
    //通过正则表达式，筛选出指定的文字，并设置颜色
    NSArray *matches = [regex matchesInString:_myTextView.text options:0 range:NSMakeRange(0,[_myTextView.text length])];
    for (NSTextCheckingResult *match in matches) {
        NSRange matchRange = [match range];
        [storage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:matchRange];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
