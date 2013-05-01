//
//  basicGrammarLayer.m
//  LOLGramatik
//
//  Created by Jan Brond on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "basicGrammarLayer.h"

@implementation basicGrammarLayer 

-(id) init
{
	if( (self=[super init] )) {
		size = [[CCDirector sharedDirector] winSize];
        
        CGSize ds = [[CCDirector sharedDirector] winSizeInPixels];
        //all sprites are based on the max size of the Ipad 3
        scale = ds.width / 2048;
	}
	return self;
}

//How to adjust the various sprites 
-(double) getScale
{
    return scale;
}

-(CGPoint) getTekstPosition
{
    CGPoint v = {size.width*579/2048, size.height*1137/1536};
    return v;
}
-(CGPoint) getBanner1Position
{
    CGPoint v = {size.width*1176/2048, size.height*894/1536};
    return v;
}

-(CGPoint) getCube1Position
{
    CGPoint v = {size.width*1833/2048, size.height*945/1536};
    return v;
}
-(CGPoint) getBanner2Position
{
    CGPoint v = {size.width*1188/2048, size.height*549/1536};
    return v;
}
-(CGPoint) getCube2Position
{
    CGPoint v = {size.width*1848/2048, size.height*567/1536};
    return v;
}

-(CGPoint) getGrammarCube1
{
    CGPoint v = {size.width*512/2048, size.height*230/1536};
    return v;
}
-(CGPoint) getGrammarCube2
{
    CGPoint v = {size.width*1536/2048, size.height*230/1536};
    return v;
}

//Full size image placed in the middle
-(CGPoint) getGrammarBanner
{
    CGPoint v = {size.width*1024/2048, size.height*768/1536};
    return v;

}

-(CGPoint) getGrammarLevel1
{
    CGPoint v = {size.width*213/2048, size.height*1086/1536};
    return v;
    
}
-(CGPoint) getGrammarLevel2
{
    CGPoint v = {size.width*418/2048, size.height*1090/1536};
    return v;
    
}
-(CGPoint) getGrammarLevel3
{
    CGPoint v = {size.width*648/2048, size.height*1090/1536};
    return v;
    
}
-(CGPoint) getGrammarLevel4
{
    CGPoint v = {size.width*800/2048, size.height*1090/1536};
    return v;
    
}
-(CGPoint) getGrammarLevel5
{
    CGPoint v = {size.width*1039/2048, size.height*1098/1536};
    return v;
    
}

-(CGPoint) getGrammarLine1Only
{
    CGPoint v = {size.width*1024/2048, size.height*768/1536};
    return v;
    
}

-(CGPoint) getGrammarLine1
{
    CGPoint v = {size.width*1024/2048, size.height*904/1536};
    return v;
    
}

-(CGPoint) getGrammarLine2
{
    CGPoint v = {size.width*1024/2048, size.height*654/1536};
    return v;
    
}

-(CGPoint) getCheckMark
{
    CGPoint v = {size.width*1720/2048, size.height*656/1536};
    return v;
    
}

-(CGPoint) getSentenceNumberPosition
{
    CGPoint v = {size.width*1920/2048, size.height*1010/1536};
    return v;
    
}

-(CGPoint) getTimePosition
{
    CGPoint v = {size.width*1024/2048, size.height*230/1536};
    return v;
    
}

-(CGPoint) getAdditionTab
{
    CGPoint v = {size.width*58/2048, size.height*997/1536};
    return v;
    
}

-(CGPoint) getSubtractionTab
{
    CGPoint v = {size.width*63/2048, size.height*881/1536};
    return v;
    
}

-(CGPoint) getMultiplicationTab
{
    CGPoint v = {size.width*56/2048, size.height*752/1536};
    return v;
    
}

-(CGPoint) getDivisionTab
{
    CGPoint v = {size.width*61/2048, size.height*630/1536};
    return v;
    
}

-(CGPoint) getStarTab
{
    CGPoint v = {size.width*55/2048, size.height*514/1536};
    return v;
    
}

-(CGPoint) getFirstWheel
{
    CGPoint v = {size.width*386/2048, size.height*754/1536};
    return v;
    
}

-(CGPoint) getSymbolWheel
{
    CGPoint v = {size.width*708/2048, size.height*750/1536};
    return v;
    
}

-(CGPoint) getSecondWheel
{
    CGPoint v = {size.width*1034/2048, size.height*750/1536};
    return v;
    
}

-(CGPoint) getResultWheel
{
    CGPoint v = {size.width*1712/2048, size.height*754/1536};
    return v;
    
}

-(CGPoint) getEqualsSign
{
    CGPoint v = {size.width*1378/2048, size.height*760/1536};
    return v;
    
}

-(CGPoint) getFirstNumberLabel:(int) pos
{
    CGPoint v = {size.width*380/2048, size.height*(1536-640)/1536};
    
    if (pos==1) {
        v.x = size.width*360/2048;
        v.y = size.height* (1536-755) /1536;
    }
    if (pos==2) {
        v.x = size.width*370/2048;
        v.y = size.height* (1536-880) /1536;
    }
    
    return v;
}

-(CGPoint) getSecondNumberLabel:(int) pos
{
    CGPoint v = {size.width*1034/2048, size.height*(1536-650)/1536};
    
    if (pos==1) {
        v.y = size.height* (1536-766) /1536;
    }
    if (pos==2) {
        v.y = size.height* (1536-888) /1536;
    }
    
    return v;
}

-(CGPoint) getResultNumberLabel:(int) pos
{
    
    CGPoint v = {size.width*1720/2048, size.height*(1536-648)/1536};
    
    if (pos==1) {
        v.x = size.width*1728/2048;
        v.y = size.height* (1536-760) /1536;
    }
    if (pos==2) {
        v.x = size.width*1728/2048;
        v.y = size.height* (1536-888) /1536;
    }
    
    return v;
}

@end

