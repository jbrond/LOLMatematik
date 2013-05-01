//
//  GrammarLayer.m
//  LOLGramatik
//
//  Created by Jan Brond on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GrammarLayer.h"
#import "CubeCommand.h"
#import "theGrammarGame.h"

int numberMap[7] = { 0, 4, 1, 0, 5, 2, 3};

@implementation GrammarLayer

+(id) layerWithLayerNumber:(int)layerNumber {
	return [[GrammarLayer alloc] initWithLayerNumber:layerNumber];
}

-(id) initWithLayerNumber:(int)layerNumber {
	if( (self=[super init] )) {
        
        waitingForNextSentence = 0;
		//Random background color
		self.isTouchEnabled = YES;
        previousOrientation = -1;
        
        [self registerWithTouchDispatcher];
        
        size = [[CCDirector sharedDirector] winSize];
        
		CCSprite *bg = [CCSprite spriteWithFile:@"bg_grammar.png"];
        bg.position = ccp(size.width/2,size.height/2);
        
        bg.scale = [self getScale];
        [self addChild:bg z:0];		
        
        cube1Sprites = [NSMutableArray new];
        cube2Sprites = [NSMutableArray new];
        levelSprites = [NSMutableArray new];
        mathTypeTabSprites = [NSMutableArray new];
        firstNumberLabels = [NSMutableArray new];
        secondNumberLabels = [NSMutableArray new];
        resultLabels = [NSMutableArray new];
        symbolSprites = [NSMutableArray new];

        //Contains the sprites for the individual words
    
        for (int i=0;i<6;i++) {
            NSString * fname = [[NSString alloc] initWithFormat:@"side%d.png",(i+1)];
            
            //Adding the banners
            CCSprite * sprite = [CCSprite spriteWithFile:fname];
            sprite.scale = [self getScale] * 0.75;
            sprite.position = [self getGrammarCube1];
            [sprite setVisible:false];
            
            [self addChild:sprite];
            
            [cube1Sprites addObject:sprite];
        }
        
        for (int i=0;i<6;i++) {
            NSString * fname = [[NSString alloc] initWithFormat:@"side%d.png",(i+1)];
            
            //Adding the banners
            CCSprite * sprite = [CCSprite spriteWithFile:fname];
            sprite.scale = [self getScale] * 0.75;
            sprite.position = [self getGrammarCube2];
            [sprite setVisible:false];
            
            [self addChild:sprite];
            
            [cube2Sprites addObject:sprite];
        }
        
        CCSprite * banner = [CCSprite spriteWithFile:@"niveaubannermath.png"];
        [banner setPosition:[self getGrammarBanner]];
        [banner setScale: [self getScale]];
        [self addChild:banner];
        
        CCSprite * levelSp = [CCSprite spriteWithFile:@"niveau1.png"];
        [levelSp setPosition:[self getGrammarLevel1]];
        [levelSp setScale: [self getScale]];
        [self addChild:levelSp];
        
        [levelSprites addObject:levelSp];
        
        levelSp = [CCSprite spriteWithFile:@"niveau2.png"];
        [levelSp setPosition:[self getGrammarLevel2]];
        [levelSp setScale: [self getScale]];
        [levelSp setOpacity:128];
        [self addChild:levelSp];
        
        [levelSprites addObject:levelSp];
        
        levelSp = [CCSprite spriteWithFile:@"niveau3.png"];
        [levelSp setPosition:[self getGrammarLevel3]];
        [levelSp setScale: [self getScale]];
        [levelSp setOpacity:128];
        [self addChild:levelSp];
        
        [levelSprites addObject:levelSp];
        
        //adding the add tab sprite
        CCSprite * addTabSprite = [CCSprite spriteWithFile:@"additiontab.png"];
        [addTabSprite setPosition:[self getAdditionTab]];
        [addTabSprite setScale: [self getScale]];
        [self addChild:addTabSprite];
        //[addTabSprite setVisible:false];
        [mathTypeTabSprites addObject:addTabSprite];
        //adding the add tab sprite
        CCSprite * subTabSprite = [CCSprite spriteWithFile:@"subtractiontab.png"];
        [subTabSprite setPosition:[self getSubtractionTab]];
        [subTabSprite setScale: [self getScale]];
        [subTabSprite setOpacity:128];
        [self addChild:subTabSprite];
        //[subTabSprite setVisible:false];
        [mathTypeTabSprites addObject:subTabSprite];
        //adding the add tab sprite
        CCSprite * mulTabSprite = [CCSprite spriteWithFile:@"multiplicationtab.png"];
        [mulTabSprite setPosition:[self getMultiplicationTab]];
        [mulTabSprite setScale: [self getScale]];
        [mulTabSprite setOpacity:128];
        [self addChild:mulTabSprite];
        //[mulTabSprite setVisible:false];
        [mathTypeTabSprites addObject:mulTabSprite];
        //adding the add tab sprite
        CCSprite * divTabSprite = [CCSprite spriteWithFile:@"divisiontab.png"];
        [divTabSprite setPosition:[self getDivisionTab]];
        [divTabSprite setScale: [self getScale]];
        [divTabSprite setOpacity:128];
        [self addChild:divTabSprite];
        
        //[divTabSprite setVisible:false];
        [mathTypeTabSprites addObject:divTabSprite];
        //adding the add tab sprite
        CCSprite * startTabSprite = [CCSprite spriteWithFile:@"startab.png"];
        [startTabSprite setPosition:[self getStarTab]];
        [startTabSprite setScale: [self getScale]];
        [startTabSprite setOpacity:128];
        [self addChild:startTabSprite];
        //[startTabSprite setVisible:false];
        [mathTypeTabSprites addObject:startTabSprite];
        
        firstWheelSprite = [CCSprite spriteWithFile:@"wheel1.png"];
        [firstWheelSprite setPosition:[self getFirstWheel]];
        [firstWheelSprite setScale: [self getScale]];
        [self addChild:firstWheelSprite];
        //[firstWheelSprite setVisible:false];
        
        secondWheelSprite = [CCSprite spriteWithFile:@"wheel2.png"];
        [secondWheelSprite setPosition:[self getSecondWheel]];
        [secondWheelSprite setScale: [self getScale]];
        [self addChild:secondWheelSprite];
        //[secondWheelSprite setVisible:false];
        
        resultWheelSprite = [CCSprite spriteWithFile:@"wheel3.png"];
        [resultWheelSprite setPosition:[self getResultWheel]];
        [resultWheelSprite setScale: [self getScale]];
        [self addChild:resultWheelSprite];
        //[resultWheelSprite setVisible:false]
        
        symbolWheelSprite = [CCSprite spriteWithFile:@"wheel2.png"];
        [symbolWheelSprite setPosition:[self getSymbolWheel]];
        [symbolWheelSprite setScale: [self getScale]];
        [self addChild:symbolWheelSprite];
        [symbolWheelSprite setVisible:false];
        
        equalsSprite = [CCSprite spriteWithFile:@"equals.png"];
        [equalsSprite setPosition:[self getEqualsSign]];
        [equalsSprite setScale: [self getScale]];
        [self addChild:equalsSprite];
        //[symbolWheelSprite setVisible:false];
        
        //Adding the symbol sprites
        for (int i=0;i<4;i++) {
            NSString * fname = [[NSString alloc] initWithFormat:@"symbol%d.png",i];
            
            //Adding the banners
            CCSprite * sprite = [CCSprite spriteWithFile:fname];
            sprite.scale = [self getScale];
            sprite.position = [self getSymbolWheel];
            
            if (i==0) {
                [sprite setVisible:true];
            } else {
                [sprite setVisible:false];
            }
            
            [self addChild:sprite];
            [symbolSprites addObject:sprite];
        }
            
        gameTime = [CCLabelTTF labelWithString:@"13:10" fontName:@"fultonshandregular.ttf" fontSize:30];
        [gameTime setColor:ccRED];
        [gameTime setPosition:[self getTimePosition]];
        
        [self addChild:gameTime];
        
        NSString * number = [[NSString alloc] initWithFormat:@""];
        
        //Creating the nine labels
        for (int n=0;n<3;n++) {
            //Adding the banners
            CCLabelTTF * label = [CCLabelTTF labelWithString:number fontName:@"fultonshandregular.ttf" fontSize:90];
            label.scale = [self getScale] * 0.33;
            [label setColor:ccRED];
            label.position = [self getFirstNumberLabel:n];
            [label setVisible:true];
            
            [self addChild:label];
            
            [firstNumberLabels addObject:label];
        }
        
        for (int n=0;n<3;n++) {
            //Adding the banners
            CCLabelTTF * label = [CCLabelTTF labelWithString:number fontName:@"fultonshandregular.ttf" fontSize:90];
            label.scale = [self getScale] * 0.33;
            [label setColor:ccRED];
            label.position = [self getSecondNumberLabel:n];
            [label setVisible:true];
            
            [self addChild:label];
            
            [secondNumberLabels addObject:label];
        }
        
        for (int n=0;n<3;n++) {
            //Adding the banners
            CCLabelTTF * label = [CCLabelTTF labelWithString:number fontName:@"fultonshandregular.ttf" fontSize:90];
            label.scale = [self getScale] * 0.33;
            [label setColor:ccRED];
            label.position = [self getResultNumberLabel:n];
            [label setVisible:true];
            
            [self addChild:label];
            
            [resultLabels addObject:label];
        }
        
        crossMark = [CCSprite spriteWithFile:@"cross.png"];
        [crossMark setPosition:[self getCheckMark]];
        [crossMark setScale:[self getScale]*2.0];
        [crossMark setVisible:false];
        
        [self addChild:crossMark];
        
        checkMark = [CCSprite spriteWithFile:@"check.png"];
        [checkMark setPosition:[self getCheckMark]];
        [checkMark setScale:[self getScale]*2.0];
        [checkMark setVisible:false];
        
        [self addChild:checkMark];
        
        //Update the lines
        //[self updateText];
        
        [self setCubeSpriteVisible:1 :1];
        [self setCubeSpriteVisible:2 :1];
        
	}
	return self;
}

