//
//  URLMacro.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#ifndef URLMacro_h
#define URLMacro_h


//生产环境
//#define UG_HOST  @"http://www-prd-urgoo.com/urgoo/"

//开发环境
#define UG_HOST  @"http://www-test-urgoo.com:80/urgoo/"

//本机试
//#define UG_HOST  @"http://10.203.203.49:8082/urgoo/"
//#define UG_HOST  @"http://10.203.203.86:8080/urgoo/"




//图片
#define UG_HOST1  @"http://139.129.164.163:8080/urgoo/"

//插入协议
#define UG_insertOrderProtocol_URL [NSString stringWithFormat:@"%@001/001/order/insertOrderProtocol",UG_HOST]
//  我的二维码  001/001/cqrcode/createQrcode
#define UG_createQrcode_URL [NSString stringWithFormat:@"%@001/001/cqrcode/createQrcode",UG_HOST]
// 聘用顾问  001/001/order/insertOrder
#define UG_confirmService_URL [NSString stringWithFormat:@"%@001/001/order/confirmService?",UG_HOST]
// 支付时间一览
#define UG_getPayTimeDetail_URL [NSString stringWithFormat:@"%@001/001/order/getPayTimeDetail?",UG_HOST]
// 生成新订单
#define UG_insertOrder_URL [NSString stringWithFormat:@"%@001/001/order/insertOrder",UG_HOST]

//规划
//  time plan  001/001/task/newTimeLine?

#define newTimeLine [NSString stringWithFormat:@"%@001/001/task/newTimeLine?",UG_HOST]
//任务列表

#define getStudentTaskListNewest [NSString stringWithFormat:@"%@001/001/task/getStudentTaskListNewest?",UG_HOST]
//首页
//图片轮播

#define UG_selectBannerList_URL [NSString stringWithFormat:@"%@001/001/banner/selectBannerList",UG_HOST]
//bnner 下的
#define UG_CounselorBannerList_URL [NSString stringWithFormat:@"%@/001/001/counselorbanner/selectCounselorBannerList?",UG_HOST]
//首页直播页表
#define UG_selectZoomLiveList_URL [NSString stringWithFormat:@"%@001/001/live/selectZoomLiveList",UG_HOST]
//首页推荐顾问列表

#define UG_findCounselorList_URL [NSString stringWithFormat:@"%@001/001/nosign/findCounselorList",UG_HOST]
//首页推荐顾问列表22  001/001/client/getMyCounselorList?

#define UG_getMyCounselorListTop_URL [NSString stringWithFormat:@"%@001/001/client/getMyCounselorListTop?",UG_HOST]
// /001/001/nosign/screen?
//顾问列表

#define UG_getSearchCounselorList_URL [NSString stringWithFormat:@"%@001/001/nosign/getSearchCounselorList2",UG_HOST]

#define UG_getMyCounselorList_URL [NSString stringWithFormat:@"%@001/001/client/getMyCounselorList?",UG_HOST]
// 高级搜索列表
#define UG_nosign_screen_URL [NSString stringWithFormat:@"%@001/001/nosign/screen2?",UG_HOST]

// 001/001/nosign/findInfo
// 热门搜索
#define UG_nosign_findInfo_URL [NSString stringWithFormat:@"%@001/001/nosign/findInfo?",UG_HOST]

//预约功能 地址
// Zoom视频--接受 or 拒绝
#define isClientcceptStates [NSString stringWithFormat:@"%@/001/001/zoom/zoomUserOpt2",UG_HOST]

// Zoom视频--获取房间number
#define UG_zoomHostNumber_URL [NSString stringWithFormat:@"%@/001/001/zoom/selectZoomChatClientAndConsult2",UG_HOST]


//21. Zoom视频--对方名字
#define UG_zoomHostName_URL [NSString stringWithFormat:@"%@/001/001/zoom/selectZoomChatClientAndConsult",UG_HOST]
//Zoom 获取Host_id
#define UG_getZoomHost_id_URL [NSString stringWithFormat:@"%@001/001/zoom/insertZoomAccount",UG_HOST]

//Zoom 插入房间号
#define UG_insertZoomNumber_id_URL [NSString stringWithFormat:@"%@001/001/zoom/createZoomChat",UG_HOST]

//查询客户端预约信息

