//
//  httprequest.h
//  leeMail
//
//  Created by F S on 2019/7/5.
//  Copyright © 2019 F S. All rights reserved.
//

#ifndef httprequest_h
#define httprequest_h


#pragma  -- 服务器地址
///   http://www.lihvip.com              正式环境
///   http://www.test.lihvip.com       测试环境
///   http://192.168.1.88/mall           本地环境


#ifdef DEBUG
//#define ServerHost @"http://www.test.lihvip.com"
//#define ServerHost @"http://192.168.1.88:8082"
#define ServerHost @"http://pcapi.test.lihvip.com"

#else

#define ServerHost @"http://www.lihvip.com"

#endif


#pragma -------------接口URL----------------------

///登录,注册及验证码接口URL
#define loginApiUrl           [ServerHost stringByAppendingString:@"/login.do"]
#define registerUrl            [ServerHost stringByAppendingString:@"/regUser.do"]
#define sendCodeUrl        [ServerHost stringByAppendingString:@"/sendCode.do"]
#define checkCodeUrl      [ServerHost stringByAppendingString:@"/checkCode.do"]
#define findPasswdUrl      [ServerHost stringByAppendingString:@"/findPasswd.do"]
///收获地址相关接口
#define addrLIstUrl           [ServerHost stringByAppendingString:@"/user/address/all.do"]
#define addAddrUrl           [ServerHost stringByAppendingString:@"/user/address/save.do"]
#define setMorenUrl           [ServerHost stringByAppendingString:@"/user/address/setDefault.do"]
#define deleaddrUrl           [ServerHost stringByAppendingString:@"/user/address/del.do"]
///用户银行卡相关接口
#define bankCardListUrl           [ServerHost stringByAppendingString:@"/user/bankcard/all.do"]
#define allBankNameUrl           [ServerHost stringByAppendingString:@"/user/bankcard/allBankName.do"]
#define deleteBankCard           [ServerHost stringByAppendingString:@"/user/bankcard/del.do"]
#define addBankCardUrl           [ServerHost stringByAppendingString:@"/user/bankcard/save.do"]
///省市区地址接口
#define selecteAddrUrl           [ServerHost stringByAppendingString:@"/selectRegionAll.do"]
///我的钱包相关接口
#define walletHeadUrl           [ServerHost stringByAppendingString:@"/user/fund.do"]
#define useableListUrl           [ServerHost stringByAppendingString:@"/user/fundList.do"]
#define distribuListUrl           [ServerHost stringByAppendingString:@"/user/distributionLog.do"]
///订单相关接口
#define orderListUrl           [ServerHost stringByAppendingString:@"/user/distributionLog.do"]




#pragma mark --------- 存储信息的相关字段 ---------
///token   hMQFA65kkB7IryhBDRYCdY14KTqVyjVTAcnfNzl1lVlWUappYzIwVw==
static NSString *token = @"token";
///手机号
static NSString *phoneNum = @"phone";
///省市区数组
static NSString *addressAreas = @"addressAreas";

#endif /* httprequest_h */
