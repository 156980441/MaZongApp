//
//  stdafx_MaZongApp.h
//  MaZongApp
//
//  Created by fanyunlong on 2016/11/2.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#ifndef stdafx_MaZongApp_h
#define stdafx_MaZongApp_h

#import <Foundation/Foundation.h>

// 摄像头
static NSString* const STR_CAMERA = @"camera";

// 请求成功字符串
static NSString* const SUCCESS = @"success";
static NSString* const STR_USERNAME = @"username";
static NSString* const STR_PASSWORD = @"password";
static NSString* const STR_ID = @"id";
static NSString* const STR_VOTE_ID = @"vote_id";
static NSString* const STR_BEGIN = @"begin";
static NSString* const STR_END = @"end";

//区分三种item类型
static int const ITEM_MISSION = 0;
static int const ITEM_MISSION_SEARCH = 1;
static int const ITEM_MISSION_LOAD_MORE = 2;

//给searchView设置的一个Tag，避免与任务id冲突
static int const MISSION_SEARCH_VIEW_TAG = -50;

static int const LOAD_MORE_CAN = 10;
static int const LOAD_MORE_DONE = 20;
static int const LOAD_MORE_ERROR = 30;

//fragment标识
static int const NOT_HANDLE_FRAGMENT_TAG = 0;//我的任务 - 未办理
static int const HANDLING_FRAGMENT_TAG = 1;//我的任务 - 办理中
static int const COMPLETE_FRAGMENT_TAG = 2;//我的任务 - 已完成
static int const REPLY_FRAGMENT_TAG = 3;//我的任务 - 任务回复

static int const POST_NEW_PROGRESS_FRAGMENT_TAG = 4;//我的发布 - 新进展
static int const POST_HANDLING_FRAGMENT_TAG = 5;//我的发布 - 进行中
static int const POST_COMPLETE_FRAGMENT_TAG = 6;//我的发布 - 已完成

//功能界面
static int const DINING_FUNCTION_TAG = 100;
static int const CAR_FUNCTION_TAG = 200;
static int const OFFICE_FUNCTION_TAG = 300;
static int const MONITOR_FUNCTION_TAG = 400;

//任务详情状态标识
static int const ONLINE = 1;
static int const OFFLINE = 0;
static int const DELETED = 1;
static int const UNDELETE = 0;
static int const REQUEST_FILE = 1;//我的发布 - 发布任务
static int const REQUEST_PICTURE = 2;
static int const NO_REPLY = 0;
static int const HAS_REPLY = 1;

//登录状态标签
static int const LOGIN_NO_NETWORK_TAG = 1;
static int const LOGIN_ERROR_TAG = 2;
static int const LOGIN_NO_LOGINED_TAG = 3;


static int const ID_TYPE_COMMENTID = 0;
static int const ID_TYPE_MISSIONID = 1;


/**
 * 菜式获取相关字段
 */
static NSString* const STR_BEGIN_DATE = @"beginDateString";
static NSString* const STR_END_DATE = @"endDateString";

/**
 * 菜品评论相关
 */
static NSString* const STR_DISH_ID = @"dishId";
static NSString* const STR_DATESTRING = @"dateString";
static NSString* const STR_PAGENUMBER = @"pageNumber";
static NSString* const STR_PAGESIZE = @"pageSize";
static NSString* const STR_CONTENT = @"content";
static NSString* const STR_SCORE = @"score";
static NSString* const STR_RESULT = @"result";
static NSString* const STR_REASON = @"reason";
static NSString* const STR_MENU_ID = @"menuId";


/**
 * 服务器IP地址
 */
static NSString* const BACK_IP = @"http://localhost:8000/interface/";
//    private static final String BACK_IP = @"192.168.199.247:8080";
static NSString* PREFIX = @"http://120.24.234.67";
//图片host前缀
static NSString* HOST = @"http://120.24.234.67/DongGuan";

static int const OPEN_OVERPENDINGTRANSITION = 10;
static int const OUT_OVERPENDINGTRANSITION = 20;