#define advanceInfoClient [NSString stringWithFormat:@"%@001/001/advance/advanceInfoClient3",UG_HOST]
//支付宝请求签名
#define UG_launchAliPay_URL [NSString stringWithFormat:@"%@001/001/order/launchAliPay",UG_HOST]

//头像更新上传
#define UG_editUserIcon_URL [NSString stringWithFormat:@"%@001/001/user/editUserIcon",UG_HOST]

//微信请求签名
#define UG_tenPayLaunch_URL [NSString stringWithFormat:@"%@001/001/pay/tenPayLaunch2",UG_HOST]
//支付宝订单结束后
#define payorder_insertSubOrderDetail [NSString stringWithFormat:@"%@001/001/payorder/insertSubOrderDetail?",UG_HOST]
//获取支付订单详情
#define getOrderBalanceMoney [NSString stringWithFormat:@"%@001/001/payorder/getOrderBalanceMoney?",UG_HOST]
//客户端添加预约
#define addAdvanceClient [NSString stringWithFormat:@"%@001/001/advance/addAdvanceClient",UG_HOST]
//客户端取消预约
#define cancelAdvanceClient [NSString stringWithFormat:@"%@/001/001/advance/cancelAdvanceClient",UG_HOST]
//客户端未确认查询
#define advanceUnconfirmeListClient [NSString stringWithFormat:@"%@/001/001/advance/advanceUnconfirmeListClient",UG_HOST]
//客户端确认查询
#define advanceConfirmeListClient [NSString stringWithFormat:@"%@001/001/advance/advanceConfirmeListClient",UG_HOST]
//advanceCloseListClient
//客户端结束查询
#define advanceCloseListClient [NSString stringWithFormat:@"%@001/001/advance/advanceCloseListClient",UG_HOST]
//客户取消预约时的原因列表
#define UG_advanceReasonList_URL [NSString stringWithFormat:@"%@/001/001/advance/advanceReason",UG_HOST]
//客户端未确认详情
#define advanceDetailClient [NSString stringWithFormat:@"%@/001/001/advance/advanceDetailClient2?termType=2&",UG_HOST]
//客户端确认详情
#define advanceConfirmeDetailClient [NSString stringWithFormat:@"%@/001/001/advance/advanceConfirmeDetailClient2",UG_HOST]
//客户端结束详情
#define advanceDetailClosedClient [NSString stringWithFormat:@"%@/001/001/advance/advanceDetailClosedClient2?termType=2&",UG_HOST]
///001/001/advance/advanceCommentClient
//客服端评价
//#define advanceCommentClient [NSString stringWithFormat:@"%@/001/001/advance/advanceCommentClient",UG_HOST]
//.提醒是否有预约
#define UG_isScheduleRedShow_URL [NSString stringWithFormat:@"%@/001/001/advance/redShow?termType=2&",UG_HOST]
//.去掉红点
#define UG_cleanRedShow_URL [NSString stringWithFormat:@"%@/001/001/advance/cleanRedShow?termType=2&",UG_HOST]


// 查看是否有预约关系 聊天界面 ///001/001/advance/reAdvanceCancel  001/001/advance/reAdvanceAccept
#define UG_isAdvanceRelation_URL [NSString stringWithFormat:@"%@/001/001/advance/isAdvanceRelation1",UG_HOST]

//客户端预约评价
#define advanceCommentClient [NSString stringWithFormat:@"%@/001/001/advance/advanceComment2",UG_HOST]
//客户端预约评价取消
#define updateAdvanceStatus [NSString stringWithFormat:@"%@/001/001/advance/updateAdvanceStatus",UG_HOST]
//客户端重新预约接受
#define reAdvanceAccept [NSString stringWithFormat:@"%@/001/001/advance/reAdvanceAccept",UG_HOST]
//客户端重新预约拒绝  ///001/001/advance/startAdvance?
#define reAdvanceCancel [NSString stringWithFormat:@"%@/001/001/advance/reAdvanceCancel",UG_HOST]
//发起视频请求的网络
#define startAdvance [NSString stringWithFormat:@"%@/001/001/advance/startAdvance",UG_HOST]

//获取验证码---注册
#define UG_LOGIN_GET_IDENTIFYING_CODE [NSString stringWithFormat:@"%@001/001/login/getIdentifyingCode?termType=2&",UG_HOST]

//获取验证码---登录的验证码
#define UG_loginGetIdentifyingCodeLogin_URL [NSString stringWithFormat:@"%@001/001/login/getIdentifyingCodeLogin",UG_HOST]

