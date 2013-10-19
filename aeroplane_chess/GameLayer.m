//
//  GameLayer.m
//  aeroplane_chess
//
//  Created by DarwinSenior on 13-10-18.
//  Copyright 2013年 DarwinSenior. All rights reserved.
//

#import "GameLayer.h"

enum spriteTag {
    BOARD_TAG = 1,
    PIECE_TAG = 2,
    };
static NSMutableString *positionFile;
@implementation GameLayer


- (id)init
{
    
    self = [super init];
    if (self) {
        positionFile=[[NSMutableString alloc] init];
        NSLog(@"INTO THE GAMEPLAYER");
        CGSize winSize=[[CCDirector sharedDirector] winSize];
        
        CCSprite* board=[CCSprite spriteWithFile:@"board.jpg"];
        float boardX=winSize.width*0.5;
        float boardY=winSize.height*0.5;
        float scale=min(winSize.height/board.contentSize.height*0.8, winSize.width/board.contentSize.width*0.8);
        [board setPosition:ccp(boardX, boardY)];
        [board setScale:scale];
        [self addChild:board z:1 tag:BOARD_TAG];
        
        piece=[planeModels creatWithtype:RED];
        piece.visible=YES;
        [self addChild:piece z:2];
        
        label=[CCLabelTTF labelWithString:@"HelloWorld" fontName:@"Times" fontSize:30];
        
        [self addChild:label z:2];
        [label setPosition:ccp(winSize.width-label.contentSize.width, winSize.height-label.contentSize.height)];
    
        
        _mouseEnabled=YES;
        _keyboardEnabled=YES;
    }
    return self;
}

-(BOOL)ccMouseDown:(NSEvent *)event{
    CGPoint clickAt=[(CCDirectorMac*)[CCDirector sharedDirector] convertEventToGL:event];
    NSLog(@"Clicked");
    [positionFile appendFormat:@"{%d,%d},\n",(int)clickAt.x, (int)clickAt.y];
    NSLog(@"%d %d",(int)clickAt.x, (int)clickAt.y);

    return YES;
}
-(void) move{
    int point=(int)(CCRANDOM_0_1()*6)+1;
    [label setString:[NSString stringWithFormat:@"move:%d",point]];
    CGSize winSize=[[CCDirector sharedDirector] winSize];
    [label setPosition:ccp(winSize.width-label.contentSize.width, winSize.height-label.contentSize.height)];
    [piece incrementPosition:point];
}
-(BOOL)ccKeyDown:(NSEvent *)event{
    NSLog(@"keycode:%d",[event keyCode]);
    [self move];
    short keyCode=[event keyCode];
////    if (keyCode==36) {
////        [piece incrementPosition];
////        [piece updatePosition];
////        NSString* type;
////        switch ([piece getPositionType]) {
////            case YELLOW:
////                type=@"YELLOW";
////                break;
////            case BLUE:
////                type=@"BLUE";
////                break;
////            case GREEN:
////                type=@"GREEN";
////                break;
////            case RED:
////                type=@"RED";
////                break;
////            default:
////                type=@"Error";
////                break;
////        }
////        [label setString:type];
////    }
//    if (keyCode==49) {
//        NSLog(@"%@",positionFile);
//    }
//    switch (keyCode) {
//        case 15:
//            [positionFile appendFormat:@"RED, "];
//            break;
//        case 11:
//            [positionFile appendFormat:@"BLUE, "];
//            break;
//        case 16:
//            [positionFile appendFormat:@"YELLOW, "];
//            break;
//        case 5:
//            [positionFile appendFormat:@"GREEN, "];
//            break;
//        default:
//            break;
//    }
    return YES;
}

+(CCScene *)scene{
    CCScene* scene=[CCScene node];
    GameLayer* layer=[GameLayer node];
    [scene addChild:layer];
    return scene;
}

@end
