//
//  Tetromino.h
//  Tetris
//
//  Created by Domingo on 2013-01-31.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Tetromino.h"

@interface Board : NSView
@property int side, xPos, yPos;
@property NSColor *white, *black;
@property Tetromino *current;

- (void)keyDown:(NSEvent *)theEvent;
- (void)assignValueToPositionOfCurrent : (int) value;
- (BOOL)autoDown;
- (void)hardDrop;
- (void)rotateRight;
- (BOOL)canMoveHorizontally : (int) horizontal;
- (void)checkAndMove : (int)vertical : (int)horizontal;
- (void)gameStart;

@end
