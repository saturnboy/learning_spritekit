//
//  MyScene2.m
//  SKDemo
//
//  Created by Justin on 11/4/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MyScene2.h"

@interface MyScene2 ()
@end

@implementation MyScene2

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene2: sz=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:0.2 green:0.3 blue:0.1 alpha:1.0];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInNode:self];
    
    SKSpriteNode *ship = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    ship.position = loc;
    ship.xScale = 0.2;
    ship.yScale = 0.2;
    [self addChild:ship];
    
    SKAction *hit = [SKAction playSoundFileNamed:@"fire.wav" waitForCompletion:NO];
    SKAction *miss = [SKAction playSoundFileNamed:@"miss.wav" waitForCompletion:NO];
    
    SKAction *move = [SKAction moveByX:-25.0 y:-25.0 duration:1.0];
    SKAction *rotate = [SKAction rotateByAngle:-M_PI_2 duration:1];
    
    SKAction *fade = [SKAction fadeOutWithDuration:1.5];
    SKAction *remove = [SKAction removeFromParent];

    // 1. Other actions to try: colorize, fadeIn, repeat, scaleBy, wait
    [ship runAction:[SKAction sequence:@[
                                         arc4random_uniform(7) < 5 ? hit : miss,
                                         [SKAction group:@[move, rotate]],
                                         fade,
                                         remove]]];
}

@end
