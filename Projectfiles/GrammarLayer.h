//
//  GrammarLayer.h
//  LOLGramatik
//
//  Created by Jan Brond on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "basicGrammarLayer.h"

typedef enum { noFlip, flipUp, flipDown } cubeRotation;

@interface GrammarLayer : basicGrammarLayer {
    bool isCurrent;
    NSMutableArray * cube1Sprites;
    NSMutableArray * cube2Sprites;
    
    NSMutableArray * levelSprites;
    
    NSMutableArray * mathTypeTabSprites;
    
    NSMutableArray * firstNumberLabels;
    NSMutableArray * secondNumberLabels;
    NSMutableArray * resultLabels;
    NSMutableArray * symbolSprites;
    
    CCLabelTTF *gameTime;
    
    CCSprite * crossMark;
    CCSprite * checkMark;
    
    //The various wheels from which the student can choose the
    //numbers
    CCSprite * firstWheelSprite;
    CCSprite * secondWheelSprite;
    CCSprite * symbolWheelSprite;
    CCSprite * resultWheelSprite;
    
    CCSprite * equalsSprite;
    
    NSDate * startTime;
    
    NSTimer * timeUpdate;
    
    int waitingForNextSentence;
    int previousOrientation;
}

+(id) layerWithLayerNumber:(int)layerNumber;
-(id) initWithLayerNumber:(int)layerNumber;
-(void) goToLayer:(id)sender;
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//-(void) estimateNumberOfLines:(NSString *) str;
@end
