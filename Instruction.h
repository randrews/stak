//
//  Instruction.h
//  stak
//
//  Created by Ross Andrews on 1/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EasyRegex.h"

@interface Instruction : NSObject {
	NSString *opcode, *argument, *label;
}

@property (copy) NSString *opcode;
@property (copy) NSString *argument;
@property (copy) NSString *label;

-(id) initWithOpcode: (NSString*) opcode;
-(id) initWithOpcode: (NSString*) opcode argument: (NSString*) argument;
-(id) initWithOpcode: (NSString*) opcode argument: (NSString*) argument label: (NSString*) label;

+(Instruction*) instructionWithOpcode: (NSString*) opcode_p;
+(Instruction*) instructionWithOpcode: (NSString*) opcode_p argument: (NSString*) argument_p;
+(Instruction*) instructionWithOpcode: (NSString*) opcode_p argument: (NSString*) argument_p label: (NSString*) label_p;
+(Instruction*) instructionFromString: (NSString*) code;
@end
