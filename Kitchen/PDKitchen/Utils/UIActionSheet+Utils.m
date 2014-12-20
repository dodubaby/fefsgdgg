

#import "UIActionSheet+Utils.h"
#import <objc/runtime.h>

@implementation UIActionSheet (Utils)

const char actionSheetDelegateKey;
const char actionSheetClickedBlockKey;

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    void (^theClickedBlock)(NSInteger buttonIndex) = objc_getAssociatedObject(self, &actionSheetClickedBlockKey);
    
    if(theClickedBlock == nil)
        return;
    
    theClickedBlock(buttonIndex);
    UIActionSheet *sheet = (UIActionSheet *)self;
    sheet.delegate = objc_getAssociatedObject(self, &actionSheetDelegateKey);
}


-(void)setupClickedBlock:(void(^)(NSInteger buttonIndex))clickedBlock
{
    if(clickedBlock != nil)
    {
        
        id theDelegate = objc_getAssociatedObject(self, &actionSheetDelegateKey);
        if(theDelegate == nil)
        {
            objc_setAssociatedObject(self, &actionSheetDelegateKey, theDelegate, OBJC_ASSOCIATION_ASSIGN);
        }
        
        UIActionSheet *sheet = (UIActionSheet *)self;
        theDelegate = sheet.delegate;
        sheet.delegate = self;
        objc_setAssociatedObject(self, &actionSheetClickedBlockKey, clickedBlock, OBJC_ASSOCIATION_COPY);
    }
}
-(void)showInView:(UIView *)view
clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self setupClickedBlock:clickedBlock];
    [sheet showInView:view];
}

-(void)showFromToolbar:(UIToolbar *)view
 clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self setupClickedBlock:clickedBlock];
    [sheet showFromToolbar:view];
}

-(void)showFromTabBar:(UITabBar *)view
clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self setupClickedBlock:clickedBlock];
    [sheet showFromTabBar:view];
}

-(void)showFromRect:(CGRect)rect
             inView:(UIView *)view
           animated:(BOOL)animated
clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self setupClickedBlock:clickedBlock];
    [sheet showFromRect:rect inView:view animated:animated];
}

-(void)showFromBarButtonItem:(UIBarButtonItem *)item
                    animated:(BOOL)animated
       clickedBlock:(void (^)(NSInteger buttonIndex))clickedBlock
{
    UIActionSheet *sheet = (UIActionSheet *)self;
    [self setupClickedBlock:clickedBlock];
    [sheet showFromBarButtonItem:item animated:animated];
}


@end
