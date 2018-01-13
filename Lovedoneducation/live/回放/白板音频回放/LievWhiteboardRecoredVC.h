//
//  LievWhiteboardRecoredVC.h
//  Lovedoneducation
//
//  Created by apple on 2017/11/13.
//  Copyright © 2017年 wangjungang. All rights reserved.
//
/*!
 @header LievWhiteboardRecoredVC.h
 
 @brief 白板音视频回放
 
 This is the replay vc of the class.
 when you init this vc , you should init these parameter
 @para audioPath 音/视频保存本地路径
 @para wbPath 白板文件保存的本地路径
 @para isMp4 是否是视频文件
 @para titlename title
 @author 中讯投创
 @copyright  © 2017年 wangjungang. All rights reserved.
 @version    1.0
 */
#import <UIKit/UIKit.h>


@interface LievWhiteboardRecoredVC : UIViewController
/*!  音/视频保存本地路径  */
@property (nonatomic, copy) NSString *audioPath;
/*!  白板文件保存的本地路径  */
@property (nonatomic, copy) NSString *wbPath;
/*!  是否是视频文件  */
@property (nonatomic, assign) BOOL isMP4;
/*!  title  */
@property (nonatomic, copy) NSString *titlename;

@end
