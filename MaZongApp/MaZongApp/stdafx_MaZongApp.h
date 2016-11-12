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

/**
 * 注销登录接口
 */
static NSString* URL_LOGOUT = @"http://120.24.234.67/DongGuan/map/app_logout.do";
/**
 * 获得通讯录接口
 */
static NSString* URL_CONTACT = @"http://120.24.234.67/DongGuan/userInfo/appGetUserInfoOfAll";
/**
 * 获取个人信息接口 - GET
 */
static NSString* URL_PERSONAL_INFO = @"http://120.24.234.67/DongGuan/userInfo/appGetCurrentUserInformation";
/**
 * 信息编辑接口 - POST
 */
static NSString* URL_INFO_EDIT = @"http://120.24.234.67/DongGuan/userInfo/appModifyUserInformation";
/**
 * 密码修改接口 - POST
 */
static NSString* URL_PSW_EDIT = @"http://120.24.234.67/DongGuan/userInfo/appModifyUserPassword";
/**
 * 获取科室分类接口
 */
static NSString* URL_OFFICE_NAME = @"http://120.24.234.67/DongGuan/userInfo/appGetOffices";
/**
 * 我的任务 - 下载附件
 */
static NSString* URL_ATTACHMENT_DOWNLOAD = @"http://120.24.234.67/DongGuan/downLoadFile.do";
/**
 * 我的任务 - 未办理任务列表
 */
static NSString* URL_MISSION_NOT_HANDLE = @"http://120.24.234.67/DongGuan/appPassageDispatcher.do?method=unRead&";
/**
 * 我的任务 - 办理中任务列表
 */
static NSString* URL_MISSION_HANDLING = @"http://120.24.234.67/DongGuan/appPassageDispatcher.do?method=handled&";
/**
 * 我的任务 - 已完成任务列表
 */
static NSString* URL_MISSION_COMPLETE = @"http://120.24.234.67/DongGuan/appPassageDispatcher.do?method=finish";
/**
 * 我的任务 - 任务回复任务列表
 */
static NSString* URL_MISSION_REPLY = @"http://120.24.234.67/DongGuan/appAdminAnswer.do";
/**
 * 我的发布 - 新进展
 */
static NSString* URL_MISSION_POST_NEW_PROGRESS = @"http://120.24.234.67/DongGuan/appShowNewComment.do";
/**
 * 我的发布 - 进行中
 */
static NSString* URL_MISSION_POST_HANDLING = @"http://120.24.234.67/DongGuan/appPassageDispatcher.do?method=process&";
/**
 * 我的发布 - 已完成
 */
static NSString* URL_MISSION_POST_COMPLETE = @"http://120.24.234.67/DongGuan/appPassageDispatcher.do?method=admin-finish";

/**
 * 任务详情
 */
static NSString* URL_MISSION_DETAIL = @"http://120.24.234.67/DongGuan/appDetailPassage.do?user=user&passageId=";

/**
 * 任务详情，点击评论进入任务详情
 */
static NSString* URL_MISSION_DETAIL_COMMENT = @"http://120.24.234.67/DongGuan/appDetailPassage.do?user=user&idType=commentId&passageId=";

/**
 * 回复评论 - POST方法
 */
static NSString* URL_COMMENT_REPLY = @"http://120.24.234.67/DongGuan/appComment.do";

static NSString* URL_COMMENT_REPLY_ADMAIN = @"http://120.24.234.67/DongGuan/appAdminComment.do";
/**
 * 请求栏目url
 */
static NSString* URL_COLUMN = @"http://120.24.234.67/DongGuan/appGetMsgSendToPassage.do";
/**
 * 登陆url
 */
/**
 * 获取全部摄像头位置url
 */
static NSString* URL_ALL_LOCATION = @"http://120.24.234.67/DongGuan/map/getAllLocations";
/**
 * 判断用户进入摄像头权限url
 */
static NSString* URL_MONITOR_AUTH = @"http://120.24.234.67/DongGuan/map/monitorAppAuth";
/**
 * 用户获取预定信息url
 */
