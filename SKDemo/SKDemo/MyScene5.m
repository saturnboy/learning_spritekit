//
//  MyScene5.m
//  SKDemo
//
//  Created by Justin on 2/26/14.
//  Copyright (c) 2014 Saturnboy. All rights reserved.
//

#import "MyScene5.h"

@interface MyScene5 ()

@property (nonatomic) SKTextureAtlas *atlas;
@property (nonatomic) SKSpriteNode *alien;
@property (nonatomic) SKSpriteNode *player;
@property (nonatomic) SKAction *anim;
@property (nonatomic) SKAction *fire;
@property (nonatomic) SKAction *miss;
@property (nonatomic,assign) NSInteger alienDir;

@end

@implementation MyScene5

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        NSLog(@"MyScene5: sz=%.1fx%.1f", size.width, size.height);
        
        self.backgroundColor = [SKColor colorWithRed:0.1f green:0.1f blue:0.3f alpha:1.0f];
        
        //init sounds
        _fire = [SKAction playSoundFileNamed:@"fire.wav" waitForCompletion:NO];
        _miss = [SKAction playSoundFileNamed:@"miss.wav" waitForCompletion:NO];
        
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
        _anim = [SKAction animateWithTextures:@[a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a9,a8,a7,a6,a5,a4,a3,a2,a1]
                                    timePerFrame:0.05f];
        
        _alien = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"alien1"]];
        _alien.anchorPoint = CGPointMake(0.5f,1.0f);
        _alien.position = CGPointMake(size.width * 0.5f, size.height - _alien.size.height);
        [self addChild:_alien];
        [_alien runAction:[SKAction repeatActionForever:_anim]];
        
        _player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        _player.anchorPoint = CGPointMake(0.5f,0.0f);
        _player.position = CGPointMake(size.width * 0.5f, _player.size.height);
        [self addChild:_player];
        
        _alienDir = 1.0f;
    }
    return self;
}

#pragma mark - game loop

-(void)update:(CFTimeInterval)currentTime {
    //move alien
    if (_alien.alpha > 0.0f) {
        int x = _alien.position.x + 1.0f * (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 2.0f : 1.0f) * _alienDir;
        
        if (x < _alien.size.width) {
            x = _alien.size.width;
            _alienDir *= -1;
        } else if (x > (self.size.width - _alien.size.width)) {
            x = self.size.width - _alien.size.width;
            _alienDir *= -1;
        }
        
        _alien.position = CGPointMake(x, _alien.position.y);
    }
    
    //move missiles
    [self enumerateChildNodesWithName:@"missile" usingBlock:^(SKNode *node, BOOL *stop) {
        node.position = CGPointMake(node.position.x, node.position.y + 4.0f * (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 2.0f : 1.0f));
        if (node.position.y > self.size.height) {
            //miss
            NSLog(@"miss");
            [self runAction:_miss];
            [node removeFromParent];
        } else if (_alien.alpha > 0.0f && [_alien containsPoint:node.position]) {
            //hit
            NSLog(@"hit");
            _alien.alpha = 0.0f;
            node.alpha = 0.0f;
            [node removeFromParent];
            [_alien runAction:[SKAction sequence:@[[SKAction waitForDuration:0.5f],
                                                   [SKAction runBlock:^{
                _alien.position = CGPointMake(self.size.width * 0.5f + arc4random_uniform(201) - 100.0f,
                                              self.size.height - _alien.size.height);
                _alienDir *= (arc4random() < 0.5f ? -1 : 1);
                _alien.alpha = 1.0f;
            }]]]];
        }
    }];
}

#pragma mark - touch handler

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"FIRE!");
    [self runAction:_fire];
    
    SKSpriteNode *missile = [SKSpriteNode spriteNodeWithImageNamed:@"missile"];
    missile.name = @"missile";
    missile.position = _player.position;
    missile.zPosition = 1.0f;
    missile.alpha = 0.0f;
    [self addChild:missile];
    
    [missile runAction:[SKAction fadeAlphaTo:1.0f duration:0.2f]];
}

@end
