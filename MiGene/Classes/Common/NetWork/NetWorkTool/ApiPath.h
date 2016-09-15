//
//  ApiPath.h
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#ifndef MiGene_ApiPath_h
#define MiGene_ApiPath_h

//================用户相关=================
#define API_USER_VERIFY @"/migene/user/register/verify" //获取验证码
#define API_USER_REGISTER @"/migene/user/register" //注册
#define API_USER_LOGIN @"/migene/user/login"   //登陆
#define API_USER_PROFILE_ME @"/migene/user/profile/me"  //获取个人信息
#define API_USER_PROFILE @"/migene/user/profile"  //获取ta人信息

#define API_USER_UPDATE_AVATAR @"/migene/user/update/avatar"  //修改头像
#define API_USER_UPDATE_SIGNATURE @"/migene/user/update/signature"  //修改签名
#define API_USER_UPDATE_NICKNAME @"/migene/user/update/nickname"  //修改昵称
#define API_USER_UPDATE_SEX @"/migene/user/update/sex"  //修改性别


//================MiGene=================
#define API_MiGene_CREATE @"/migene/create"  //发布信息
#define API_MiGene_DELETE @"/migene/delete"  //删除信息
#define API_MiGene_IGNORE @"/migene/ignore"  //屏蔽信息
#define API_MiGene_REPORT @"/migene/report"  //举报信息
#define API_MiGene_LIKE @"/migene/like"      //点赞
#define API_MiGene_LIKE_CANCEL @"/migene/like/cancel"      //取消点赞
#define API_MiGene_COMMENT_CREATE @"/migene/comment/create"      //评论
#define API_MiGene_COMMENT_LIST @"/migene/comment/list"      //获取评论
#define API_MiGene_LIST_NEARBY @"/migene/list/nearby"      //获取发布的信息列表
#define API_MiGene_LIST_POPULAR @"/migene/list/popular"      //获取发布的信息列表
#define API_MiGene_LIST_MINE @"/migene/list/mine"      //获取发布的信息列表
#define API_MiGene_DETAIL @"/migene/detail"      //获取发布的信息的详情


#endif
