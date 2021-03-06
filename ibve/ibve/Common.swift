//
//  Common.swift
//  ibve
//
//  Created by yesway on 16/7/27.
//  Copyright © 2016年 joker. All rights reserved.
//

import Foundation

// MARK: - 全局通知定义

// MARK: - 应用程序信息
/// 应用程序 ID
let AppKey = "4171936867"
/// 应用程序加密信息(开发者可以申请修改)
let AppSecret = "8ed689dd0fb8eab5be51dcea3730f0d0"
/// 回调地址 - 登录完成调转的 URL，参数以 get 形式拼接
let RedirectURI = "http://baidu.com"


/// 用户需要登录通知
let UserShouldLoginNotification = "UserShouldLoginNotification"
/// 用户登录成功通知
let UserLoginSuccessedNotification = "UserLoginSuccessedNotification"


// 配图视图外侧的间距
let StatusPictureViewOutterMargin = CGFloat(12)
// 配图视图内部图像视图的间距
let StatusPictureViewInnerMargin = CGFloat(3)
// 视图的宽度的宽度
let StatusPictureViewWidth = UIScreen.cz_screenWidth() - 2 * StatusPictureViewOutterMargin
// 每个 Item 默认的宽度
let StatusPictureItemWidth = (StatusPictureViewWidth - 2 * StatusPictureViewInnerMargin) / 3

// MARK: - 照片浏览通知定义
/// @param selectedIndex    选中照片索引
/// @param urls             浏览照片 URL 字符串数组
/// @param parentImageViews 父视图的图像视图数组，用户展现和解除转场动画参照
/// 微博 Cell 浏览照片通知
let StatusCellBrowserPhotoNotification = "StatusCellBrowserPhotoNotification"
/// 选中索引 Key
let StatusCellBrowserPhotoSelectedIndexKey = "StatusCellBrowserPhotoSelectedIndexKey"
/// 浏览照片 URL 字符串 Key
let StatusCellBrowserPhotoURLsKey = "StatusCellBrowserPhotoURLsKey"
/// 父视图的图像视图数组 Key
let StatusCellBrowserPhotoImageViewsKey = "StatusCellBrowserPhotoImageViewsKey"

