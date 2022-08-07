//
//  ViewController.m
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import "ViewController.h"
#import "PageResult.h"
#import "NetworkManager.h"
#import "Result.h"
#import "BookTableViewCell.h"
#import "BookApp-Swift.h"

@interface ViewController ()

@property (nonatomic, weak) UITableView* table;
//@property (nonatomic, strong) PageResult* currentPage;
//@property (nonatomic, strong) NSMutableArray* movies;
@property (nonatomic, strong) BooksViewModel* bookVM;

@end

//@synthesize

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self.bookVM bindWithUpdateHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.table reloadData];
        });
    }];
    [self.bookVM fetchBookPage];
}

-(void)setUp {
    
    self.bookVM = [[BooksViewModel alloc] initWithNetworkManager:[NetworkManager sharedInstance]];
    
    UITableView* table = [[UITableView alloc] initWithFrame:CGRectZero];
    [table setTranslatesAutoresizingMaskIntoConstraints:NO];
    [table setDataSource:self];
    [table setPrefetchDataSource:self];
    [table registerClass:[BookTableViewCell self] forCellReuseIdentifier:@"CellId"];
    
    self.table = table;
    [self.view addSubview:table];
    
    // Constraints
    [[table.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:8] setActive:YES];
    [[table.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:8] setActive:YES];
    [[table.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-8] setActive:YES];
    [[table.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-8] setActive:YES];
    
    [table setBackgroundColor:[UIColor systemGray6Color]];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bookVM.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookTableViewCell* cell = (BookTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    
    if (cell == nil) {
        return [[UITableViewCell alloc] init];
    }
    [cell.titleLabel setText:[self.bookVM titleFor:indexPath.row]];
    
    [self.bookVM imageFor:indexPath.row completion:^(UIImage * _Nullable poster) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.posterView setImage:poster];
        });
    }];
    
    return cell;
}


- (void)tableView:(nonnull UITableView *)tableView prefetchRowsAtIndexPaths:(nonnull NSArray<NSIndexPath *> *)indexPaths {
    NSIndexPath* lastIndexPath = [NSIndexPath indexPathForRow:self.bookVM.count - 1 inSection:0];
    if ([indexPaths containsObject:lastIndexPath]) {
        [self.bookVM fetchBookPage];
    }
}


@end

