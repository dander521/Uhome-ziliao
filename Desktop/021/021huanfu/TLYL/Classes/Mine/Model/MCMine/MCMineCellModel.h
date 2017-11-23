//
//  MCMineCellModel.h
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMineCellModel : NSObject

@end
@interface CellModel : NSObject

@property(nonatomic,retain) NSString *title;

@property(nonatomic,retain) NSString *subTitle;

@property(nonatomic,retain) NSString *image;

@property(nonatomic,retain) NSString *selectorString;

@property(nonatomic,assign) BOOL isNewsImgV;

@property(nonatomic,assign) BOOL isShowBottomLine;

@property(nonatomic,assign) UITableViewCellAccessoryType accessoryType;

@property(nonatomic,assign) UITableViewCellStyle style;

@property(nonatomic,assign) UITableViewCellSelectionStyle selectionStyle;

@property(nonatomic,strong) NSString *className;

@property(nonatomic,strong) NSString *reuseIdentifier;

@property(nonatomic,assign) CGFloat height;

@property(nonatomic,weak) id delegate;

@property(nonatomic,strong) id userInfo;

///CollectionView模式下的size
@property(nonatomic,assign) CGSize size;

+(instancetype)cellModelWithTitle:(NSString*)title sel:(NSString*)selectorString;
+(instancetype)cellModelWithTitle:(NSString*)title subTitle:(NSString*)subTitle image:(NSString*)image sel:(NSString*)selectorString;

@end

@interface SectionModel : NSObject

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSArray<CellModel*> *cells;

@property(nonatomic,strong) NSMutableArray *mutableCells;

@property(nonatomic,strong) NSString *className;

@property(nonatomic,assign) CGFloat headerhHeight;

@property(nonatomic,assign) CGFloat footerHeight;

@property(nonatomic,strong) NSString *reuseIdentifier;

@property(nonatomic,weak) id delegate;

@property(nonatomic,strong) id userInfo;

@property(nonatomic,assign) BOOL isExpand;

+(instancetype)sectionModelWithTitle:(NSString*)title cells:(NSArray<CellModel*>*)cells;

@end

@interface CollectionModel : NSObject

@property (nonatomic,assign)CGSize header_size;

@property (nonatomic,assign)CGSize item_size;

@property (nonatomic,assign)UIColor *section_color;

@property (nonatomic,strong)id  cell;

@property (nonatomic,assign)BOOL isHaveHeader;

@property (nonatomic,strong)NSString * id_dentifier;

@property (nonatomic,assign)UIEdgeInsets  section_Edge;

@property (nonatomic,assign)CGFloat interitemSpacing;

@property (nonatomic,assign)CGFloat lineSpacing;

@property(nonatomic,strong)NSString *className;

@property(nonatomic,strong) id userInfo;

@end



































