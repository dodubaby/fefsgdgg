//
//  CalendarViewController.m
//  AnQuanRiXun
//


#import "CalendarViewController.h"

static UIPopoverController* _calendarViewController=nil;

@implementation CalendarViewController

+(UIPopoverController*)shareCalendarViewPopoverController
{
    if(!_calendarViewController){
        UIViewController* viewController=[[UIViewController alloc] init];
        viewController.view=[[[VRGCalendarView alloc] init] autorelease];
        _calendarViewController=[[UIPopoverController alloc] initWithContentViewController:viewController];
        _calendarViewController.popoverContentSize=CGSizeMake(323, 291);
        [viewController release];
        

    }
    return _calendarViewController;
   
    
    
}

+(void)destoryShareCalendar{

    [_calendarViewController release];
    _calendarViewController = nil;
}
@end
