//
//  planeModels.h
//  aeroplane_chess
//
//  Created by DarwinSenior on 13-10-18.
//  Copyright 2013年 DarwinSenior. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum{
    GREEN = 0,
    BLUE = 1,
    RED = 2,
    YELLOW = 3
    }PieceType;
@interface planeModels : CCSprite {
    int _gridPos;
    BOOL _isOut;
    PieceType _type;
    int _id;
}
+(id) creatWithtype:(PieceType)type;
-(BOOL) incrementPosition:(int) point;


-(void) returnBack;
@end
