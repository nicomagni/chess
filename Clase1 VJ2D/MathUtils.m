//
//  MathUtils.m
//  Clase1 VJ2D
//
//  Created by Nico Magni on 4/6/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import "MathUtils.h"

@implementation MathUtils : NSObject

- (id)initWithColumngCount:(int)columnCount andRowCount:(int)rowCount
{
    self = [super init];
    self.collumnCount = columnCount;
    self.rowCount = rowCount;
    return self;
}

- (int)getColumnIndexForPosition:(int)position
{
    int rowIndex = position / self.collumnCount;
//    NSLog(@"%d",rowIndex);
    return position - (rowIndex * self.rowCount);
}

- (int)getRowIndexForPosition:(int)position
{
    return position / self.collumnCount;
}

@end
