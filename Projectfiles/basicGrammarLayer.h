//
//  basicGrammarLayer.h
//  LOLGramatik
//
//  Created by Jan Brond on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface basicGrammarLayer  : CCLayer {
    double scale;
    CGSize size;
}

-(CGPoint) getTekstPosition;
-(CGPoint) getBanner1Position;
-(CGPoint) getCube1Position;
-(CGPoint) getBanner2Position;
-(CGPoint) getCube2Position;
-(CGPoint) getGrammarCube1;
-(CGPoint) getGrammarCube2;
-(CGPoint) getGrammarBanner;
-(CGPoint) getGrammarLevel1;
-(CGPoint) getGrammarLevel2;
-(CGPoint) getGrammarLevel3;
-(CGPoint) getGrammarLevel4;
-(CGPoint) getGrammarLevel5;
-(CGPoint) getGrammarLine1Only;
-(CGPoint) getGrammarLine1;
-(CGPoint) getGrammarLine2;
-(CGPoint) getCheckMark;
-(CGPoint) getTimePosition;
-(CGPoint) getSentenceNumberPosition;
-(CGPoint) getAdditionTab;
-(CGPoint) getSubtractionTab;
-(CGPoint) getMultiplicationTab;
-(CGPoint) getDivisionTab;
-(CGPoint) getStarTab;

-(CGPoint) getFirstWheel;
-(CGPoint) getSecondWheel;
-(CGPoint) getSymbolWheel;
-(CGPoint) getResultWheel;
-(CGPoint) getEqualsSign;
-(CGPoint) getFirstNumberLabel:(int) pos;
-(CGPoint) getSecondNumberLabel:(int) pos;
-(CGPoint) getResultNumberLabel:(int) pos;
-(double) getScale;
@end
