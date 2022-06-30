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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

NS_ASSUME_NONNULL_END
