//
//  Results.h
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Result : NSObject

@property (nonatomic, assign) NSString* listName;
@property (nonatomic, assign) NSString* listNameEncoded;
@property (nonatomic, assign) NSString* bestsellersDate;
@property (nonatomic, assign) NSString* publishedDate;
@property (nonatomic, strong) NSArray* books;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
