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
        state=0;
        
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
        
        
        for (int i=0; i<4; i++) {
            for (int j=0; j<4; j++) {
                planeModels* piece=[planeModels creatWithtype:i];
                pieces[i][j]=piece;
                [self addChild:piece z:2 tag:PIECE_TAG];
            }
        }
        
//        piece=[planeModels creatWithtype:RED];
//        piece.visible=YES;
//        [self addChild:piece z:2];
        
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
-(void) move:(planeModels*) piece{
    int point=(int)(rand()%6)+1;
    [label setString:[NSString stringWithFormat:@"move:%d",point]];
    CGSize winSize=[[CCDirector sharedDirector] winSize];
    [label setPosition:ccp(winSize.width-label.contentSize.width, winSize.height-label.contentSize.height)];
    [piece incrementPosition:point];
}
-(planeModels *) chosenPiece{
    int i=rand()%4;
    planeModels *chosenPiece=pieces[state][i];
    return chosenPiece;
}
-(BOOL)ccKeyDown:(NSEvent *)event{
    NSLog(@"keycode:%d",[event keyCode]);
    [self move:[self chosenPiece]];
    state=(state+1)%4;
    short keyCode=[event keyCode];
//    if (keyCode==36) {
//        [piece incrementPosition];
//        [piece updatePosition];
//        NSString* type;
//        switch ([piece getPositionType]) {
//            case YELLOW:
//                type=@"YELLOW";
//                break;
//            case BLUE:
//                type=@"BLUE";
//                break;
//            case GREEN:
//                type=@"GREEN";
//                break;
//            case RED:
//                type=@"RED";
//                break;
//            default:
//                type=@"Error";
//                break;
//        }
//        [label setString:type];
//    }
    if (keyCode==49) {
        NSLog(@"%@",positionFile);
    }
    return YES;
}

+(CCScene *)scene{
    CCScene* scene=[CCScene node];
    GameLayer* layer=[GameLayer node];
    [scene addChild:layer];
    return scene;
}

@end
