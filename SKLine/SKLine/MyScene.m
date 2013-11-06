//
//  MyScene.m
//  SKLine
//
//  Created by Justin on 11/4/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MyScene.h"

#define MIN_DIST_SQ 10.0f

@interface MyScene ()
@property (nonatomic) CGPoint prev;
@property (nonatomic) SKShapeNode *line;
@end

static inline float DIST_SQ(const CGPoint a, const CGPoint b) {
    return ((a.x-b.x) * (a.x-b.x) + (a.y-b.y) * (a.y-b.y));
}

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene: size=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKLabelNode *lbl = [SKLabelNode labelNodeWithFontNamed:@"Helvetica-Light"];
        lbl.text = @"draw...";
        lbl.fontSize = 36;
        lbl.fontColor = [UIColor lightGrayColor];
        lbl.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:lbl];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInNode:self];
    _prev = loc;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, loc.x, loc.y);

    _line = [SKShapeNode node];
    _line.strokeColor = [SKColor redColor];
    _line.fillColor = [SKColor clearColor];
    _line.path = path;
    CGPathRelease(path);
    [self addChild:_line];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInNode:self];
    
    if (DIST_SQ(loc, _prev) > MIN_DIST_SQ) {
        _prev = loc;

        CGMutablePathRef path = CGPathCreateMutableCopy(_line.path);
        CGPathAddLineToPoint(path, NULL, loc.x, loc.y);

        _line.path = path;
        CGPathRelease(path);
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    SKAction *fade = [SKAction fadeOutWithDuration:1.5];
    SKAction *remove = [SKAction removeFromParent];
    [_line runAction:[SKAction sequence:@[fade, remove]]];
}

@end
