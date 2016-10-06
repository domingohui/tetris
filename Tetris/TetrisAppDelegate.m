//
//  TetrisAppDelegate.m
//  Tetris
//
//  Created by Domingo on 2013-01-30.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import "TetrisAppDelegate.h"
#import "Board.h"

@implementation TetrisAppDelegate
@synthesize PlayingArea;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    //PlayingArea = [[Tetromino alloc]initWithFrame:[PlayingArea bounds]];
    [PlayingArea gameStart];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return YES;
}

@end
