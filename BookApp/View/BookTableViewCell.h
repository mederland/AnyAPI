//
//  BookTableViewCell.h
//  BookApp
//
//  Created by Consultant on 8/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookTableViewCell : UITableViewCell

@property (nonatomic, weak) UIImageView* posterView;
@property (nonatomic, weak) UILabel* titleLabel;

@end

NS_ASSUME_NONNULL_END
