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
        
        self.backgroundColor = [SKColor colorWithRed:0.1f green:0.3f blue:0.1f alpha:1.0f];
    }
    return self;
}

#pragma mark - game loop

-(void)update:(CFTimeInterval)currentTime {
    //do nothing...
}

#pragma mark - touch handler

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInNode:self];
    NSLog(@"TOUCH: (%.1f,%.1f)", pos.x, pos.y);
    
    SKSpriteNode *alien = [SKSpriteNode spriteNodeWithImageNamed:@"alien1.png"];
    alien.position = pos;
    [self addChild:alien];
    
    SKAction *move = [SKAction moveByX:13.0f y:37.0f duration:0.5f];
    SKAction *rotate = [SKAction rotateByAngle:-M_PI duration:0.5f];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.5f];
    SKAction *remove = [SKAction removeFromParent];
    
    // Try some other actions...
    
    // 1. wait
    //SKAction *wait = [SKaction waitForDuration:1.0f];
    
    // 2. fadeIn
    //SKAction *fadeIn = [SKAction fadeInWithDuration:1.0f];
    
    // 3. scale
    //SKAction *doubleSize = [SKAction scaleTo:2.0f duration:1.0f];
    //SKAction *halfSize = [SKAction scaleTo:0.5f duration:1.0f];
    
    // 4. colorize
    //SKAction *blue = [SKAction colorizeWithColor:[UIColor blueColor] colorBlendFactor:1.0f duration:1.0f];
    //SKAction *green = [SKAction colorizeWithColor:[UIColor greenColor] colorBlendFactor:1.0f duration:1.0f];
    
    // 5. actions in parallel
    //SKAction *parallel = [SKAction group:@[move,rotate]];
    
    // run actions on alien
    [alien runAction:[SKAction sequence:@[move, rotate, fadeOut, remove]]];
}

@end