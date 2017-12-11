//
//  AmMacroUtil.h
//  FlipeTableView
//
//  Created by bob Chris on 2017/5/26.
//  Copyright © 2017年 bob Chris. All rights reserved.
//

#ifndef AmMacroUtil_h
#define AmMacroUtil_h

/* 屏幕宽高 */
#define Macro_ScreenSize    [UIScreen mainScreen].bounds.size;
#define Macro_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Macro_ScreenWidth [UIScreen mainScreen].bounds.size.width
/* 弱引用 */
#define Macro_CreateWeakSelf(type) __weak typeof(type) weakSelf= type;

#endif /* AmMacroUtil_h */
