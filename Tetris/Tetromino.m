//
//  Tetromino.m
//  Tetris
//
//  Created by Domingo on 2013-02-05.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import "Tetromino.h"
#define topY 10
#define middleX 4
#define tetrominoSize 1

@implementation Tetromino
@synthesize one, two, three, four, centre, shape;

/*---------------------------------------------------------------------*
 * Shape of Tetrominos*
 * 1: Straight; Default position: flat
 * 2: Square; No rotation
 * 3: T; Default position: "T" upside down
 * 4: J; Default position: "J" 90 degree clockwise rotation
 * 5: L; Default position: "L" 90 degree anticlockwise rotation
 * 6: S; Default position: "S"
 * 7: Z; Default position: "Z" 90 degree rotation
 *---------------------------------------------------------------------*/

/* Position naming rule: from TOP to BOTTOM; from LEFT to RIGHT */

- (Tetromino *)initWithShape: (int)theShape{
    self = [super init];
    shape = theShape;
    [self setPosition];
    return self;
}

- (Tetromino *)initWithRandomShape{
    self = [super init];
    shape = arc4random()%(7) + 1;
    [self setPosition];
    return self;
}

- (void)setPosition{
    switch (shape) {
        case 1:
            [self setStraight];
            break;
            
        case 2:
            [self setSquare];
            break;
            
        case 3:
            [self setT];
            break;
            
        case 4:
            [self setJ];
            break;
            
        case 5:
            [self setL];
            break;
            
        case 6:
            [self setS];
            break;
            
        case 7:
            [self setZ];
            break;
    }
    [self setCentrePosition];
}

- (void)setStraight{
    one.x = middleX; one.y = topY;
    two.x = middleX + 1; two.y = topY;
    three.x = middleX + 2; three.y = topY;
    four.x = middleX + 3; four.y = topY;
}

- (void)setSquare{
    one.x = middleX; one.y = topY;
    two.x = middleX + 1; two.y = topY;
    three.x = middleX; three.y = topY - 1;
    four.x = middleX + 1; four.y = topY - 1;
}

- (void)setT{
    one.x = middleX + 1; one.y = topY;
    two.x = middleX; two.y = topY - 1;
    three.x = middleX + 1; three.y = topY - 1;
    four.x = middleX + 2; four.y = topY - 1;
}

- (void)setJ{
    one.x = middleX; one.y = topY;
    two.x = middleX; two.y = topY - 1;
    three.x = middleX + 1; three.y = topY - 1;
    four.x = middleX + 2; four.y = topY - 1;
}

- (void)setL{
    one.x = middleX + 2; one.y = topY;
    two.x = middleX + 2; two.y = topY - 1;
    three.x = middleX + 1; three.y = topY - 1;
    four.x = middleX; four.y = topY - 1;
}

- (void)setS{
    one.x = middleX + 1; one.y = topY;
    two.x = middleX + 2; two.y = topY;
    three.x = middleX; three.y = topY - 1;
    four.x = middleX + 1; four.y = topY - 1;
}

- (void)setZ{
    one.x = middleX + 1; one.y = topY;
    two.x = middleX + 2; two.y = topY;
    three.x = middleX + 2; three.y = topY - 1;
    four.x = middleX + 3; four.y = topY - 1;
}

- (void)setCentrePosition{
    centre.x = (one.x + four.x)/2;
    centre.y = (one.y + four.y)/2;
}

- (NSPoint)getRotatedPoint : (BOOL) clockWise : (int) point{
    NSPoint new, pointToRotate;
    switch (point) {
        case 1:
            pointToRotate = self.one;
            break;
            
        case 2:
            pointToRotate = self.two;
            break;
            
        case 3:
            pointToRotate = self.three;
            break;
            
        case 4:
            pointToRotate = self.four;
            break;
    }
    if (clockWise) {
        new.x = pointToRotate.
        y + centre.x - centre.y;
        new.y = centre.x + centre.y - pointToRotate.x - tetrominoSize;
    }
    else{
        new.x = centre.x + centre.y - pointToRotate.y - tetrominoSize;
        new.y = pointToRotate.x + centre.y - centre.x;
    }
    return new;
}

- (Tetromino *)moveDown{
    Tetromino *new = [[Tetromino alloc]initWithShape:shape];
    new.shape = shape;
    NSPoint newPt;
    newPt.x = one.x;
    newPt.y = one.y - 1;
    new.one = newPt;
    
    newPt.x = two.x;
    newPt.y = two.y - 1;
    new.two = newPt;
    
    newPt.x = three.x;
    newPt.y = three.y - 1;
    new.three = newPt;
    
    newPt.x = four.x;
    newPt.y = four.y - 1;
    new.four = newPt;
    
    [new setCentrePosition];
    return new;
}

- (Tetromino *)rotateRight{
    /*
     Clockwise:
     x2 = (y1 + px - py)
     
     y2 = (px + py - x1 - q)
     
     Anti-clcokwise:
     x2 = (px + py - y1 - q)
     
     y2 = (x1 + py - px)
     
     q: the side of each tetromino --> 1
     
     (px, py): a point that the tetromino is to rotate about --> the centre of each tetromino
     */
    
    if (shape != 2) {
        //square doesn't need to be rotated
        Tetromino *rotated = [[Tetromino alloc]init];
        rotated.shape = shape;
        rotated.one = [self getRotatedPoint:YES :1];
        rotated.two = [self getRotatedPoint:YES :2];
        rotated.three = [self getRotatedPoint:YES :3];
        rotated.four = [self getRotatedPoint:YES :4];
        [rotated setCentrePosition];
        return rotated;
    }
    else
        return self;
}

- (Tetromino *)moveLeftOrRight : (int) byThisMuch{
    //byThisMuch: positive is right
    Tetromino *new = [[Tetromino alloc]init];
    new.shape = shape;
    NSPoint newPt;
    newPt.x = one.x + byThisMuch;
    newPt.y = one.y;
    new.one = newPt;
    
    newPt.x = two.x + byThisMuch;
    newPt.y = two.y;
    new.two = newPt;
    
    newPt.x = three.x + byThisMuch;
    newPt.y = three.y;
    new.three = newPt;
    
    newPt.x = four.x + byThisMuch;
    newPt.y = four.y;
    new.four = newPt;
    
    [new setCentrePosition];
    return new;
}

@end
