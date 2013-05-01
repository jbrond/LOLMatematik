//
//  Equation.h
//  MoveNLearn Matematik
//
//  Created by Jan Christian Brønd on 9/17/12.
//
//

#import <Foundation/Foundation.h>

typedef enum { addition, subtraction, multiplication, division } operatorType;
typedef enum { additionMath, subtractionMath, multiplicationMath, divisionMath, starMath } mathType;

@interface Equation : NSObject {
    
    int firstNumber[3]; //the numbers of the wheel
    int correctFirstNumber;
    int secondNumber[3];
    int correctSecondNumber;
    int result[3];
    Boolean fixedPositions[4];
    
    //this is for the position of the wheel
    int selectionPosition[4];
    
    int correctResult;
    int player1assignment;
    int player2assignment;
    operatorType optype;
    
    mathType equationMathType;
    
    Boolean solved;
    Boolean suggestionResult;
}


-(id) init;
-(void) shuffle:(int)level Mathtype:(int)type;
-(Boolean) checkSuggestion;
-(int) getFirstNumber:(int)pos;
-(int) getSecondNumber:(int)pos;
-(int) getResultNumber:(int)pos;
-(Boolean) getPositionFixed:(int)pos;
-(int) getPlayerAssignment:(int)player;
-(void) flipUp:(int)wheel;
-(void) flipDown:(int)wheel;
-(void) flipUpUser:(int)user;
-(void) flipDownUser:(int)user;


@property (nonatomic) Boolean solved;
@property (nonatomic) Boolean suggestionResult;
@property (nonatomic) mathType equationMathType;
@property (nonatomic) operatorType optype;

@end
