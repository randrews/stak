//
//  VirtualMachine.m
//  stak
//
//  Created by Ross Andrews on 1/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "VirtualMachine.h"
#import "Opcodes.h"

@implementation VirtualMachine

@synthesize instructions, pc, stackA, stackB, stackC, stackD, input, output, input_cursor;

-(void) addInstruction: (Instruction*) instr atLine: (int) line_num {
	[(NSMutableArray*)instructions addObject: instr];

	if(instr.label){
		[(NSMutableDictionary*)labels setObject: [NSNumber numberWithInt:line_num]
										 forKey: instr.label]; 
	}
}

-(id) initWithProgram: (NSString*) program {
	self = [super init];
	if(self){
		NSArray *lines = [program componentsSeparatedByString: @"\n"];
		instructions = [[NSMutableArray arrayWithCapacity: [lines count]] retain];
		labels = [[NSMutableDictionary dictionaryWithCapacity:10] retain];

		int line_num = 0;

		for(NSString *line in lines){
			Instruction * instr = [Instruction instructionFromString: line];
			if(!instr){
				NSLog(@"Syntax error: %@", line); // TODO: actual error handling
			}else {
				[self addInstruction:instr atLine: (line_num++)];
			}
		}

		pc = -1;
		input_cursor = 0;
		stackA = [[NSMutableArray arrayWithCapacity:10] retain];
		stackB = [[NSMutableArray arrayWithCapacity:10] retain];
		stackC = [[NSMutableArray arrayWithCapacity:10] retain];
		stackD = [[NSMutableArray arrayWithCapacity:10] retain];
		output = [[NSMutableString alloc] initWithString: @""];
	}

	return self;
}

-(void) dealloc {
	[stackA release];
	[stackB release];
	[stackC release];
	[stackD release];
	if(input)[input release];
	if(output)[output release];
	
	[super dealloc];
}

// Execute one instruction, updating machine state
-(void) tick {
	pc++;
	Instruction *instr = [self fetch];
	if(instr){
		[self execute:instr];
	}
}

@end