-(void) updatePlayerWheel:(int) player
{
    int pa = [[[theGrammarGame instance] equation] getPlayerAssignment:player];
    
    switch (pa) {
        case 0: [self updateFirstWeel:[[theGrammarGame instance] getWheelPositionFixed:pa]];
            break;
        case 1: [self updateSecondWeel:[[theGrammarGame instance] getWheelPositionFixed:pa]];
            break;
        case 2: [self updateResultWeel:[[theGrammarGame instance] getWheelPositionFixed:pa]];
            break;
    }
}

-(cubeRotation) cubeRotation:(int) orientation:(int) player
{
    
    cubeRotation rotation = noFlip;
    
    switch (previousOrientation) {
        case 2:
            if (orientation==3)
                rotation = flipUp;
            if (orientation==4)
                rotation = flipDown;
            break;
        case 3:
            if (orientation==1)
                rotation = flipUp;
            if (orientation==2)
                rotation = flipDown;
            break;
        case 1:
            if (orientation==4)
                rotation = flipUp;
            if (orientation==3)
                rotation = flipDown;
            break;
        case 4:
            if (orientation==2)
                rotation = flipUp;
            if (orientation==1)
                rotation = flipDown;
            break;
    }
    
    previousOrientation = orientation;
    
    if (rotation == flipUp) {
        [[[theGrammarGame instance] equation] flipUpUser:player];
    }
    
    if (rotation == flipDown) {
        [[[theGrammarGame instance] equation] flipDownUser:player];
    }
    
    [self updatePlayerWheel:player];
    
    return rotation;
}
-(void) setCubeSpriteVisible:(int) cube : (int) orientation
{
    
    NSLog(@"Orientation %d",orientation);
    
    if (orientation<1 || orientation>6)
        return;
    
    //mapping the correct orientation
    int or = numberMap[orientation];

    if (cube == 1) {
        for (unsigned int i = 0;i< [cube1Sprites count];i++) {
            CCSprite * sprite = [cube1Sprites objectAtIndex:i];
            [sprite setVisible:false];
        
            if (i==(unsigned int)or)
                [sprite setVisible:true];
            
        }
    }
    if (cube == 2) {
        for (unsigned int i = 0;i< [cube2Sprites count];i++) {
            CCSprite * sprite = [cube2Sprites objectAtIndex:i];
            [sprite setVisible:false];
            
            if (i==(unsigned int)or)
                [sprite setVisible:true];
            
        }
    }
}

