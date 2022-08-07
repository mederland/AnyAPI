//
//  NetworkManager.h
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#define BASE_BOOK_URL @"https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?api-key=Y9mZT8QW3fANfh1SfZAiVcu1OZ7bvvyA"
#define BASE_IMAGE_URL @"https://storage.googleapis.com/du-prd/books/images/"


#import <UIKit/UIKit.h>
#import "PageResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkManager : NSObject

+(instancetype)sharedInstance;

-(void)fetchBooksWithPageNumber:(NSInteger)pageNumber completion:(void(^)(PageResult*))completion;
-(void)fetchImageWithString:(NSString*)imageString completion:(void(^)(UIImage*))completion;

@end

NS_ASSUME_NONNULL_END
