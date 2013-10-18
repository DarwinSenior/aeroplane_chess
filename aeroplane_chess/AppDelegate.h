//
//  AppDelegate.h
//  aeroplane_chess
//
//  Created by DarwinSenior on 13-10-18.
//  Copyright DarwinSenior 2013年. All rights reserved.
//

#import "cocos2d.h"

@interface aeroplane_chessAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;

- (IBAction)toggleFullScreen:(id)sender;

@end
