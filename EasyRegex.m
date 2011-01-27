//
//  EasyRegex.m
//  stak
//
//  Created by Ross Andrews on 1/22/11.
//  Copyright 2011 Home. All rights reserved.
//

#import "EasyRegex.h"


@implementation NSString(EasyRegex)

-(NSArray*) matches: (NSString*) pattern {
	RKRegex *regex = [RKRegex regexWithRegexString: pattern options: 0];
	NSRange *ranges = [self rangesOfRegex: regex];

	if(ranges){
		NSMutableArray *matches = [NSMutableArray arrayWithCapacity:[regex captureCount]];
		for(int n =	0; n < [regex captureCount]; n++){
			[matches addObject: [self substringWithRange:ranges[n]]];
		}
		return matches;
	} else {
		return NULL;
	}
}

@end