static NSString* URL_RESERVE_INFO = @"http://120.24.234.67/DongGuan/reservation?dateString=";
//    static NSString* URL_RESERVE_INFO = @"http://120.24.234.67/DongGuan/canteen_app/reserve_info";
/**
 * 预定用餐url
 */
static NSString* URL_RESERVE = @"http://120.24.234.67/DongGuan/canteen_app/reserve";
/**
 * 取消预定url
 */
static NSString* URL_CANCEL_RESERVE = @"http://120.24.234.67/DongGuan/canteen_app/remove_reserve";
/**
 * 获取用户用餐记录url
 */
static NSString* URL_CATEEN_RECORD = @"http://120.24.234.67/DongGuan/canteen_app/canteen_record";
/**
 * 获取投票信息url
 */
static NSString* URL_FOOD_VOTE = @"http://120.24.234.67/DongGuan/canteen_app/food_vote";
/**
 * 用户投票url
 */
static NSString* URL_VOTE = @"http://120.24.234.67/DongGuan/canteen_app/vote";
/**
 * 获取用户用餐记录url
 */
static NSString* URL_RECORD = @"http://120.24.234.67/DongGuan/canteen_app/canteen_record";
/**
 * 获取菜式信息
 */
static NSString* URL_GET_NOTICE = @"http://120.24.234.67/DongGuan/canteen_app/get_notice";
/**
 * 获取菜式信息
 */
static NSString* URL_GET_CUISINE = @"http://120.24.234.67/DongGuan/menu/list?";
/**
 * 获取菜品评论
 */
static NSString* URL_GET_DISH_COMMENT = @"http://120.24.234.67/DongGuan/dish/comment/getting?";
/**
 * 提交评论
 */
static NSString* URL_NEW_COMMENT = @"http://120.24.234.67/DongGuan/dish/comment/new";
/**
 * 提交预约
 */
static NSString* URL_CAR_APPOINTMENT_SUBMIT_TABLE = @"http://120.24.234.67/DongGuan/car/orderCarApp";
/**
 * 提交预约的时间段和随车人数
 */
static NSString* URL_CAR_APPOINTMENT_SUBMIT = @"http://120.24.234.67/DongGuan/car/carOrderFine";
/**
 * 取消预约
 */
static NSString* URL_CAR_APPOINTMENT_CANCLE = @"http://120.24.234.67/DongGuan/car/cancelAppointmentApp";
/**
 * 我的预约
 */
static NSString* URL_CAR_MY_APPOINTMENT = @"http://120.24.234.67/DongGuan/car/myAppointmentApp";
/**
 * 上传经纬度
 */
static NSString* URL_CAR_UPLOAD_LOCATION = @"http://120.24.234.67/DongGuan/car/submitLocation";
/**
 * 获取当前车辆的三种状态
 */
static NSString* URL_CAR_STATTE = @"http://120.24.234.67/DongGuan/car/getCarOrder2";
/**
 * 发布任务url
 */
static NSString* URL_POST_MISSION = @"http://120.24.234.67/DongGuan/appAdminSavePassage";
/**
 * 获取被预约车辆信息
 */
static NSString* URL_CAR_RESERVED = @"http://120.24.234.67/DongGuan/car/getCarAppoints";
/////////////////////////////////////////

/**
 * 注销登录接口
 */
static NSString* URL_USER_LOGIN = @"http://115.29.147.177:8099/interface/login";
static NSString* URL_USER_REGISTER = @"http://115.29.147.177:8099/interface/addUserInfo";
static NSString* URL_ADD_DEVICE = @"http://115.29.147.177:8099/interface/addMachineInfo";
static NSString* URL_STITIC_ADS = @"http://115.29.147.177:8099/:8000/interface/getAdvertiseList?";
static NSString* URL_DY_ADS = @"http://115.29.147.177:8099/:8000/interface/getAdvertiseList?";
static NSString* URL_DEVICE_LIST = @"http://115.29.147.177:8099/interface/getMachineList/";
static NSString* URL_DEVICE_INFO = @"http://115.29.147.177:8099/:8000/interface/getMachineInfo?";

#endif /* stdafx_MaZongApp_h */
