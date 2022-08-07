//
//  PageResult.m
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import "PageResult.h"
#import "Result.h"

@implementation PageResult

-(instancetype)initWithJsonDictionary:(NSDictionary *)dictionary {
    self = [super self];
    if (self) {
        self.copyright = [[dictionary valueForKey:@"copyright"] stringValue];
        self.num_results = [[dictionary valueForKey:@"num_results"] integerValue];
        
        NSMutableArray* results = [[NSMutableArray alloc] init];
        NSArray* jsonResults = [dictionary objectForKey:@"results"];
        
        for (NSDictionary* resultDict in jsonResults) {
            Result* result = [[Result alloc] initWithDictionary:resultDict];
            [results addObject:result];
        }
        self.results = [NSArray arrayWithArray:results];
    }
    
    return self;
}

@end