//注册
#define UG_LOGIN_CLINTREGIST [NSString stringWithFormat:@"%@001/001/login/clientRegist?termType=2&",UG_HOST]
//立即聘用 跳到H5
///001/001/client/understandService?termType=2&
#define GotounderstandService [NSString stringWithFormat:@"%@001/001/client/understandService?termType=2&",UG_HOST]
//登录
#define UG_LOGIN_COUNT   [NSString stringWithFormat:@"%@001/001/login/clientLogin?termType=2&",UG_HOST]

//验证码登录
#define UG_loginClientLoginByCode_URL   [NSString stringWithFormat:@"%@001/001/login/clientLoginByCode",UG_HOST]

//验证订单 -- 是否下单
#define UG_USER_SELECT_ORDER_INFO [NSString stringWithFormat:@"%@001/001/top/clientTop?termType=2&",UG_HOST]

//获取验证码---修改密码
#define UG_LOGIN_IDENTIFYING_CODE [NSString stringWithFormat:@"%@001/001/login/identifyingCode?termType=2&",UG_HOST]
//Html5Mark
#define Html5Mark @"_"

//找回密码-输入验证码
#define UG_LOGIN_CLIENT_FIND_PASSWORD   [NSString stringWithFormat:@"%@001/001/login/clientFindPassword?termType=2&",UG_HOST]


//找回密码-输入新密码--修改密码
#define UG_USER_UPDATE_PASSWORD   [NSString stringWithFormat:@"%@001/001/user/updatePassword?termType=2&",UG_HOST]


//找回密码-输入新密码--忘记密码
#define UG_LOGIN_UPDATE_PASSWORD   [NSString stringWithFormat:@"%@001/001/login/updatePassword?termType=2&",UG_HOST]


//上传头像
#define UG_USER_UPDATE_USER_ICON    [NSString stringWithFormat:@"%@001/001/user/updateUserIcon?termType=2&",UG_HOST]


//完善资料
#define UG_USER_PREFECT_INFOMATION   [NSString stringWithFormat:@"%@001/001/user/perfectInformation?termType=2&",UG_HOST]


//家长信息
#define UG_USER_SELECT_PARENTS_INFO [NSString stringWithFormat:@"%@001/001/user/selectParentInfo?termType=2&",UG_HOST]


//个人资料里面的选择国家
#define UG_PROFILE_SELECT_COUNTRY_LIST [NSString stringWithFormat:@"%@001/001/profile/selectCountryList?termType=2&",UG_HOST]

//顾问详情
#define UG_clientProfile_URL [NSString stringWithFormat:@"%@/001/001/client/counselorInfoContract?",UG_HOST]

//下拉， 上拉 刷新
#define UG_searchCounselorList_URL [NSString stringWithFormat:@"%@001/001/nosign/searchCounselorList?",UG_HOST]
//筛选 网络

#define UG_nosign_searchInfo_URL [NSString stringWithFormat:@"%@001/001/nosign/searchInfo?termType=2",UG_HOST]

// 筛选之后的 网络请求
#define UG_nosign_searchCounselorList_URL [NSString stringWithFormat:@"%@001/001/nosign/searchCounselorList?termType=2&",UG_HOST]
//家长的详情
#define UG_studentInfoPage_URL [NSString stringWithFormat:@"%@/001/001/student/studentInfoPage",UG_HOST]

//关注
#define UG_STUDENT_FOLLOW_URL [NSString stringWithFormat:@"%@001/001/student/follow",UG_HOST]


//客户(学生)
#define UG_STUDENT_CLINT_URL [NSString stringWithFormat:@"%@001/001/student/client",UG_HOST]


//我的订单
#define UG_ORDER_MYORDER_URL [NSString stringWithFormat:@"%@001/001/order/myOrder",UG_HOST]


//留学报告
#define UG_REPORT_SEMESTERLZ_URL [NSString stringWithFormat:@"%@001/001/student/reportSemesterJz",UG_HOST]


//学生信息
#define UG_STUDENT_STUDENTINFO_URL [NSString stringWithFormat:@"%@001/001/student/studentInfo",UG_HOST]

//获取系统消息条数
#define UG_informationCount_URL [NSString stringWithFormat:@"%@/001/001/information/selectRedCount",UG_HOST]


