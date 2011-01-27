//
//  Opcodes.h
//  stak
//
//  Created by Ross Andrews on 1/23/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "VirtualMachine.h"

@interface VirtualMachine(Opcodes)

-(Instruction*) fetch;
-(SEL) decode: (Instruction*) instr;
-(void) execute: (Instruction*) instr;

@end