///////////////////////////////////////// 龙鱼 /////////////////////////////////////////

/** 常量数 */
static CGFloat const YLMargin = 10;

/** 导航栏高度 */
static CGFloat const YLNaviH = 44;

/** 底部tab高度 */
static CGFloat const YLBottomTabH = 44;

/** 顶部Nav高度+指示器 */
static CGFloat const YLTopNavH = 64;

// macro

#define LOC_TEST

/**
 *  屏幕宽高
 */
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

/**
 *  tableView
 */
#define iCodeTableviewBgColor [UIColor colorWithHexString:@"#E2EAF2"]                  //tableview背景颜色
#define iCodeTableViewSectionMargin 25

/**
 *  导航条
 */
#define iCodeNavigationBarColor [UIColor colorWithHexString:@"#47B879"]                  //导航条颜色

/**
 *  tableView
 */
#define iCodeTableviewBgColor [UIColor colorWithHexString:@"#E2EAF2"]                  //tableview背景颜色
#define iCodeTableViewSectionMargin 25                                                 //section间距

/**
 *  头像cell高度
 */
#define iconRowHeight 74

/**
 *  普通cell高度
 */
#define nomalRowHeight 44

/**
 *  Code圈
 */
#define circleCellMargin 15  //间距
#define circleCelliconWH 40  //头像高度、宽度
#define circleCellWidth [UIScreen mainScreen].bounds.size.width - 2 * circleCellMargin  //cell的宽度
#define circleCellNameattributes @{NSFontAttributeName : [UIFont systemFontOfSize:16]}  //昵称att
#define circleCellNameFont [UIFont systemFontOfSize:16]                                 //昵称字号
#define circleCellTimeattributes @{NSFontAttributeName : [UIFont systemFontOfSize:13]}  //时间att
#define circleCellTimeFont [UIFont systemFontOfSize:13]                                 //时间字号
#define circleCellTextattributes @{NSFontAttributeName : [UIFont systemFontOfSize:17]}  //正文att
#define circleCellTextFont [UIFont systemFontOfSize:17]                                 //正文字号
#define circleCellPhotosWH (circleCellWidth - 2 * (circleCellMargin + circleCellPhotosMargin)) / 3                                                                                   //图片的宽高
#define circleCellPhotosMargin 5                                                        //图片间距
#define circleCellToolBarHeight 35                                                      //cell工具条高度
#define circleCellToolBarTintColor [UIColor colorWithHexString:@"#ffffff"]              //工具条图标、字体颜色
#define circleCellToolBarTittleFont [UIFont systemFontOfSize:14]                        //工具条btn字号

static NSString* URL_ROOT = @"http://139.224.223.73:8099";
static NSString* URL_USER_LOGIN = @"http://139.224.223.73:8099/interface/login";
static NSString* URL_USER_REGISTER = @"http://139.224.223.73:8099/interface/addUserInfo";
static NSString* URL_ADD_DEVICE = @"http://139.224.223.73:8099/interface/addMachineInfo";
static NSString* URL_CITY_ADS = @"http://139.224.223.73:8099/interface/getAdvertiseListByCity";
static NSString* URL_DEVICE_LIST = @"http://139.224.223.73:8099/interface/getMachineList";
static NSString* URL_DEVICE_INFO = @"http://139.224.223.73:8099/:8000/interface/getMachineInfo?";
static NSString* URL_DELETE_DEVICE = @"http://139.224.223.73:8099/interface/deleteMachineInfo";///USER_NO/MACHINE_ID Get
static NSString* URL_CHANGE_DEVICE_STATE = @"http://139.224.223.73:8099/interface/setRelaySwitch";///{MACHINE_ID}/{status}
static NSString* URL_CHANGE_DEVICE_NAME = @"http://139.224.223.73:8099/interface/setMechineName";//{MACHINE_ID}/{MACHINE_NAME} get

#endif /* stdafx_MaZongApp_h */
