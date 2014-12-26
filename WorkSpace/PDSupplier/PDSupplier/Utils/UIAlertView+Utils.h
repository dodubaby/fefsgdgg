

#import <UIKit/UIKit.h>

@interface UIAlertView (Utils)<UIAlertViewDelegate>

-(void)showWithClickedBlock:(void(^)(NSInteger buttonIndex))clickedBlock;

@end
