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
