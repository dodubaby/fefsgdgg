

#import "UIAlertView+Utils.h"
#import <objc/runtime.h>

@implementation UIAlertView (Utils)

const char alertDelegateKey;
const char alertClickedBlockKey;

-(void)showWithClickedBlock:(void(^)(NSInteger buttonIndex))clickedBlock{
    UIAlertView *alert = (UIAlertView *)self;
    if(clickedBlock != nil)
    {
        id theDelegate = objc_getAssociatedObject(self, &alertDelegateKey);
        if(theDelegate == nil)
        {
            objc_setAssociatedObject(self, &alertDelegateKey, theDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
        
        theDelegate = alert.delegate;
        alert.delegate = self;
        objc_setAssociatedObject(self, &alertClickedBlockKey, clickedBlock, OBJC_ASSOCIATION_COPY);
    }
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIAlertView *alert = (UIAlertView *)self;
    void (^theClickedBlock)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &alertClickedBlockKey);
    
    if(theClickedBlock == nil)
        return;
    
    theClickedBlock(buttonIndex);
    alert.delegate = objc_getAssociatedObject(self, &alertDelegateKey);
}

@end
