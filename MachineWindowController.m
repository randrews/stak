//
//  MachineWindowController.m
//  stak
//
//  Created by Ross Andrews on 1/21/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "MachineWindowController.h"


@implementation MachineWindowController

@synthesize program, input, output, run_button, step_button;
@synthesize stackA, stackB, stackC, stackD;
@synthesize vm;

-(id) init {
	self = [super init];
	if(self){
		run_mode = false;
		editableAttributes = [[program selectedTextAttributes] retain];
	}
	
	return self;
}

-(void) dealloc {
	[editableAttributes release];
	[ranges release];
	[super dealloc];
}

-(void) run: (id) sender {
	if(!run_mode){ [self setRunMode: true]; }
	
	if([run_button state] == NSOnState){
		[run_button setTitle: @"Pause"];
		[step_button setEnabled: false];
		// Start actually running
	} else {
		// Stop running
		[run_button setTitle: @"Run"];
		[step_button setEnabled: true];
	}
}

-(void) step: (id) sender {
	if(!run_mode){ [self setRunMode:true]; }
	[vm tick];
	[self highlightLine:[vm pc]];
	[stackA reloadData];
}

-(void) reset: (id) sender {
	[self setRunMode: false];
}

//-(void) installDataSources {
//	// For some retarded-ass reason, these don't retain their datasources.
//	// We'll hang on to references for them.
//	if(stackADS)[stackADS release];
//	if(stackBDS)[stackBDS release];
//	if(stackCDS)[stackCDS release];
//	if(stackDDS)[stackDDS release];
//
//	stackADS = [[StackDataSource alloc] initWithArray: [vm stackA]];
//	[stackA setDataSource: stackADS];
//	stackBDS = [[StackDataSource alloc] initWithArray: [vm stackB]];
//	[stackB setDataSource: stackBDS];
//	stackCDS = [[StackDataSource alloc] initWithArray: [vm stackC]];
//	[stackC setDataSource: stackCDS];
//	stackDDS = [[StackDataSource alloc] initWithArray: [vm stackD]];
//	[stackD setDataSource: stackDDS];
//}

-(void) setRunMode: (BOOL) running {
	run_mode = running;
	[program setEditable: !running];
	[program setSelectable: !running];

	[input setEditable: !running];
	[input setSelectable: !running];

	if(running){
		NSDictionary *runningAttrs = [NSDictionary dictionaryWithObject:[NSColor grayColor]
																 forKey:NSBackgroundColorAttributeName];
		[program setSelectedTextAttributes: runningAttrs];
		[program setBackgroundColor:[NSColor lightGrayColor]];

		[input setSelectedTextAttributes: runningAttrs];
		[input setBackgroundColor:[NSColor lightGrayColor]];
		
		[self tokenizeProgram];
		vm = [[VirtualMachine alloc] initWithProgram: [[program textStorage] string]];
		[vm setInput: [input string]];
//		[self installDataSources];
	} else {
		[run_button setState: NSOffState];
		[run_button setTitle: @"Run"];
		[step_button setEnabled: true];
		[program setSelectedTextAttributes: editableAttributes];
		[input setSelectedTextAttributes: editableAttributes];
		[program setBackgroundColor:[NSColor whiteColor]];
		[input setBackgroundColor:[NSColor whiteColor]];
		[output setStringValue: @""];
		[vm release];
		vm = NULL;
	}

}

-(void) tokenizeProgram {
	if(ranges){[ranges release];}

	int current = 0;
	NSString *code = [[program textStorage] string];
	NSArray *lines = [code componentsSeparatedByString: @"\n"];
	ranges = [[NSMutableArray arrayWithCapacity:[lines count]] retain];
	
	for(NSString *line in lines){
		NSValue *val = [NSValue valueWithRange: NSMakeRange(current, [line length] + 1)];
		[(NSMutableArray*)ranges addObject: val];
		current += [line length] + 1;
	}
}

-(void) highlightLine: (int) line {
	if(!run_mode){return;}
	if(line < [ranges count] && line >= 0){
		[program setSelectedRange:[[ranges objectAtIndex:line] rangeValue]];
	} else {
		[program setSelectedRange: NSMakeRange(0,0)];
	}
}

@end