-(void) finishedSymbols
{
    //Lets check the solution
    [[[theGrammarGame instance] equation] checkSuggestion];
    
    [self updateCheckMark];
    //Update the check mark
    // and no matter what the result is remove it after few sec
    
    waitingForNextSentence = 3;
    
}

-(void)cubeActionUser1:(cubeMessage) cmd:(int) cubeId:(int) iValue
{
    switch (cmd) {
        case msgNone: 
            break;
        case msgHit: //[self addComma];
            break;
        case msgBalance:
            break;
        case msgOrientation:
            [self setCubeSpriteVisible:cubeId:iValue];
            [self cubeRotation:iValue :1];
            break;
        case msgThrow: [self finishedSymbols];
            break;
        case msgShakeStart: 
            break;
        case msgShakeEnd: 
            break;
        case msgShakeDetected: 
            break;
        case msgTiltRight:
            [self flipWheel:1 :1];
            break;
        case msgTiltLeft:
            [self flipWheel:2 :1];
            break;
        case msgTiltShake: [self finishedSymbols];
            break;
        default:
            break;
    }
}

-(void) flipWheel:(int) direction:(int) user
{
    int pa = [[[theGrammarGame instance] equation] getPlayerAssignment:user];
    
    if (direction == 1)
        [[[theGrammarGame instance] equation] flipUp:pa];
    else
        [[[theGrammarGame instance] equation] flipDown:pa];
    
    [self updatePlayerWheel:user];
}

