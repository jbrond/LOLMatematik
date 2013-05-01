//
//  Equation.m
//  MoveNLearn Matematik
//
//  Created by Jan Christian Brønd on 9/17/12.
//
//

#import "Equation.h"

@implementation Equation

@synthesize solved;

@synthesize suggestionResult;
@synthesize equationMathType;
@synthesize optype;

#define RANDOM_INT(__MIN__, __MAX__) ((__MIN__) + random() % ((__MAX__+1) - (__MIN__)))
#define RANDOM_SEED() srandom(time(NULL))

-(id) init {
    if ((self = [super init]))
    {
        solved = false;
    }
    
    return self;
}



-(void) flipUpUser:(int) user
{
    int pa = player1assignment;
    
    if (user == 2)
        pa = player2assignment;
    
    if (pa<0 || pa>2)
        return;
    
    //if the wheel is fixed no need to change the position
    if (fixedPositions[pa])
        return;
    
    selectionPosition[pa]++;
    
    if (selectionPosition[pa]>2) {
        selectionPosition[pa] = 0;
    }
}

-(void) flipDownUser:(int) user
{
    int pa = player1assignment;
    
    if (user == 2) {
        pa = player2assignment;
    }
    
    if (pa<0 || pa>2)
        return;
    
    if (fixedPositions[pa])
        return;
    
    selectionPosition[pa]--;
    
    if (selectionPosition[pa]<0) {
        selectionPosition[pa] = 2;
    }
}

-(void) flipUp:(int)wheel
{
    if (wheel<0 || wheel>2)
        return;
    
    //if the wheel is fixed no need to change the position
    if (fixedPositions[wheel])
        return;
    
    selectionPosition[wheel]++;
    
    if (selectionPosition[wheel]>2) {
        selectionPosition[wheel] = 0;
    }
    
}
-(void) flipDown:(int)wheel
{
    if (wheel<0 || wheel>2)
        return;
    
    if (fixedPositions[wheel])
        return;

    selectionPosition[wheel]--;
    
    if (selectionPosition[wheel]<0) {
        selectionPosition[wheel] = 2;
    }
}

-(int) getFirstNumber:(int)pos;
{
    if (pos<0 || pos>2)
        return 0;
    
    int selectedPos = pos + selectionPosition[0];
    
    if (selectedPos==3) selectedPos = 0;
    if (selectedPos==4) selectedPos = 1;
    
    return firstNumber[selectedPos];
}
-(int) getSecondNumber:(int)pos;
{
    if (pos<0 || pos>2)
        return 0;

    int selectedPos = pos + selectionPosition[1];
    
    if (selectedPos==3) selectedPos = 0;
    if (selectedPos==4) selectedPos = 1;

    
    return secondNumber[selectedPos];
}
-(int) getResultNumber:(int)pos
{
    if (pos<0 || pos>2)
        return 0;

    int selectedPos = pos + selectionPosition[2];
    
    if (selectedPos==3) selectedPos = 0;
    if (selectedPos==4) selectedPos = 1;

    
    return result[selectedPos];
}

-(Boolean) checkEquations:(int)level MathType:(mathType)type
{
    int firstLevel = level;
    int secondLevel = level;
    int resultLevel = level;
    
    if (fixedPositions[0]) {
        firstLevel = 1;
    }
    if (fixedPositions[1]) {
        secondLevel = 1;
    }
    if (fixedPositions[2]) {
        resultLevel = 1;
    }

    for (int n=0;n<firstLevel;n++) {
        for (int s=0;s<secondLevel;s++) {
            for (int r=0;r<resultLevel;r++) {
                
                Boolean correct = false;
                
                switch (type) {
                    case additionMath: correct = ((firstNumber[n] + secondNumber[s]) == result[r]);
                        break;
                    case subtractionMath: correct = ((firstNumber[n] - secondNumber[s]) == result[r]);
                        break;
                    case multiplicationMath: correct = ((firstNumber[n] * secondNumber[s]) == result[r]);
                        break;
                    case divisionMath: correct = ((firstNumber[n] / secondNumber[s]) == result[r]);
                        break;
                }
                
                //if this is the first onw 0 0 0 then its ok that its correct it has to be
                
                if (correct) {
                    if (! (n==0 && s==0 && r==0)) {
                        //Ok this is not the first equation
                        return true;
                    }
                }
            }
        }
    }
    
    return false;
}

-(int) randomFirstNumber:(int)pos numberSize:(int)numberSize
{
    int rndnum = 0;
    
    Boolean isTheSame = true;
    
    do {
        
        isTheSame = false;
        rndnum = RANDOM_INT(1, numberSize);

        for (int i=0;i<pos;i++) {
            if (firstNumber[i]==rndnum) {
                isTheSame = true;
            }
        }
        
        
    } while (isTheSame);
    
    return rndnum;
    
}

-(int) randomSecondNumber:(int)pos numberSize:(int)numberSize
{
    int rndnum = 0;
    
    Boolean isTheSame = true;
    
    do {
        
        isTheSame = false;
        rndnum = RANDOM_INT(1, numberSize);
        
        for (int i=0;i<pos;i++) {
            if (secondNumber[i]==rndnum) {
                isTheSame = true;
            }
        }
        
        
    } while (isTheSame);
    
    return rndnum;
}
-(int) randomResult:(int)pos numberSize:(int)numberSize
{
    int rndnum = 0;
    
    Boolean isTheSame = true;
    
    do {
        
        isTheSame = false;
        rndnum = RANDOM_INT(1, numberSize);
        
        for (int i=0;i<pos;i++) {
            if (result[i]==rndnum) {
                isTheSame = true;
            }
        }
        
        
    } while (isTheSame);
    
    return rndnum;
    
}

