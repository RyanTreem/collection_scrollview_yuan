//
//  PCH_Header.h
//  FTP图影音
//
//  Created by 袁全 on 2020/3/9.
//  Copyright © 2020 袁全. All rights reserved.
//

#ifndef PCH_Header_h
#define PCH_Header_h

#import "Yuan_HUD.h"


/**
 *  ColorValue_RGB
 *
 *  @param rgbValue 传入的16进制色值,返回颜色 实例: 0x666666
 *
 *  注意事项 : '0x'!
 */
#define ColorValue_RGB(rgbValue)                                   \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0                 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0                  \
alpha:1.0]


#define ColorR_G_B(R,G,B)                                       \
[UIColor colorWithRed:R/255.0                                   \
                green:G/255.0                                   \
                 blue:B/255.0                                   \
                alpha:1.0]



#define LeftBarButton(title)  UIButton * leftButton=[UIButton buttonWithType:UIButtonTypeCustom];leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;[leftButton setTitle:title forState:UIControlStateNormal];leftButton.titleLabel.font = [UIFont systemFontOfSize:(14)];[leftButton setFrame:CGRectMake(0, 0, (44), (44))];[leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];[leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];UIBarButtonItem * leftBarButton=[[UIBarButtonItem alloc]initWithCustomView:leftButton];self.navigationItem.leftBarButtonItem=leftBarButton;


#endif /* PCH_Header_h */