-(void) setSymbol:(int) newSymbol
{
    
}

-(void)cubeActionUser2:(cubeMessage) cmd:(int) cubeId:(int) iValue
{
    switch (cmd) {
        case msgNone: 
            break;
        case msgHit: //[self addComma];
            break;
        case msgBalance:
            break;
        case msgOrientation:
            [self setCubeSpriteVisible:cubeId:iValue];
            //[self setSymbol:iValue];
            [self cubeRotation:iValue :2];
            break;
        case msgThrow: [self finishedSymbols];
            break;
        case msgShakeStart: 
            break;
        case msgShakeEnd: 
            break;
        case msgShakeDetected: 
            break;
        case msgTiltRight: //flip down
            [self flipWheel:1 :2];
            break;
        case msgTiltLeft: //flip up
            [self flipWheel:2 :2];
            break;
        case msgTiltShake:
            [self finishedSymbols];
            break;
        default:
            break;
    }
}

-(Boolean) updateCheckMark
{
    //Well the equation has been solved but is it correct???
    if ([[[theGrammarGame instance] equation] solved]) {
    
        if ([[[theGrammarGame instance] equation] suggestionResult]) {
            //Yes
            [checkMark setVisible:true];
            [crossMark setVisible:false];
        } else {
            [checkMark setVisible:false];
            [crossMark setVisible:true];
        }
    } else {
        [checkMark setVisible:false];
        [crossMark setVisible:false];
    }
    
    return [[[theGrammarGame instance] equation] suggestionResult];
}
//Responding to the messages from the cubes
- (void)cubeMessage:(NSNotification *)note {
    
    NSDictionary *messageCommand = note.userInfo;
    CubeCommand *cubeCommand = [messageCommand objectForKey:@"messageCommand"];
    
    cubeMessage cmd = [cubeCommand message];
    //Now what to do with the cubeCommand???
    NSLog(@"CubeCommand: %d %d",cmd,[cubeCommand cubeId] );

    //based on the cube select what should be done
    if ([cubeCommand cubeId] == 1) {
        [self cubeActionUser1:cmd :[cubeCommand cubeId] :[cubeCommand iValue]];
    } else {
        [self cubeActionUser2:cmd :[cubeCommand cubeId] :[cubeCommand iValue]];
    }
    
}

-(void) updateLevelStatus:(int) newLevel
{
    [[levelSprites objectAtIndex:newLevel] setVisible:true];
}


-(void) switchLevel:(int) level
{
    //Update the suggested symbols on the sentence
    [[theGrammarGame instance] setCurrentLevel:level];
}

