//
//  MyScene.m
//  SKPhysics
//
//  Created by Justin on 11/15/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsWorld.gravity = CGVectorMake(0.0f, -4.0f); //reduce gravity
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint loc = [touch locationInNode:self];

        if (arc4random_uniform(10) < 5) {
            SKSpriteNode *box = [SKSpriteNode spriteNodeWithImageNamed:@"Box"];
            box.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:box.size];
            box.physicsBody.dynamic = YES;
            box.position = loc;
            [self addChild:box];
        } else {
            SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"Ball"];
            ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width * 0.5f];
            ball.physicsBody.dynamic = YES;
            ball.physicsBody.restitution = 0.6f;
            ball.position = loc;
            [self addChild:ball];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
}

@end
