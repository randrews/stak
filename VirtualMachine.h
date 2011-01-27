//
//  VirtualMachine.h
//  stak
//
//  Created by Ross Andrews on 1/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Instruction.h"

@interface VirtualMachine : NSObject {
	// This is an NSArray of instructions, parsed
	NSArray *instructions;
	// Map from label name to line (index into program)
	NSDictionary *labels;

	// The program counter
	int pc;
	// The stacks
	NSMutableArray *stackA, *stackB, *stackC, *stackD;
	// I/O state
	NSString *input;
	NSMutableString *output;
	int input_cursor;
}

@property (readonly) int pc, input_cursor;
@property (readonly) NSMutableArray *stackA, *stackB, *stackC, *stackD;
@property (readonly) NSArray *instructions;
@property (retain) NSString *input;
@property (readonly) NSMutableString *output;

-(id) initWithProgram: (NSString*) program;

// Execute one instruction, updating machine state
-(void) tick;

@end
