//
//  Book.h
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property (nonatomic, copy) NSString* bookImage;
@property (nonatomic, copy) NSString* listName;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* price;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END
