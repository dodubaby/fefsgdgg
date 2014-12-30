//
//  PDCommentCell.h
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseTableViewCell.h"


#define kCellContent @"2014-12-18 13:14:20.231 PDKitchen[14569:1104800] 拨打\
2014-12-18 13:14:21.359 PDKitchen[14569:1104800] 立即更新\
2014-12-18 13:14:31.356 PDKitchen[14569:1104800] submit\
2014-12-18 13:14:31.614 PDKitchen[14569:1104800] submit"

@interface PDCommentCell : PDBaseTableViewCell

-(void)hiddenLine:(BOOL) hide;

@end
