//
//  MyScene4.m
//  SKDemo
//
//  Created by Justin on 11/4/13.
//  Copyright (c) 2013 Saturnboy. All rights reserved.
//

#import "MyScene4.h"

@interface MyScene4 ()

@property (nonatomic) CGPoint center;
@property (nonatomic) SKAction *anim;
@property (nonatomic) SKTextureAtlas *atlas;

@end

@implementation MyScene4

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene4: sz=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:0.3f green:0.1f blue:0.3f alpha:1.0f];
        
        //init center
        _center = CGPointMake(size.width * 0.5f, size.height * 0.5f);
        
        //create atlas with all anim frames
        _atlas = [SKTextureAtlas atlasNamed:@"alien"];
        SKTexture *a1 = [_atlas textureNamed:@"alien1"];
        SKTexture *a2 = [_atlas textureNamed:@"alien2"];
        SKTexture *a3 = [_atlas textureNamed:@"alien3"];
        SKTexture *a4 = [_atlas textureNamed:@"alien4"];
        SKTexture *a5 = [_atlas textureNamed:@"alien5"];
        SKTexture *a6 = [_atlas textureNamed:@"alien6"];
        SKTexture *a7 = [_atlas textureNamed:@"alien7"];
        SKTexture *a8 = [_atlas textureNamed:@"alien8"];
        SKTexture *a9 = [_atlas textureNamed:@"alien9"];
        SKTexture *a10 = [_atlas textureNamed:@"alien10"];
        
        //create animation
        _anim = [SKAction animateWithTextures:@[a1,a2,a3,a4,a3,a2,a1]
                                    timePerFrame:0.2f];
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
    
    SKSpriteNode *alien = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"alien1"]];
    alien.position = pos;
    alien.alpha = 0.0f;
    [self addChild:alien];
    
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.5f];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.5f];

    [alien runAction:[SKAction sequence:@[fadeIn,_anim,fadeOut]]];
}

@end