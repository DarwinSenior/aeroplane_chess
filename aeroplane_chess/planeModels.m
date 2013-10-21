//
//  planeModels.m
//  aeroplane_chess
//
//  Created by DarwinSenior on 13-10-18.
//  Copyright 2013年 DarwinSenior. All rights reserved.
//

#import "planeModels.h"

static const float AbusolutePosition[72][2]={
    {289,322},
    {303,322},
    {320,321},
    {337,315},
    {344,296},
    {346,280},
    {336,262},
    {353,246},
    {372,255},
    {386,254},
    {405,248},
    {412,230},
    {413,212},
    {412,199},
    {412,182},
    {412,166},
    {404,148},
    {388,141},
    {371,141},
    {353,149},
    {338,134},
    {346,115},
    {346,101},
    {336,84},
    {319,75},
    {304,74},
    {288,75},
    {273,74},
    {257,75},
    {238,82},
    {231,101},
    {231,115},
    {238,134},
    {224,149},
    {205,141},
    {190,141},
    {173,150},
    {164,168},
    {165,183},
    {165,198},
    {165,213},
    {164,230},
    {172,245},
    {190,253},
    {206,252},
    {223,248},
    {239,263},
    {231,279},
    {232,295},
    {240,314},
    {257,322},
    {272,322},
    {290,298},
    {289,280},
    {289,265},
    {289,248},
    {289,232},
    {388,198},
    {371,199},
    {354,197},
    {337,198},
    {322,197},
    {288,97},
    {288,114},
    {289,131},
    {287,146},
    {288,163},
    {191,198},
    {207,199},
    {224,198},
    {240,199},
    {256,199},
    };
static const PieceType posType[]={
    YELLOW, RED, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, RED, BLUE, RED, YELLOW, RED, BLUE, GREEN, YELLOW, RED, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, YELLOW, YELLOW, YELLOW, YELLOW, GREEN, GREEN, GREEN, GREEN, GREEN, BLUE, BLUE, BLUE, BLUE, BLUE, RED, RED, RED, RED, RED,
};
static const float InitPosition[4][4][2]={
    {
        {371,117},
        {385,116},
        {372,101},
        {386,100},
    },//GREEN
    {
        {191,115},
        {206,115},
        {206,99},
        {191,99},

    },//BLUE
    {
        {206,294},
        {194,295},
        {192,284},
        {205,282},
    },//RED
    {
        {373,295},
        {390,295},
        {388,279},
        {373,279},
    },//YELLOW
};
static const int initPosition[4]={16,29,42,3};
static int count=0;

@implementation planeModels

+(id)creatWithtype:(PieceType)type{
    planeModels* modle=[[planeModels alloc]initWithType:type];
    return modle;
}
-(BOOL)incrementPosition:(int) point{
    NSLog(@"Type:%d,Pos:%d, id:%d",_type,_gridPos,_id);
    assert(point>0 && point<=6);
    if (!_isOut) {
        _isOut=(point==6);
        return _isOut;
    }
    NSLog(@"Point:%d",point);
    _gridPos=(_gridPos+point)%52;
    [self updatePosition];
    if ([self getPositionType]==_type) {
        _gridPos=(_gridPos+1)%52;
        while ([self getPositionType]!=_type) {
            _gridPos=(_gridPos+1)%52;
        }
    }
    [self updatePosition];
    NSLog(@"pos%d", _gridPos);
    return YES;
}
-(void)returnBack{
    [self initPosition];
    _isOut=NO;
    [self updatePosition];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"Type:%d, Pos:%d, ID:%d",_type,_gridPos,_id];
}

/*=============Public and Private Seperator=========================*/

-(CGPoint)getPosition{
    if (!_isOut) {
        return ccp(InitPosition[_type][_id][0], InitPosition[_type][_id][1]);
    }
    return ccp(AbusolutePosition[_gridPos][0], AbusolutePosition[_gridPos][1]);
}
-(PieceType)getPositionType{
    return posType[_gridPos];
}
-(void)updatePosition{
    //TODO Do something with animation.
    
    //[self runAction:[CCMoveTo actionWithDuration:1 position:[self getPosition]]];
    [self setPosition:[self getPosition]];
}
- (id)initWithType:(PieceType)type
{
    NSString* fileNames[4]={@"Green.png",@"Blue.png",@"Red.png",@"Yellow.png"};
    self=[super initWithFile:fileNames[type]];
    if (self) {
        float piceScale=15/self.contentSize.height;
        [self setScale:piceScale];
        _type=type;
        _isOut=NO;
        _id=[planeModels getID:_type];
        [self initPosition];
        [self updatePosition];
    }
    return self;
}

+(int) getID:(PieceType)type{
    int theid=0;
    int numLevel[4]={1,10,100,1000};
    theid=(count/numLevel[type])%10;
    count+=numLevel[type];
    assert(theid<=4);
    return theid;
}
-(void) initPosition{
    _gridPos=initPosition[_type];
}
@end
