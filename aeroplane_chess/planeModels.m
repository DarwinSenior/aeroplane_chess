//
//  planeModels.m
//  aeroplane_chess
//
//  Created by DarwinSenior on 13-10-18.
//  Copyright 2013年 DarwinSenior. All rights reserved.
//

#import "planeModels.h"

static const float AbusolutePosition[72][2]={
    {598,637},
    {628,637},
    {658,639},
    {692,622},
    {710,585},
    {710,557},
    {692,520},
    {724,490},
    {759,505},
    {790,504},
    {826,492},
    {842,455},
    {841,423},
    {842,394},
    {842,361},
    {842,332},
    {825,295},
    {790,282},
    {760,282},
    {724,296},
    {692,267},
    {711,231},
    {710,201},
    {693,167},
    {658,148},
    {628,150},
    {597,149},
    {564,147},
    {535,150},
    {497,164},
    {483,199},
    {483,230},
    {497,268},
    {467,296},
    {432,281},
    {403,282},
    {367,299},
    {352,331},
    {352,364},
    {351,393},
    {352,424},
    {352,455},
    {367,490},
    {402,501},
    {433,503},
    {467,491},
    {498,522},
    {483,556},
    {484,587},
    {500,621},
    {534,637},
    {565,637},
    {597,590},
    {598,559},
    {597,526},
    {597,495},
    {598,462},
    {795,394},
    {763,394},
    {730,394},
    {697,394},
    {665,394},
    {597,194},
    {596,227},
    {596,260},
    {597,292},
    {596,324},
    {403,395},
    {437,395},
    {468,394},
    {500,395},
    {533,394},
    };
static const PieceType posType[]={
    YELLOW, RED, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, RED, BLUE, RED, YELLOW, RED, BLUE, GREEN, YELLOW, RED, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, GREEN, BLUE, RED, YELLOW, YELLOW, YELLOW, YELLOW, YELLOW, GREEN, GREEN, GREEN, GREEN, GREEN, BLUE, BLUE, BLUE, BLUE, BLUE, RED, RED, RED, RED, RED,
};
static const float InitPosition[4][4][2]={
    {
        {373,116},
        {385,115},
        {386,99},
        {373,99},
    },//GREEN
    {
        {188,116},
        {206,116},
        {192,100},
        {206,101},

    },//BLUE
    {
        {404,588},
        {438,590},
        {436,559},
        {406,559},
    },//RED
    {
        {376,299},
        {393,300},
        {393,284},
        {376,284},
    },//YELLOW
};
static int count=0;

@implementation planeModels

-(CGPoint)getPosition{
    NSLog(@"Getposition %f,%f",AbusolutePosition[_gridPos][0], AbusolutePosition[_gridPos][1]);
//    if (!_isOut) {
//        return ccp(InitPosition[_type][_id][0], InitPosition[_type][_id][1]);
//    }
    return ccp(AbusolutePosition[_gridPos][0], AbusolutePosition[_gridPos][1]);
}
-(PieceType)getPositionType{
    return posType[_gridPos];
}

+(id)creatWithtype:(PieceType)type{
    planeModels* modle=[[planeModels alloc]initWithType:type];
    return modle;
}
-(void)updatePosition{
    //TODO Do something with animation.
    [self setPosition:[self getPosition]];
}
- (id)initWithType:(PieceType)type
{
    switch (type) {
        case YELLOW:
            self=[super initWithFile:@"Yellow.png"];
            break;
        case BLUE:
            self=[super initWithFile:@"Blue.png"];
            break;
        case GREEN:
            self=[super initWithFile:@"Green.png"];
            break;
        case RED:
            self=[super initWithFile:@"Red.png"];
            break;
        default:
            break;
    }
    if (self) {
        float piceScale=30/self.contentSize.width;
        [self setScale:piceScale];
        [self initPosition];
        _type=type;
        _isOut=YES ;
        _id=[planeModels getID:_type];
        [self updatePosition];
    }
    return self;
}
-(void)incrementPosition:(int) point{
    assert(point>0 && point<=6);
    if (!_isOut) {
        NSLog(@"Denied");
        return;
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
}
+(int) getID:(PieceType)type{
    int theid=0;
    switch (type) {
        case GREEN:
            theid=count%10;
            count+=1;
            break;
        case BLUE:
            theid=(count/10)%10;
            count+=10;
            break;
        case RED:
            theid=(count/100)%10;
            count+=100;
            break;
        case YELLOW:
            theid=(count/1000);
            count+=1000;
            break;
        default:
            break;
    }
    assert(theid<=4);
    return theid;
}
-(void) initPosition{
    switch (_type) {
        case RED:
            _gridPos=42;
        case BLUE:
            _gridPos=29;
        case GREEN:
            _gridPos=16;
        case YELLOW:
            _gridPos=3;
        default:
            break;
    }
}
@end
