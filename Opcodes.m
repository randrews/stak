//
//  Opcodes.m
//  stak
//
//  Created by Ross Andrews on 1/23/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "Opcodes.h"


@implementation VirtualMachine(Opcodes)

-(Instruction*) fetch {
	if([self pc] < [[self instructions] count]){
		return [[self instructions] objectAtIndex: [self pc]];
	} else {
		return NULL;
	}
}

-(SEL) decode: (Instruction*) instr {
	if([@"push" isEqualToString:instr.opcode]){
		return @selector(push:);
	} else if([@"jump" isEqualToString: instr.opcode]){
		return @selector(jump:);
	} else if([@"concat" isEqualToString: instr.opcode]){
		return @selector(concat:);
	} else if([@"add" isEqualToString: instr.opcode]){
		return @selector(add:);
	}
	return NULL;
}

-(void) execute: (Instruction*) instr {
	SEL sel = [self decode:instr];
	if(sel){
		[self performSelector: sel withObject: instr.argument];
	}
}

///////////////////////////////////////////////////////////////

-(void) push: (NSString*) argument {
	[[self stackA] insertObject: argument atIndex: 0];
}

-(void) add: (NSString*) argument {}

-(void) concat: (NSString*) argument {}

-(void) jump: (NSString*) argument {
	NSLog(@"jumping to %@", argument);
}

@end
