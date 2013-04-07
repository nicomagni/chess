//
//  MathUtils.h
//  Clase1 VJ2D
//
//  Created by Nico Magni on 4/6/13.
//  Copyright (c) 2013 Nico Magni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathUtils : NSObject
@property (nonatomic) int collumnCount;
@property (nonatomic) int rowCount;

- (id)initWithColumngCount:(int)columnCount andRowCount:(int)rowCount;
- (int)getColumnIndexForPosition:(int)position;
- (int)getRowIndexForPosition:(int)position;
@end
