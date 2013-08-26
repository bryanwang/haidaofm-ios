//
//  defines.h
//  haidaofm
//
//  Created by Bruce Yang on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef haidaofm_defines_h
#define haidaofm_defines_h

#define SHARESDK_APPKEY @"4222d5526d"
#define APP_ID 583847938
#define UMENG_APPKEY @"50bb4b005270152357000010"

//#define BASE_URL @"http://127.0.0.1:7000"
#define BASE_URL @"http://api.haidaofm.com"
///////
#define BASIC_INTERFACE @"/api/basicInfo.json"
#define CHANNEL_DETAIL_INTERFACE @"/api/channel/detaillist.json"
#define PROGRAM_LIST_INTERFACE @"/api/program/list.json"
#define RECOMMANDATION_LIST_INTERFACE @"/api/recommend.json"
//////
#define PROGRAM_DETAIL_INTERFACE @"/api/program/detail.json"
#define CHANNEL_LIST_INTERFACE @"/api/channel/list.json"
#define SUBJECT_PROGRAM_LIST_INTERFACE @"/api/subject/list.json"
/////
#define USER_DETIAL_INTERFACE @"/api/user/detailinfo.json"
#define WEIBO_SIGNIN @"/api/connect/sinaweibo"
/////
#define FAV_UPDATE_INTERFACE @"/api/program/fav/update"
#define COMMENT_LIST_INTERFACE @"/api/program/comment_list"
#define COMMENT_INTERFACE @"/api/program/comment/create"
/////

#define UI_NAVIGATION_BAR_HEIGHT        44
#define UI_TOOL_BAR_HEIGHT              44
#define UI_TAB_BAR_HEIGHT               49
#define UI_STATUS_BAR_HEIGHT            20
#define UI_SCREEN_WIDTH                 320
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define DOCUMENTSDIRETORY [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]

#define TABBAR_HEIGHT 49.0f
#define CAP_WIDTH 2.0
#define PROGRAM_CELL_HEIGHT 58.0f
#define kDuration 0.3f
#define nDuration 2.0f

#define CELL_TITLE_COLOR [UIColor colorWithRed:49.0f / 255.0f green:49.0f / 255.0f blue:49.0f / 255.0f alpha:1.0f]
#define CELL_TIME_COLOR [AppUtil makeColorWithRed:149 green:149 blue:149];

#define CELL_TITLE_SELECTED_COLOR    [UIColor colorWithRed:49.0f / 255.0f green:49.0f / 255.0f blue:49.0f / 255.0f alpha:1.0f]

#define CELL_SUBTITLE_COLOR    [UIColor colorWithRed:100.0f / 255.0f green:100.0f / 255.0f blue:100.0f / 255.0f alpha:1.0f]

#define CELL_SUBTITLE_SELECTED_COLOR    [UIColor colorWithRed:100.0f / 255.0f green:100.0f / 255.0f blue:100.0f / 255.0f alpha:1.0f]

#define CELL_TITLE_FONT_SIZE 16.0f
#define CELL_SUBTITLE_FONT_SIZE 12.0f

#define KEYBOARD_HEIGHT 216.0f
#define KEYBOARD_TOOL_HEIGHT 44.0f
#define KEYBOARD_CHINESE_TOOL_HEIGHT 36.0f

#define USERDEFAULT_FAV_COLLECTIONS  @"ProgramFavCollections20130127"
#define USERDEFAULT_DOWNLOADED_COLLECTIIONS @"ProgramDownloadCollections20130127"
#define HAIDAO_FM_USER_INFO @"HAIDAOFMUSERINFO"

#define DJ_AVATAR_PLACEHOLDER @"icon-avatar.png"
#define COVER_IMAGE_PLACEHOLDER @"bg-pro-detail.png"
#define REC_COVER_IMAGE_PLACEHOLDER @"bg-rec.png"
#define SPE_REC_COVER_IMAGE_PLACEHOLDER @"bg-special-topic"


#endif
