//
//  MyScene3.m
//  SKDemo
//
//  Created by Justin on 11/4/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MyScene3.h"

@interface MyScene3 ()

@property (nonatomic) SKSpriteNode *alien;
@property (nonatomic) CGPoint center;
@property (nonatomic) SKAction *hit;
@property (nonatomic) SKAction *miss;

@end

@implementation MyScene3

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene3: sz=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:0.3f green:0.1f blue:0.1f alpha:1.0f];
        
        //init center
        _center = CGPointMake(size.width * 0.5f, size.height * 0.5f);
        
        //init sounds
        _hit = [SKAction playSoundFileNamed:@"fire.wav" waitForCompletion:NO];
        _miss = [SKAction playSoundFileNamed:@"miss.wav" waitForCompletion:NO];

        //init sprite
        _alien = [SKSpriteNode spriteNodeWithImageNamed:@"alien1.png"];
        _alien.position = _center;
        [self addChild:_alien];
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
    
    if ([_alien containsPoint:pos]) {
        NSLog(@"HIT!");
        
        //2. How would you adjust positioning for iPhone vs iPad
        
        //compute the new position
        CGPoint newPos = CGPointMake(_center.x + arc4random_uniform(201) - 100.0f,
                                  _center.y + arc4random_uniform(201) - 100.0f);
        
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.2f];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.2f];
        SKAction *move = [SKAction moveTo:newPos duration:0.2f];

        [_alien runAction:[SKAction sequence:@[_hit,fadeOut,move,fadeIn]] withKey:@"ANIM"];
    } else {
        NSLog(@"miss");
        [_alien runAction:_miss];
    }
}

@end