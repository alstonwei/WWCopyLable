//
//  WWCopyLable.m
//  
//
//  Created by shouqiangwei on 16/2/29.
//  Copyright © 2016年 shouqiangwei. All rights reserved.
//

#import "WWCopyLable.h"

@implementation WWCopyLable


- (instancetype)init
{
    if (self = [super init]) {
        [self setupTapAction];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTapAction];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super initWithCoder:aDecoder]) {
        [self setupTapAction];
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupTapAction];
}



- (BOOL)canBecomeFirstResponder{
    return YES;
}


-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy:));
}


-(void)copy:(id)sender{
    NSString* copyStr = self.text;
    if (self.attributedText) {
        copyStr = self.attributedText.string;
    }
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = copyStr;
}


-(void)setupTapAction{
    self.userInteractionEnabled = YES;
    //双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleTap];
    
    //长按压
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    press.minimumPressDuration = 0.5;
    [self addGestureRecognizer:press];
}



-(void)handleTap:(UIGestureRecognizer*) recognizer{
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    //UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
    //[menu setMenuItems:[NSArray arrayWithObjects:copy, nil]];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}


@end