//Touch events
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!isCurrent)
        return;
    
    UITouch * touch = [touches anyObject];
    
    //Check the game mode - if practice its ok to switch levels
    if ([[theGrammarGame instance] mode] == mathPractice) {
    
        int cLevel = [[theGrammarGame instance] currentLevel];
        
        for (unsigned int i=0;i<[levelSprites count];i++) {
            
            CCSprite * ls = [levelSprites objectAtIndex:i];
            
            if ([ls containsTouch:touch] && i != (unsigned int)[[theGrammarGame instance] currentLevel ])
            {
                //Update the suggested symbols on the sentence
                
                [self switchLevel:i];
                
                [ls setOpacity:255];
                
                ls = [levelSprites objectAtIndex:cLevel];
                
                [ls setOpacity:128];
                
                [self generateNewEquation];

            }
            
        }

    }
    
    
    CCSprite * prev = [cube2Sprites objectAtIndex:0];
    
    if ([prev containsTouch:touch]) {
        //[self nextSymbol];
        //[self updateText];
        [self generateNewEquation];
    }
    
    if ([firstWheelSprite containsTouch:touch]) {
        //Change position of wheel1
        [[[theGrammarGame instance] equation] flipUp:0];
        [self updateFirstWeel:[[theGrammarGame instance] getWheelPositionFixed:0]];
    }
    
    if ([secondWheelSprite containsTouch:touch]) {
        [[[theGrammarGame instance] equation] flipUp:1];
        [self updateSecondWeel:[[theGrammarGame instance] getWheelPositionFixed:1]];
    }
    
    if ([resultWheelSprite containsTouch:touch]) {
        [[[theGrammarGame instance] equation] flipUp:2];
        [self updateResultWeel:[[theGrammarGame instance] getWheelPositionFixed:2]];
    }
    
    int currentMathType = [[[theGrammarGame instance] equation] equationMathType];
    
    for (unsigned int i=0;i<[mathTypeTabSprites count];i++) {
        
        CCSprite * sprite = [mathTypeTabSprites objectAtIndex:i];
        
        if ([sprite containsTouch:touch] && currentMathType != (mathType)i) {
            //depending on i we have a switch to another math
            
            if ([[[theGrammarGame instance] equation] equationMathType] != (mathType)i) {
                
                [[[theGrammarGame instance] equation] setEquationMathType:i];
                
                [sprite setOpacity:255];
                
                sprite = [mathTypeTabSprites objectAtIndex:currentMathType];
                
                [sprite setOpacity:128];
                
                //we have switch operator type update with new 
                [self generateNewEquation];
                
            }
            
        }
    }

    //Ok if we touch the timer check the solution
    if ([equalsSprite containsTouch:touch]) {
        [self finishedSymbols];
    }
}

-(void) updateFirstWeel:(Boolean) fixed
{
    if (fixed) {
        for (int n=0;n<3;n++) {
            
            NSString * number = [[NSString alloc] initWithFormat:@"%d",[[[theGrammarGame instance] equation] getFirstNumber:0]];
            
            [[firstNumberLabels objectAtIndex:n] setString:number];
            [[firstNumberLabels objectAtIndex:n] setVisible:false];
            [[firstNumberLabels objectAtIndex:n] setScale:0.33];
        }
        //Make the middle visible
        [[firstNumberLabels objectAtIndex:1] setVisible:true];
        [[firstNumberLabels objectAtIndex:1] setScale:1.0];
        
        return;
    }
    for (int n=0;n<3;n++) {
        
        NSString * number = [[NSString alloc] initWithFormat:@"%d",[[[theGrammarGame instance] equation] getFirstNumber:n]];
        
        [[firstNumberLabels objectAtIndex:n] setString:number];
        [[firstNumberLabels objectAtIndex:n] setVisible:true];
        [[firstNumberLabels objectAtIndex:n] setScale:0.33];
    }
}

-(void) updateSecondWeel:(Boolean) fixed
{
    if (fixed) {
        
        for (int n=0;n<3;n++) {
            
            NSString * number = [[NSString alloc] initWithFormat:@"%d",[[[theGrammarGame instance] equation] getSecondNumber:0]];
            
            [[secondNumberLabels objectAtIndex:n] setString:number];
            [[secondNumberLabels objectAtIndex:n] setVisible:false];
            [[secondNumberLabels objectAtIndex:n] setScale:0.33];
        }
        
        [[secondNumberLabels objectAtIndex:1] setVisible:true];
        [[secondNumberLabels objectAtIndex:1] setScale:1.0];
        
        return;
    }
    
    for (int n=0;n<3;n++) {
        
        NSString * number = [[NSString alloc] initWithFormat:@"%d",[[[theGrammarGame instance] equation] getSecondNumber:n]];
        
        [[secondNumberLabels objectAtIndex:n] setString:number];
        [[secondNumberLabels objectAtIndex:n] setVisible:true];
        [[secondNumberLabels objectAtIndex:n] setScale:0.33];
    }
}

