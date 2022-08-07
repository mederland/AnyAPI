//
//  PageResult.h
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageResult : NSObject
@property (nonatomic, assign) NSInteger num_results;
@property (nonatomic, assign) NSString* copyright;
@property (nonatomic, strong) NSArray* results;

-(instancetype)initWithJsonDictionary:(NSDictionary*)dictionary;

@end

NS_ASSUME_NONNULL_END


//import Foundation
//
// MARK: - Kitab
//struct Kitab {
//    let copyright: String
//    let results: Results
//}

// MARK: - Results
//struct Results {
//    let listName, listNameEncoded, bestsellersDate, publishedDate: String
//    let books: [Book]
//    let corrections: [Any?]
//}

// MARK: - Book
//struct Book {
//    let rank, rankLastWeek, weeksOnList, asterisk: Int
//    let dagger: Int
//    let price, title, author, contributor: String
//    let contributorNote: String
//    let bookImage: String
//    let bookImageWidth, bookImageHeight: Int
//    let articleChapterLink: String
//    let bookURI: String
//}
