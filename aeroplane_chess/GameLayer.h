//
//  GameLayer.h
//  aeroplane_chess
//
//  Created by DarwinSenior on 13-10-18.
//  Copyright 2013年 DarwinSenior. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "planeModels.h"

@interface GameLayer : CCLayer {
    planeModels *pieces[4][4];
    CCLabelTTF *label;
    PieceType state;
}
+(CCScene*) scene;
@end
