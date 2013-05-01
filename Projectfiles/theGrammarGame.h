//
//  theGrammarGame.h
//  MyHelloWorld
//
//  Created by Jan Brond on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "Equation.h"

typedef enum { mathPractice, mathGame } mathGameMode;

//This singleton contains the grammar game data

@interface theGrammarGame : NSObject {
    
    //The current mode of the application
    mathGameMode mode;
    //
    
    NSString * team1Cube;
    NSString * team2Cube;
    NSString * team1Name;
    NSString * team2Name;
    
    //Current level working on
    int currentLevel;
    mathType currentMathType;
        
    Equation *equation;
    
    sqlite3 *db;
}

@property (strong, nonatomic) NSString * team1Cube;
@property (strong, nonatomic) NSString * team2Cube;
@property (strong, nonatomic) NSString * team1Name;
@property (strong, nonatomic) NSString * team2Name;
@property (nonatomic) mathGameMode mode;
@property (nonatomic) int currentLevel;
@property (nonatomic) mathType currentMathType;
@property (nonatomic) Equation * equation;

- (void) generate;
-(Boolean) getWheelPositionFixed:(int) position;

+ (theGrammarGame *) instance;
//Returning the number of levels of the game


-(void) saveStatus;
-(void) loadStatus;
//Based on mode it will return either the next sentence of th current level
@end