-(void) shuffle:(int)level Mathtype:(int)type {
    
    RANDOM_SEED();
    solved = false;
    
    //number size
    int numberSize = pow(10.0, (double)(level+1)) - 1;
    
    //Problems with number size at level 1
    //Not enough alternatives
    //15 gives quite a number of alternatives
    if (level==0) {
        numberSize = 15;
    }
    
    mathType equationMathType = type;
    
    int assignments = 2;
    
    //if we have the star type we shuffle the math type
    if (type == starMath) {
        equationMathType = (mathType)(RANDOM_INT(0, 3));
        
        assignments++;
    }
    
    optype = equationMathType;
    
    //all positions are fixed
    for (int i=0;i<4;i++) {
        fixedPositions[i] = true;
    }
    //Lets find the assignemt for the first player
    player1assignment = RANDOM_INT(0, assignments);
    fixedPositions[player1assignment] = false;
    selectionPosition[player1assignment] = RANDOM_INT(0, 2);
    
    //The second player needs to have a different assignemt
    //than palyer1
    do {
        player2assignment = RANDOM_INT(0, assignments);
    } while (player2assignment == player1assignment);
    
    fixedPositions[player2assignment] = false;
    //The current mid position
    selectionPosition[player1assignment] = RANDOM_INT(0, 2);
    
    firstNumber[0] = RANDOM_INT(1, numberSize);
    
    secondNumber[0] = RANDOM_INT(1, numberSize);
    
    result[0] = 0;
    //lets find the result
    switch (equationMathType) {
        case additionMath: result[0] = firstNumber[0] + secondNumber[0];
            break;
        case subtractionMath: result[0] = firstNumber[0] - secondNumber[0];
            break;
        case multiplicationMath: result[0] = firstNumber[0] * secondNumber[0];
            break;
        case divisionMath:  result[0] = secondNumber[0];
            secondNumber[0] = result[0] * firstNumber[0];
            break;
    }
    //The correct equation
    NSLog(@"Equation %d %d = %d", firstNumber[0], secondNumber[0],result[0]);
    
    correctFirstNumber = firstNumber[0];
    correctSecondNumber = secondNumber[0];
    correctResult = result[0];
    
    //After the numbers has been generated
    //shuffle the correct answer around
    //Random number generation
    int n = 1;
    int i = 10;
    //lets continue until we find solution that does not fit
    do {
        
        if (!fixedPositions[0])
            firstNumber[n] = [self randomFirstNumber:n numberSize:numberSize];
        else
            firstNumber[n] = firstNumber[0];
        
        if (!fixedPositions[1])
            secondNumber[n] = [self randomSecondNumber:n numberSize:numberSize];
        else
            secondNumber[n] = secondNumber[0];
        
        if (!fixedPositions[2])
            result[n] = [self randomResult:n numberSize:numberSize];
        else
            result[n] = result[0];
        
        i--;
    } while ([self checkEquations:n MathType:equationMathType] && i>0);
        
    NSLog(@"Equation %d %d = %d", firstNumber[n], secondNumber[n],result[n]);
    
    n = 2;
    i=10;
    do {
        if (!fixedPositions[0])
            firstNumber[n] = [self randomFirstNumber:n numberSize:numberSize];
        else
            firstNumber[n] = firstNumber[0];
        
        if (!fixedPositions[1])
            secondNumber[n] = [self randomSecondNumber:n numberSize:numberSize];
        else
            secondNumber[n] = secondNumber[0];
        
        if (!fixedPositions[2])
            result[n] = [self randomResult:n numberSize:numberSize];
        else
            result[n] = result[0];
        i--;
    } while ([self checkEquations:n MathType:equationMathType] && i>0);
    
    if (i==0) {
        NSLog(@"No equation found after 10 iterations");
    }
    NSLog(@"Equation %d %d = %d", firstNumber[n], secondNumber[n],result[n]);
}

-(int) getPlayerAssignment:(int)player
{
    if (player==1)
        return player1assignment;
    
    if (player==2)
        return player2assignment;
    
    return -1;
}

-(Boolean) getPositionFixed:(int)pos
{
    if (pos<0 || pos>3)
        return true;
    
    return fixedPositions[pos];
}

-(Boolean) checkSuggestion
{
    solved = true;
    suggestionResult = false;
    int res = 0;
    
    int fpos = selectionPosition[0] + 1;
    
    if (fpos > 2 ) fpos = 0;
    
    int spos = selectionPosition[1] + 1;
    
    if (spos > 2 ) spos = 0;
    
    int rpos = selectionPosition[2] + 1;
    
    if (rpos > 2) rpos = 0;
    
    switch (optype) {
        case additionMath: res = firstNumber[fpos] + secondNumber[spos];
            break;
        case subtractionMath: res = firstNumber[fpos] - secondNumber[spos];
            break;
        case multiplicationMath: res = firstNumber[fpos] * secondNumber[spos];
            break;
        case divisionMath:  res = firstNumber[fpos] / secondNumber[spos];
            break;
    }
    
    if (res == result[rpos]) {
        suggestionResult = true;
        
        return suggestionResult;
    }
        
    
    return false;
}
@end
