//
//  Tetromino.h
//  Tetris
//
//  Created by Domingo on 2013-02-05.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tetromino : NSObject
@property NSPoint one, two, three, four, centre;
@property int shape;

- (Tetromino *)initWithShape: (int)theShape;
- (Tetromino *)initWithRandomShape;
- (void)setPosition;
- (void)setStraight;
- (void)setSquare;
- (void)setT;
- (void)setJ;
- (void)setL;
- (void)setS;
- (void)setZ;
- (void)setCentrePosition;
- (NSPoint)getRotatedPoint : (BOOL) clockWise : (int) point;
- (Tetromino *)moveDown;
- (Tetromino *)rotateRight;
- (Tetromino *)moveLeftOrRight : (int) byThisMuch;

@end
