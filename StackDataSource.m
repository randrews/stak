//
//  StackDataSource.m
//  stak
//
//  Created by Ross Andrews on 1/23/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "StackDataSource.h"


@implementation MachineWindowController(StackDataSource)

//-(id) initWithArray: (NSArray*) array {
//	self = [super init];
//	if(self){
//		stack = [array retain];
//	}
//	return self;
//}
//
//-(void) dealloc {
//	if(stack)[stack release];
//	[super dealloc];
//}

-(NSArray*) arrayForTableView: (NSTableView*) tableView {
	if(tableView == [self stackA]){
		return [[self vm] stackA];
	} else if(tableView == [self stackB]){
		return [[self vm] stackB];
	} else if(tableView == [self stackC]){
		return [[self vm] stackC];
	} else if(tableView == [self stackD]){
		return [[self vm] stackD];
	} else {
		return NULL;
	}

}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	NSArray *arr = [self arrayForTableView:tableView];
	return (arr ? [arr count] : 0);
}

-(id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
	NSArray *arr = [self arrayForTableView:tableView];
	return [arr objectAtIndex: rowIndex];
}

@end
