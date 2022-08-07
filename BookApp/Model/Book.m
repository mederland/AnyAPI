//
//  Book.m
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import "Book.h"

@implementation Book


-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super self];
    if (self) {
        
        self.bookImage = [dictionary valueForKey:@"bookImage"];
        self.listName = [dictionary valueForKey:@"listName"];
        self.title = [dictionary valueForKey:@"title"];
        self.author = [dictionary valueForKey:@"author"];
        self.price = [dictionary valueForKey:@"price"];

    }

    return self;
}

@end
