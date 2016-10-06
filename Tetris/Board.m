//
//  Tetromino.m
//  Tetris
//
//  Created by Domingo on 2013-01-31.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import "Board.h"

@implementation Board{
    int tetrominosPosition[11][11];//[x][y]
    NSTimer *timer;
}
@synthesize side, xPos, yPos, white, black, current;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        side = 30;
        xPos = 40;
        yPos = 50;
        white = [NSColor whiteColor];
        black = [NSColor blackColor];
        //current = [[Tetromino alloc]initWithRandomShape];
        current = [[Tetromino alloc]initWithShape:6];
        
        for (int x = 1; x <= 10; x++)
            for (int y = 1; y <= 10; y++)
                tetrominosPosition[x][y] = 0;//0: white=nothing, 1: black = stable, 2: black = still moving;
        //end init
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    for (int x = 1, q = yPos; x <= 10; x++, q+=35){
        for (int y = 1, p = xPos; y <= 10; y++, p+=35){
            if (tetrominosPosition[y][x] == 0)
                [white set];
            else
                [black set];
            NSRectFill(NSMakeRect(p, q, side, side));
        }
    }
}

- (BOOL)acceptsFirstResponder{
    //must be implemented to return YES to receive key press
    return YES;
}

- (void)keyDown:(NSEvent *)theEvent{    
    //get the pressed key
    switch ([theEvent keyCode]) {
        case 126:
            [self rotateRight];//rotate clockwise
            break;
        case 125:
            [self autoDown];//soft drop
            break;
        case 124:
            [self checkAndMove:0 :1];//right
            break;
        case 123:
            [self checkAndMove:0 :-1];//left
            break;
        case 49:
            [self hardDrop];
            break;
    }
}

- (void)assignValueToPositionOfCurrent : (int) value{
    tetrominosPosition[(int)current.one.x][(int)current.one.y] = value;
    tetrominosPosition[(int)current.two.x][(int)current.two.y] = value;
    tetrominosPosition[(int)current.three.x][(int)current.three.y] = value;
    tetrominosPosition[(int)current.four.x][(int)current.four.y] = value;
    [self setNeedsDisplay:YES];
}

- (BOOL)autoDown{
    if (tetrominosPosition[(int)current.one.x][(int)current.one.y - 1] != 1 &&
        tetrominosPosition[(int)current.two.x][(int)current.two.y - 1] != 1 &&
        tetrominosPosition[(int)current.three.x][(int)current.three.y - 1] != 1 &&
        tetrominosPosition[(int)current.four.x][(int)current.four.y - 1] != 1 &&
        current.one.y - 1 > 0 && current.two.y - 1 > 0 && current.three.y - 1 > 0 && current.four.y - 1 > 0)
        [self checkAndMove:-1 :0];
    else{
        [self assignValueToPositionOfCurrent:1];
        current = [[Tetromino alloc]initWithRandomShape];//new tetromino
        [self assignValueToPositionOfCurrent:2];
        return YES;
    }
}

- (void)hardDrop{
    do
        [self autoDown];
    while (![self autoDown]);
}

- (void)rotateRight{
    [self assignValueToPositionOfCurrent:0];
    current = [current rotateRight];
    [self assignValueToPositionOfCurrent:2];
    [self setNeedsDisplay:YES];
}

- (BOOL)canMoveHorizontally : (int) horizontal{
    if (horizontal == 1){
        //moving right
        if (current.one.x < 10 && current.two.x < 10 && current.three.x < 10 && current.four.x < 10)
            return YES;
        else
            return NO;
    }
    else{
        //moving left
        if (current.one.x > 1 && current.two.x > 1 && current.three.x > 1 && current.four.x > 1)
            return YES;
        else
            return NO;
    }
}

- (void)checkAndMove : (int)vertical : (int)horizontal{
    if (tetrominosPosition[(int)current.one.x + horizontal][(int)current.one.y + vertical] != 1 &&
        tetrominosPosition[(int)current.two.x + horizontal][(int)current.two.y + vertical] != 1 &&
        tetrominosPosition[(int)current.three.x + horizontal][(int)current.three.y + vertical] != 1 &&
        tetrominosPosition[(int)current.four.x + horizontal][(int)current.four.y + vertical] != 1)
    {
        [self assignValueToPositionOfCurrent:0];
        
        //get a new tetromino
        if (vertical == 0 && [self canMoveHorizontally:horizontal])
            current = [current moveLeftOrRight:horizontal];
        else if(horizontal == 0)
            current = [current moveDown];
        
        [self assignValueToPositionOfCurrent:2];
    }
    else
        [self gameOver];
}

- (void)gameStart{
    //set the initial tetromino to its starting position
    [self assignValueToPositionOfCurrent:2];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoDown) userInfo:nil repeats:YES];
}

@end
