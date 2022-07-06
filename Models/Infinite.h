//
//  Infinite.h
//  Instagram
//
//  Created by Julia Navarro Goldaraz on 6/30/22.
//

#import <UIKit/UIKit.h>
#import "Infinite.h"

NS_ASSUME_NONNULL_BEGIN

@interface Infinite : UIActivityIndicatorView

@property (class,nonatomic, readonly) CGFloat defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
