//
//  Instruction.m
//  stak
//
//  Created by Ross Andrews on 1/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "Instruction.h"

@implementation Instruction

@synthesize opcode;
@synthesize argument;
@synthesize label;

-(id) initWithOpcode: (NSString*) opcode_p {
	return [self initWithOpcode: opcode_p argument: NULL label: NULL];
}

-(id) initWithOpcode: (NSString*) opcode_p argument: (NSString*) argument_p {
	return [self initWithOpcode: opcode_p argument: argument_p label: NULL];
}

-(id) initWithOpcode: (NSString*) opcode_p argument: (NSString*) argument_p label: (NSString*) label_p {
	self = [super init];
	if(self){
		self.opcode = opcode_p;
		self.argument = argument_p;
		self.label = label_p;
	}
	return self;
}

+(Instruction*) instructionWithOpcode: (NSString*) opcode_p {
	return [[[Instruction alloc] initWithOpcode: opcode_p] autorelease];
}

+(Instruction*) instructionWithOpcode: (NSString*) opcode_p argument: (NSString*) argument_p {
	return [[[Instruction alloc] initWithOpcode: opcode_p argument: argument_p] autorelease];
}

+(Instruction*) instructionWithOpcode: (NSString*) opcode_p argument: (NSString*) argument_p label: (NSString*) label_p {
	return [[[Instruction alloc] initWithOpcode: opcode_p argument: argument_p label: label_p] autorelease];
}

+(Instruction*) instructionFromString:(NSString *)code {
	NSArray *tokens = NULL;
	code = [code stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	
	// Label, opcode
	if(tokens = [code matches:@"^(\\w+):\\s*(\\w+)$"]){
		return [Instruction instructionWithOpcode: [tokens objectAtIndex:2]
										 argument: NULL
											label: [tokens objectAtIndex:1]];
	}

	// Opcode, argument (Pretend args are just single words for now)
	if(tokens = [code matches:@"^(\\w+)\\s*(\\w+)$"]){
		return [Instruction instructionWithOpcode:[tokens objectAtIndex:1]
										 argument:[tokens objectAtIndex:2]];
	}

	// Label, opcode, argument
	if(tokens = [code matches:@"^(\\w+):\\s*(\\w+)\\s*(\\w+)$"]){
		return [Instruction instructionWithOpcode:[tokens objectAtIndex:2]
										 argument:[tokens objectAtIndex:3]
											label:[tokens objectAtIndex:1]];
	}

	// Opcode
	if(tokens = [code matches:@"^(\\w+)$"]){
		return [Instruction instructionWithOpcode:[tokens objectAtIndex:1]];
	}

	return NULL;
}

-(void) dealloc {
	[opcode release];
	[argument release];
	[label release];
	[super dealloc];
}

@end
