//
//  StackDataSource.h
//  stak
//
//  Created by Ross Andrews on 1/23/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MachineWindowController.h"

@interface MachineWindowController(StackDataSource) <NSTableViewDataSource>

-(NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView;
-(id) tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex;

@end
