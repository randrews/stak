//
//  MachineWindowController.h
//  stak
//
//  Created by Ross Andrews on 1/21/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VirtualMachine.h"

@interface MachineWindowController : NSWindowController {
	NSTextView *program, *input;
	NSTextField *output;
	NSButton *run_button, *step_button;
	NSTableView *stackA, *stackB, *stackC, *stackD;
	/////
	
	// We set the selected text attrs for program when running,
	// and store the originals here.
	NSDictionary *editableAttributes;
	BOOL run_mode;
	// An array of NSRanges for the ranges to highlight for each line of code
	NSArray *ranges;
	
	/////

	// If run_mode is true, this is the vm we're running
	VirtualMachine *vm;
}

@property (assign) IBOutlet NSTextView *program, *input;
@property (assign) IBOutlet NSTextField *output;
@property (assign) IBOutlet NSButton *run_button, *step_button;
@property (assign) IBOutlet NSTableView *stackA, *stackB, *stackC, *stackD;
@property (readonly) VirtualMachine *vm;

-(void) run: (id) sender;
-(void) step: (id) sender;
-(void) reset: (id) sender;

// Set the GUI to run mode
-(void) setRunMode: (BOOL) running;

// Read the program and populate line_ranges
-(void) tokenizeProgram;

// Highlight a line in the program; does nothing unless we're running
-(void) highlightLine: (int) line;

@end
