//
//  MenuScene.m
//  aeroplane_chess
//
//  Created by DarwinSenior on 13-10-18.
//  Copyright 2013年 DarwinSenior. All rights reserved.
//

#import "MenuScene.h"
#import "GameLayer.h"


@implementation MenuScene

- (id)init
{
    self = [super init];
    if (self) {
        CCMenuItemFont* newGame=[CCMenuItemFont itemWithString:@"NewGame" target:self selector:@selector(toNewGame)];
        CCMenu* menu=[CCMenu menuWithItems:newGame, nil];
        [menu alignItemsHorizontally];
        [self addChild:menu];
    }
    return self;
}
+(CCScene *)scene{
    CCScene* scene=[CCScene node];
    MenuScene* layer=[MenuScene node];
    [scene addChild: layer];
    return scene;
}
-(void)toNewGame{
    CCScene* scene=[GameLayer scene];
    [[CCDirector sharedDirector] replaceScene:scene];
}
@end
