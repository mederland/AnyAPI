#import "QTKitab.h"

// Shorthand for simple blocks
#define λ(decl, expr) (^(decl) { return (expr); })

// nil → NSNull conversion for JSON dictionaries
static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Private model interfaces

@interface QTKitab (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTResults (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBook (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTBuyLink (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTIsbn (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

// These enum-like reference types are needed so that enum
// values can be contained by NSArray and NSDictionary.

@implementation QTName
+ (NSDictionary<NSString *, QTName *> *)values
{
    static NSDictionary<NSString *, QTName *> *values;
    return values = values ? values : @{
        @"Amazon": [[QTName alloc] initWithValue:@"Amazon"],
        @"Apple Books": [[QTName alloc] initWithValue:@"Apple Books"],
        @"Barnes and Noble": [[QTName alloc] initWithValue:@"Barnes and Noble"],
        @"Books-A-Million": [[QTName alloc] initWithValue:@"Books-A-Million"],
        @"Bookshop": [[QTName alloc] initWithValue:@"Bookshop"],
        @"IndieBound": [[QTName alloc] initWithValue:@"IndieBound"],
    };
}

+ (QTName *)amazon { return QTName.values[@"Amazon"]; }
+ (QTName *)appleBooks { return QTName.values[@"Apple Books"]; }
+ (QTName *)barnesAndNoble { return QTName.values[@"Barnes and Noble"]; }
+ (QTName *)booksAMillion { return QTName.values[@"Books-A-Million"]; }
+ (QTName *)bookshop { return QTName.values[@"Bookshop"]; }
+ (QTName *)indieBound { return QTName.values[@"IndieBound"]; }

+ (instancetype _Nullable)withValue:(NSString *)value
{
    return QTName.values[value];
}

- (instancetype)initWithValue:(NSString *)value
{
    if (self = [super init]) _value = value;
    return self;
}

- (NSUInteger)hash { return _value.hash; }
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

QTKitab *_Nullable QTKitabFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [QTKitab fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

QTKitab *_Nullable QTKitabFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return QTKitabFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable QTKitabToData(QTKitab *kitab, NSError **error)
{
    @try {
        id json = [kitab JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable QTKitabToJSON(QTKitab *kitab, NSStringEncoding encoding, NSError **error)
{
    NSData *data = QTKitabToData(kitab, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation QTKitab
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"status": @"status",
        @"copyright": @"copyright",
        @"num_results": @"numResults",
        @"last_modified": @"lastModified",
        @"results": @"results",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return QTKitabFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTKitabFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTKitab alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _results = [QTResults fromJSONDictionary:(id)_results];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTKitab.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTKitab.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTKitab.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in QTKitab.properties) {
        id propertyName = QTKitab.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"results": [_results JSONDictionary],
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return QTKitabToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTKitabToJSON(self, encoding, error);
}
@end

@implementation QTResults
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"list_name": @"listName",
        @"list_name_encoded": @"listNameEncoded",
        @"bestsellers_date": @"bestsellersDate",
        @"published_date": @"publishedDate",
        @"published_date_description": @"publishedDateDescription",
        @"next_published_date": @"nextPublishedDate",
        @"previous_published_date": @"previousPublishedDate",
        @"display_name": @"displayName",
        @"normal_list_ends_at": @"normalListEndsAt",
        @"updated": @"updated",
        @"books": @"books",
        @"corrections": @"corrections",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTResults alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _books = map(_books, λ(id x, [QTBook fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTResults.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTResults.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTResults.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in QTResults.properties) {
        id propertyName = QTResults.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"books": map(_books, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTBook
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"rank": @"rank",
        @"rank_last_week": @"rankLastWeek",
        @"weeks_on_list": @"weeksOnList",
        @"asterisk": @"asterisk",
        @"dagger": @"dagger",
        @"primary_isbn10": @"primaryIsbn10",
        @"primary_isbn13": @"primaryIsbn13",
        @"publisher": @"publisher",
        @"description": @"theDescription",
        @"price": @"price",
        @"title": @"title",
        @"author": @"author",
        @"contributor": @"contributor",
        @"contributor_note": @"contributorNote",
        @"book_image": @"bookImage",
        @"book_image_width": @"bookImageWidth",
        @"book_image_height": @"bookImageHeight",
        @"amazon_product_url": @"amazonProductURL",
        @"age_group": @"ageGroup",
        @"book_review_link": @"bookReviewLink",
        @"first_chapter_link": @"firstChapterLink",
        @"sunday_review_link": @"sundayReviewLink",
        @"article_chapter_link": @"articleChapterLink",
        @"isbns": @"isbns",
        @"buy_links": @"buyLinks",
        @"book_uri": @"bookURI",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTBook alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _isbns = map(_isbns, λ(id x, [QTIsbn fromJSONDictionary:x]));
        _buyLinks = map(_buyLinks, λ(id x, [QTBuyLink fromJSONDictionary:x]));
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBook.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBook.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBook.properties.allValues] mutableCopy];

    // Rewrite property names that differ in JSON
    for (id jsonName in QTBook.properties) {
        id propertyName = QTBook.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"isbns": map(_isbns, λ(id x, [x JSONDictionary])),
        @"buy_links": map(_buyLinks, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}
@end

@implementation QTBuyLink
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"name": @"name",
        @"url": @"url",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTBuyLink alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _name = [QTName withValue:(id)_name];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTBuyLink.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTBuyLink.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTBuyLink.properties.allValues] mutableCopy];

    // Map values that need translation
    [dict addEntriesFromDictionary:@{
        @"name": [_name value],
    }];

    return dict;
}
@end

@implementation QTIsbn
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"isbn10": @"isbn10",
        @"isbn13": @"isbn13",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTIsbn alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTIsbn.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (void)setNilValueForKey:(NSString *)key
{
    id resolved = QTIsbn.properties[key];
    if (resolved) [super setValue:@(0) forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTIsbn.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
