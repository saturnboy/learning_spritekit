//
//  MyScene1.m
//  SKDemo
//
//  Created by Justin on 11/4/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MyScene1.h"

@interface MyScene1 ()

@property (nonatomic) SKSpriteNode *alien;

@end

@implementation MyScene1

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene1: sz=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:0.1f green:0.1f blue:0.3f alpha:1.0f];
        
        _alien = [SKSpriteNode spriteNodeWithImageNamed:@"alien1.png"];
        _alien.position = CGPointMake(0.0f, 0.0f);
        [self addChild:_alien];
    }
    return self;
}

#pragma mark - game loop

-(void)update:(CFTimeInterval)currentTime {
    //move it
    _alien.position = CGPointMake(_alien.position.x + 1, _alien.position.y + 1);
    
    // 1. Make it move faster
    //_alien.position = CGPointMake(_alien.position.x + 2, _alien.position.y + 2);
    
    // 2. Make it get bigger, smaller
    //_alien.xScale = ?
    //_alien.yScale = ?
    
    // 3. Make it rotate
    //_alien.zRotation = ?
    
    // 4. Make it bounce at the edges...
}

#pragma mark - touch handler

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInNode:self];
    NSLog(@"TOUCH: (%.1f,%.1f)", pos.x, pos.y);
    
    // move alien to touch pos
    _alien.position = pos;
}

@end