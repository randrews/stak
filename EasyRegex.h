//
//  EasyRegex.h
//  stak
//
//  Created by Ross Andrews on 1/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <RegexKit/RegexKit.h>


@interface NSString(EasyRegex)

-(NSArray*) matches: (NSString*) pattern;

@end