//获取消息列表
#define UG_informationTable_URL [NSString stringWithFormat:@"%@/001/001/information/selectInformation",UG_HOST]

//获取消息列表(Person)
#define UG_informationTablePerson_URL [NSString stringWithFormat:@"%@/001/001/information/selectInformationPerson",UG_HOST]

//任务
#define UG_TASK_TASK_URL [NSString stringWithFormat:@"%@001/001/task/task",UG_HOST]


//任务详细
#define UG_TASK_TASKDETAIL_URL [NSString stringWithFormat:@"%@001/001/task/taskDetail",UG_HOST]
//任务详情
#define UG_TASK_TASKDETAILSTU_URL [NSString stringWithFormat:@"%@001/001/task/taskDetailStu",UG_HOST]

//账户
#define UG_ACCOUNT_ACCOUNT_URL [NSString stringWithFormat:@"%@001/001/account/account",UG_HOST]
// account消息已读
#define UG_informationAccountDetail_URL [NSString stringWithFormat:@"%@/001/001/information/selectInformationDetail",UG_HOST]

//账户详细
#define UG_ACCOUNT_ACCOUNTDETAIL_URL [NSString stringWithFormat:@"%@001/001/account/accountDetail",UG_HOST]
//APP的更新
#define UG_appUpData_URL [NSString stringWithFormat:@"%@adminLogin/getVesionUpList",UG_HOST]

//APP网址
#define appUpData @"https://itunes.apple.com/cn/app/you-gu/id1104183024?mt=8"


#define UG_TEST_ACCOUNT_URL [NSString stringWithFormat:@"%@001/001/account/account",UG_HOST]


#define UG_TEST_TASK_URL [NSString stringWithFormat:@"%@001/001/task/task",UG_HOST]


#define UG_TEST_URL @"http://115.28.50.163:8080/"


#define Baidu @"http://www.baidu.com"


//搜索客户(学生)


#define UG_STUDENT_SEARCHCLIENT_URL [NSString stringWithFormat:@"%@001/001/nosign/searchConsultant",UG_HOST]


#define UG_myConsultant_URL [NSString stringWithFormat:@"%@001/001/client/myConsultant",UG_HOST]


#define UG_mmyInfo_URL [NSString stringWithFormat:@"%@001/001/client/myInfo",UG_HOST]


#define UG_ParentOrder_URL [NSString stringWithFormat:@"%@001/001/order/parentOrder",UG_HOST]


#define UG_ParentAccount_URL [NSString stringWithFormat:@"%@001/001/account/parentAccount",UG_HOST]


#define UG_ParentPlanning_URL [NSString stringWithFormat:@"%@001/001/student/parentPlanningHtml",UG_HOST]


#define UG_ParentFollow_URL [NSString stringWithFormat:@"%@001/001/student/parentFollowHtml",UG_HOST]


#define UG_ParentSchedule_URL [NSString stringWithFormat:@"%@001/001/schedule/parentScheduleHtml",UG_HOST]


#define UG_Task_URL [NSString stringWithFormat:@"%@001/001/task/taskJz",UG_HOST]


//登陆以后返回的token
#define kToken [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]
//登录以后的订单状态
#define OrderStatus [[NSUserDefaults standardUserDefaults] valueForKey:@"OrderStatus"]


//登陆以后返回的userHxCode
#define kUserHxCode [[NSUserDefaults standardUserDefaults] valueForKey:@"userHxCode"]
// system 消息已读
#define UG_informationSystemDetail_URL [NSString stringWithFormat:@"%@/001/001/information/selectInformationSystemDetail",UG_HOST]

//头像显示的url
#define kHeadImageUrl [NSString stringWithFormat:@"%@001/001/userIcon/getIconByHxCode?termType=2&userHxCode=",UG_HOST]


//头像和昵称
#define kHeadImage_Nick_Url [NSString stringWithFormat:@"%@001/001/profile/getUserInfoByHxCode",UG_HOST]


//城市列表
#define UG_CityList_URL [NSString stringWithFormat:@"%@001/001/profile/selectCityList?termType=2&",UG_HOST]


#define UG_Help_URL [NSString stringWithFormat:@"%@001/001/client/helpJz",UG_HOST]


//******直播*****

//直播最新动态列表
#define UG_ZoomLiveNewestList_URL [NSString stringWithFormat:@"%@001/001/livePage/selectZoomLiveNewest",UG_HOST]

