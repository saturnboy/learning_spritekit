//
//  MyScene1.m
//  SKDemo
//
//  Created by Justin on 11/4/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MyScene1.h"

@interface MyScene1 ()
@property (nonatomic) SKSpriteNode *ship;
@end

static inline CGPoint ADD(const CGPoint a, const CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

@implementation MyScene1

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene1: sz=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:1.0];
        
        _ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        _ship.position = CGPointMake(0, 0);
        _ship.xScale = 0.25;
        _ship.yScale = 0.25;
        [self addChild:_ship];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInNode:self];
    _ship.position = loc;
}

-(void)update:(CFTimeInterval)currentTime {
    // 1. Make it move faster, slower, backwards, etc...
    // 2. Make it get bigger, smaller (xScale, yScale)
    // 3. Make it rotate (zRotation)
    // 4. Make it bounce at the edges...
    _ship.position = ADD(_ship.position, CGPointMake(1,1));
}

@end
