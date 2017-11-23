//
//  MCMineCellModel.m
//  TLYL
//
//  Created by MC on 2017/6/12.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "MCMineCellModel.h"

@implementation MCMineCellModel

@end
@implementation CellModel

-(instancetype)init {
    self = [super init];
    if(self) {
        self.reuseIdentifier = [[NSUUID UUID] UUIDString];
    }
    return self;
}

+(instancetype)cellModelWithTitle:(NSString *)title sel:(NSString *)selectorString {
    CellModel *cell = [[CellModel alloc] init];
    cell.title = title;
    cell.selectorString = selectorString;
    return cell;
}

+(instancetype)cellModelWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(NSString *)image sel:(NSString *)selectorString {
    CellModel *cell = [[CellModel alloc] init];
    cell.title = title;
    cell.subTitle = subTitle;
    cell.image = image;
    cell.selectorString = selectorString;
    return cell;
}

@end


@implementation SectionModel

-(instancetype)init {
    self = [super init];
    if(self) {
        self.reuseIdentifier = [[NSUUID UUID] UUIDString];
    }
    return self;
}

+(instancetype)sectionModelWithTitle:(NSString *)title cells:(NSArray<CellModel *> *)cells {
    SectionModel *section = [[SectionModel alloc] init];
    section.title = title;
    section.cells = cells;
    return section;
}

@end

@interface CollectionModel ()

@end
@implementation CollectionModel

@end



































