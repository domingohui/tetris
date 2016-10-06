//
//  TetrisAppDelegate.h
//  Tetris
//
//  Created by Domingo on 2013-01-30.
//  Copyright (c) 2013 Domingo. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Board;
@interface TetrisAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet Board *PlayingArea;

@end