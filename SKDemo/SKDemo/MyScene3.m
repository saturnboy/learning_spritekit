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
@property (nonatomic) SKAction *flyAnim;
@property (nonatomic) SKAction *hit;
@property (nonatomic) SKAction *miss;
@end

static inline CGPoint ADD(const CGPoint a, const CGPoint b) {
    return CGPointMake(a.x + b.x, a.y + b.y);
}

@implementation MyScene3

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene3: sz=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:0.3 green:0.1 blue:0.1 alpha:1.0];
        
        //init center
        _center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        //init sounds
        _hit = [SKAction playSoundFileNamed:@"fire.wav" waitForCompletion:NO];
        _miss = [SKAction playSoundFileNamed:@"miss.wav" waitForCompletion:NO];
        
        //create atlas
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"alien"];
        SKTexture *a1 = [atlas textureNamed:@"alien1.png"];
        SKTexture *a2 = [atlas textureNamed:@"alien2.png"];
        SKTexture *a3 = [atlas textureNamed:@"alien3.png"];
        SKTexture *a4 = [atlas textureNamed:@"alien4.png"];
        SKTexture *a5 = [atlas textureNamed:@"alien5.png"];
        SKTexture *a6 = [atlas textureNamed:@"alien6.png"];
        SKTexture *a7 = [atlas textureNamed:@"alien7.png"];
        SKTexture *a8 = [atlas textureNamed:@"alien8.png"];
        SKTexture *a9 = [atlas textureNamed:@"alien9.png"];
        SKTexture *a10 = [atlas textureNamed:@"alien10.png"];
        NSArray *alienFly = @[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a9,a8,a7,a6,a5,a4,a3,a2,a1];

        //create sprite
        _alien = [SKSpriteNode spriteNodeWithTexture:a1];
        _alien.position = _center;
        [self addChild:_alien];
        
        //1. Try faster, slower, repeating texture anim
        _flyAnim = [SKAction animateWithTextures:alienFly timePerFrame:0.1];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint loc = [touch locationInNode:self];
    
    if ([_alien containsPoint:loc]) {
        //2. Try to adjust positioning for iPhone vs iPad
        float x = (float)arc4random_uniform(201) - 100.0f;
        float y = (float)arc4random_uniform(201) - 100.0f;
        NSLog(@"HIT!: (%.1f,%.1f)", x, y);
        
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.1];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.1];
        SKAction *move = [SKAction moveTo:ADD(_center, CGPointMake(x,y)) duration:0.1];
        SKAction *bg = [SKAction runBlock:^{
            float red = CGColorGetComponents(self.backgroundColor.CGColor)[0] + 0.04f;
            if (red > 0.8) { red = 0.3f; }
            self.backgroundColor = [SKColor colorWithRed:red green:0.1 blue:0.1 alpha:1.0];
        }];

        [_alien runAction:[SKAction sequence:@[
                                               _hit,
                                               fadeOut,
                                               [SKAction group:@[move,bg]],
                                               fadeIn,
                                               _flyAnim]]
                  withKey:@"ANIM"];
    } else {
        NSLog(@"miss");
        [_alien runAction:_miss];
    }
}

@end
