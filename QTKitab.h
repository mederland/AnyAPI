// To parse this JSON:
//
//   NSError *error;
//   QTKitab *kitab = [QTKitab fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTKitab;
@class QTResults;
@class QTBook;
@class QTBuyLink;
@class QTName;
@class QTIsbn;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Boxed enums

@interface QTName : NSObject
@property (nonatomic, readonly, copy) NSString *value;
+ (instancetype _Nullable)withValue:(NSString *)value;
+ (QTName *)amazon;
+ (QTName *)appleBooks;
+ (QTName *)barnesAndNoble;
+ (QTName *)booksAMillion;
+ (QTName *)bookshop;
+ (QTName *)indieBound;
@end

#pragma mark - Object interfaces

@interface QTKitab : NSObject
@property (nonatomic, copy)   NSString *status;
@property (nonatomic, copy)   NSString *copyright;
@property (nonatomic, assign) NSInteger numResults;
@property (nonatomic, copy)   NSString *lastModified;
@property (nonatomic, strong) QTResults *results;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTResults : NSObject
@property (nonatomic, copy)   NSString *listName;
@property (nonatomic, copy)   NSString *listNameEncoded;
@property (nonatomic, copy)   NSString *bestsellersDate;
@property (nonatomic, copy)   NSString *publishedDate;
@property (nonatomic, copy)   NSString *publishedDateDescription;
@property (nonatomic, copy)   NSString *nextPublishedDate;
@property (nonatomic, copy)   NSString *previousPublishedDate;
@property (nonatomic, copy)   NSString *displayName;
@property (nonatomic, assign) NSInteger normalListEndsAt;
@property (nonatomic, copy)   NSString *updated;
@property (nonatomic, copy)   NSArray<QTBook *> *books;
@property (nonatomic, copy)   NSArray *corrections;
@end

@interface QTBook : NSObject
@property (nonatomic, assign) NSInteger rank;
@property (nonatomic, assign) NSInteger rankLastWeek;
@property (nonatomic, assign) NSInteger weeksOnList;
@property (nonatomic, assign) NSInteger asterisk;
@property (nonatomic, assign) NSInteger dagger;
@property (nonatomic, copy)   NSString *primaryIsbn10;
@property (nonatomic, copy)   NSString *primaryIsbn13;
@property (nonatomic, copy)   NSString *publisher;
@property (nonatomic, copy)   NSString *theDescription;
@property (nonatomic, copy)   NSString *price;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *author;
@property (nonatomic, copy)   NSString *contributor;
@property (nonatomic, copy)   NSString *contributorNote;
@property (nonatomic, copy)   NSString *bookImage;
@property (nonatomic, assign) NSInteger bookImageWidth;
@property (nonatomic, assign) NSInteger bookImageHeight;
@property (nonatomic, copy)   NSString *amazonProductURL;
@property (nonatomic, copy)   NSString *ageGroup;
@property (nonatomic, copy)   NSString *bookReviewLink;
@property (nonatomic, copy)   NSString *firstChapterLink;
@property (nonatomic, copy)   NSString *sundayReviewLink;
@property (nonatomic, copy)   NSString *articleChapterLink;
@property (nonatomic, copy)   NSArray<QTIsbn *> *isbns;
@property (nonatomic, copy)   NSArray<QTBuyLink *> *buyLinks;
@property (nonatomic, copy)   NSString *bookURI;
@end

@interface QTBuyLink : NSObject
@property (nonatomic, assign) QTName *name;
@property (nonatomic, copy)   NSString *url;
@end

@interface QTIsbn : NSObject
@property (nonatomic, copy) NSString *isbn10;
@property (nonatomic, copy) NSString *isbn13;
@end

NS_ASSUME_NONNULL_END
