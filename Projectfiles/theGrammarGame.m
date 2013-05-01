//
//  theGrammarGame.m
//  MyHelloWorld
//
//  Created by Jan Brond on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "theGrammarGame.h"

@implementation theGrammarGame

@synthesize team1Cube;
@synthesize team2Cube;
@synthesize team1Name;
@synthesize team2Name;
@synthesize mode;
@synthesize currentLevel;
@synthesize currentMathType;
@synthesize equation;

- (id) initSingleton
{
    if ((self = [super init]))
    {
        
        team1Cube = @"Cube 1";
        team2Cube = @"Cube 2";
        team1Name = @"Cube 1 Navn";
        team2Name = @"Cube 2 Navn";
        equation = [[Equation alloc] init];
        
        mode = mathPractice;
        currentLevel = 0;
                
    }
    
    return self;
}

//generate the mat assignemnt based on the current mathPractice and level
-(void) generate {
    
    //based on the level and mType generate the math assignment
    [equation shuffle:currentLevel Mathtype:[equation equationMathType]];
}

//
-(Boolean) getWheelPositionFixed:(int) position
{
    return [equation getPositionFixed:position];
}
//
//Database support
//

-(NSString *) filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDir = [paths objectAtIndex:0];
    
    return [documentsDir stringByAppendingPathComponent:@"grammar.db"];
}

-(Boolean) openDB {
    NSString *dbfilepath = [self filePath];
    //NSString *dbfilepath = @"/Users/jcb/Documents/grammar.db";
    
    NSLog(@"Database Path %@",dbfilepath);
    
    const char *dbpath = [dbfilepath UTF8String];
    
    int err = sqlite3_open(dbpath, &db);
    
    if (err != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Database failed to open");
        
        return false;
    }
    
    return true;
}

-(Boolean) createTable
{
    char *err;
    
    NSString * sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS MATH_STAT (ID INTEGER PRIMARY KEY, TEAM TEXT, LEVEL INTEGER, SENTENCE INTEGER, SOLVED INTEGER)"];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Database failed to create table");
        
        return false;
    }
    
    return true;
}

-(void) closeDB
{
    sqlite3_close(db);
}


-(void) loadStatus
{
    //if both names are empty
    //no need to store the status
    if ([team1Name length] == 0 && [team2Name length] == 0)
        return;
    
    if (![self openDB])
        return;
    
    if (![self createTable])
        return;
    
    //Ok data base is ready
    
    NSString * team = [NSString stringWithFormat:@"%@_%@",team1Name,team2Name ];
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM MATH_STAT WHERE TEAM='%@'",team];
    
    sqlite3_stmt * statement;
    
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            //Column 0 is the unique ID entry
            
            char *teamn = (char*) sqlite3_column_text(statement,1);
            
            NSString * team = [NSString stringWithUTF8String:teamn];
            
            int level = (int) sqlite3_column_int(statement, 2);
            
            int sentenceNumber = (int) sqlite3_column_int(statement, 3);
            
            int solved = (int) sqlite3_column_int(statement, 4);
                        
        }
    }
    
        //Close the database
    [self closeDB];
}
//Store the status in the database
-(void) saveStatus
{
    //if both names are empty
    //no need to store the status
    if ([team1Name length] == 0 && [team2Name length] == 0)
        return;
    
    if (![self openDB])
        return;
    
    if (![self createTable])
        return;
    
    //TEAM: name1_name2
    //Level
    //Sentence NUMBER (could be ID)
    //solved or not solved
    
    char *err;
    
    NSString * team = [NSString stringWithFormat:@"%@_%@",team1Name,team2Name ];
    
    NSString * sqlDelete = [NSString stringWithFormat:@"DELETE FROM MATH_STAT WHERE TEAM='%@'",team];
    
    if (sqlite3_exec(db, [sqlDelete UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0,@"Unable delete data into table");
    }
    
        
}

+ (theGrammarGame *) instance
{
    // Persistent instance.
    static theGrammarGame *_default = nil;
    
    // Small optimization to avoid wasting time after the
    // singleton being initialized.
    if (_default != nil)
    {
        return _default;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    // Allocates once with Grand Central Dispatch (GCD) routine.
    // It's thread safe.
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void)
                  {
                      _default = [[theGrammarGame alloc] initSingleton];
                  });
#else
    // Allocates once using the old approach, it's slower.
    // It's thread safe.
    @synchronized([theGrammarGame class])
    {
        // The synchronized instruction will make sure,
        // that only one thread will access this point at a time.
        if (_default == nil)
        {
            _default = [[CubeEnumurator alloc] initSingleton];
        }
    }
#endif
    return _default;
}


@end