-(void) updateResultWeel:(Boolean) fixed
{
    if (fixed) {
        
        for (int n=0;n<3;n++) {
            
            NSString * number = [[NSString alloc] initWithFormat:@"%d",[[[theGrammarGame instance] equation] getResultNumber:0]];
            
            [[resultLabels objectAtIndex:n] setString:number];
            [[resultLabels objectAtIndex:n] setVisible:false];
            [[resultLabels objectAtIndex:n] setScale:0.33];
        }
        
        [[resultLabels objectAtIndex:1] setVisible:true];
        [[resultLabels objectAtIndex:1] setScale:1.0];
        
        return;
    }
    
    for (int n=0;n<3;n++) {
        
        NSString * number = [[NSString alloc] initWithFormat:@"%d",[[[theGrammarGame instance] equation] getResultNumber:n]];
        [[resultLabels objectAtIndex:n] setVisible:true];
        [[resultLabels objectAtIndex:n] setString:number];
        [[resultLabels objectAtIndex:n] setScale:0.33];
    }
}

-(void) updateSymbolWeel:(Boolean) fixed
{
    
    operatorType ot = [[[theGrammarGame instance] equation] optype];
    
    CCSprite * sprite;
    
    for (unsigned int i=0; i < [symbolSprites count];i++) {
        sprite = [symbolSprites objectAtIndex:i];
        
        [sprite setVisible:false];
    }
    
    sprite = [symbolSprites objectAtIndex:((int)ot)];
    [sprite setVisible:true];
    
}

-(void) generateNewEquation
{
    //Generates new equation
    [[theGrammarGame instance] generate];
    
    //What wheels are fxied????
    [firstWheelSprite setVisible:![[theGrammarGame instance] getWheelPositionFixed:0]];
    [secondWheelSprite setVisible:![[theGrammarGame instance] getWheelPositionFixed:1]];
    [resultWheelSprite setVisible:![[theGrammarGame instance] getWheelPositionFixed:2]];
    [symbolWheelSprite setVisible:![[theGrammarGame instance] getWheelPositionFixed:3]];
    
    [self updateFirstWeel:[[theGrammarGame instance] getWheelPositionFixed:0]];
    [self updateSecondWeel:[[theGrammarGame instance] getWheelPositionFixed:1]];
    [self updateResultWeel:[[theGrammarGame instance] getWheelPositionFixed:2]];
    [self updateSymbolWeel:[[theGrammarGame instance] getWheelPositionFixed:3]];
    
}

/*-(void) updateLevel {
    
    //Set all levels invisible
    for (int i = 0; i < 5; i++) {
        [[levelSprites objectAtIndex:i] setVisible:false];
    }
    //get the current Level from the grammar game
    //Switch the level back on
    [[levelSprites objectAtIndex:[[theGrammarGame instance] currentLevel]] setVisible:true];
    
    //generate new equation is switching level
    [self generateNewEquation];
    
}*/

-(void) onTimer {
    
    NSDate * timeSinceStart = [[NSDate alloc] init];
    
    NSTimeInterval seconds = [timeSinceStart timeIntervalSinceDate:startTime];
    
    NSString * str = [NSString stringWithFormat:@"%2.0f Sek",seconds];
    
    [gameTime setString:str];
    
    //After the sentence has been solved!
    if (waitingForNextSentence > 0) {
        
        waitingForNextSentence--;
        
        if (waitingForNextSentence==0) {
            
            //
            if ([checkMark visible]) {
                [self generateNewEquation];
            }
            
            //lets get a new equation
            [checkMark setVisible:false];
            [crossMark setVisible:false];
            
        }
    }
    
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void) onExit
{
    NSLog(@"OnExit from Layer");
    
    //Removing our self from the observers list
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //Reset the timer
    [timeUpdate invalidate];
    timeUpdate = nil;
    
    //we exit the layer
    [[theGrammarGame instance] saveStatus];
    
    isCurrent = false;
}

-(void) onEnter
{
    NSLog(@"OnEnter to Layer");

    //need to respond to the various messages from the cubes
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(cubeMessage:) 
                                                 name:@"cubeMessage" object:nil];
    
    //Need to check the level and switch to the correct level
    //[self updateText];
    //[self updateLevel];
    //[self updateCheckMark];
    //Start timer to update time
    //
    timeUpdate = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];

    startTime = [[NSDate alloc] init];
    
    //when entering generate new equation
    [self generateNewEquation];
    
    isCurrent = true;
}
//Switch to a different layer
-(void) goToLayer:(id)sender {
	
    CCMenuItemFont *item = (CCMenuItemFont*)sender;
	
    [(CCLayerMultiplex*)parent_ switchTo:item.tag];
}

@end
