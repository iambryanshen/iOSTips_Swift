//
//  SFLameTool.h
//  iOSTips
//
//  Created by brian on 2018/3/28.
//  Copyright © 2018年 brian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFLameTool : NSObject


/**
 把wav、caf文件转成Mp3文件

 @param sourcePath wav/caf文件所在路径
 @param isDelete 转化完成后是否删除wav、caf文件
 @return 转化后的Mp3文件保存的路径
 */
+ (NSString *)audioToMP3: (NSString *)sourcePath isDeleteSourchFile: (BOOL)isDelete;

@end
