//
//  MCPullMenuHeader.h
//  TLYL
//
//  Created by MC on 2017/10/10.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#ifndef MCPullMenuHeader_h
#define MCPullMenuHeader_h


typedef NS_ENUM(NSInteger, FinishOrEditType){
    FinishType=0,      //完成状态
    EditType           //编辑状态
};


typedef NS_ENUM(NSInteger, MCPullMenuCellType){
    WithoutSelectedType=0,          //没有被选择的状态  灰色黑子
    HadSelectedType,                //已经选择过状态 灰色白字
    UsingSelectedType               //正在使用的状态  黄色底 白字
};


#endif /* MCPullMenuHeader_h */
