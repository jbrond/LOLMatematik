/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"
#import "MainLayer.h"
#import "CubeEnumurator.h"
#import "theGrammarGame.h"

@implementation AppDelegate

-(void) initializationComplete
{
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
    
    //Initialize the cube enumurator and start browsing for cubes
    [[CubeEnumurator instance] browseServices];
    
    [theGrammarGame instance];
    
    //Add multiple layers and switch from there?
    [[CCDirector sharedDirector] runWithScene: [MainLayer scene]];
}

-(id) alternateRootViewController
{
	return nil;
}

-(id) alternateView
{
	return nil;
}

@end