//直播往期回顾列表
#define UG_ZoomLivePassedList_URL [NSString stringWithFormat:@"%@001/001/livePage/selectZoomPassed",UG_HOST]

//直播详情
#define UG_ZoomLiveDetail_URL [NSString stringWithFormat:@"%@001/001/livePage/selectZoomLiveDetail2",UG_HOST]

//直播详情里的往期回顾
#define UG_ZoomLiveDetailPassed_URL [NSString stringWithFormat:@"%@001/001/livePage/selectZoomPassedInDetail",UG_HOST]

//直播详情里的往期回顾
#define UG_ZoomLiveDetailCommentList_URL [NSString stringWithFormat:@"%@001/001/livecomment/selectLiveCommentList",UG_HOST]

//直播详情里的评论
#define UG_ZoomLiveDetailCommentContent_URL [NSString stringWithFormat:@"%@001/001/livecomment/insertLiveCommentContent",UG_HOST]

//直播详情里的报名
#define UG_ZoomLiveDetailAddActivitySign_URL [NSString stringWithFormat:@"%@001/001/livePage/addActivitySign",UG_HOST]

//顾问详情(图片视频混合)
#define UG_CounselorDetailImageAndVideo_URL [NSString stringWithFormat:@"%@001/001/attention/selectCounselorDetailSubList",UG_HOST]

//顾问详情(基本信息)
#define UG_FindCounselorDetail_URL [NSString stringWithFormat:@"%@001/001/attention/findCounselorDetail",UG_HOST]

//顾问详情(顾问的服务)
#define UG_SelectCounselorServiceList_URL [NSString stringWithFormat:@"%@001/001/attention/selectCounselorServiceList",UG_HOST]

//家长关注顾问
#define UG_CounselorAddFollow_URL [NSString stringWithFormat:@"%@001/001/attention/addFollow",UG_HOST]

//家长取消关注
#define UG_CounselorCancleFollow_URL [NSString stringWithFormat:@"%@001/001/attention/cancleFollow",UG_HOST]

//工作列表
#define UG_CounselorWorksList_URL [NSString stringWithFormat:@"%@001/001/attention/selectCounselorWorksList",UG_HOST]

//顾问详情(统计该顾问被多少家长看过)
#define UG_StatCounselorCount_URL [NSString stringWithFormat:@"%@001/001/attention/statCounselorCount",UG_HOST]

//进入Zoom
#define UG_isJoinZoomRoom_URL [NSString stringWithFormat:@"%@001/001/zoom/getZoomRoom",UG_HOST]


//杨德成  我的活动
#define UG_MyNotstartedActivityList_URL [NSString stringWithFormat:@"%@/001/001/user/selectZoomLiveByParaentIdNoSatrt",UG_HOST]
#define UG_MyOtherActivityList_URL [NSString stringWithFormat:@"%@/001/001/user/selectZoomLiveByParaentId",UG_HOST]


//杨德成 20160725 我关注的顾问
#define UG_MyCounselorList_URL [NSString stringWithFormat:@"%@/001/001/user/getSearchCounselorListByParaentId",UG_HOST]


//---------注册改版
//问卷
#define UG_selectQuestionListAll_URL [NSString stringWithFormat:@"%@001/001/login/selectQuestionListAllIphone",UG_HOST]

//上传答案 JsonString
#define UG_clientRegistJsonString_URL [NSString stringWithFormat:@"%@001/001/login/clientRegistContent",UG_HOST]

//规划:所有类别及完成情况
#define UG_tasknewTaskList_URL [NSString stringWithFormat:@"%@001/001/task/newTaskList",UG_HOST]

//规划:任务详情
#define UG_tasknewTaskDetail_URL [NSString stringWithFormat:@"%@001/001/task/newTaskDetail",UG_HOST]

//预约已确认列表，结束列表红点
#define UG_redShowAdvance_URL [NSString stringWithFormat:@"%@001/001/advance/redShowAdvance",UG_HOST]

//预约已确认列表，结束列表红点
#define UG_cleanRedShowAdvance_URL [NSString stringWithFormat:@"%@001/001/advance/cleanRedShowAdvance",UG_HOST]

//华瑞银行支付
#define UG_payHuaRuiPayLaunch_URL [NSString stringWithFormat:@"%@001/001/pay/huaRuiPayLaunch",UG_HOST]


#endif /* URLMacro_h */
