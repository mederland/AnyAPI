//
//  Results.m
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import "Result.h"
#import "Book.h"

@implementation Result

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super self];
    if (self) {
        self.listName = [dictionary valueForKey:@"listName"];
        self.listNameEncoded = [dictionary valueForKey:@"listNameEncoded"];
        self.bestsellersDate = [dictionary valueForKey:@"bestsellersDate"];
        self.publishedDate = [dictionary valueForKey:@"publishedDate"];
        
        NSMutableArray* books = [[NSMutableArray alloc] init];
        NSArray* jsonBooks = [dictionary objectForKey:@"books"];
        
        for (NSDictionary* bookDict in jsonBooks) {
            Book* book = [[Book alloc] initWithDictionary:bookDict];
            [books addObject:book];
        }
        self.books = [NSArray arrayWithArray:books];
    }
    return self;
}

@end
