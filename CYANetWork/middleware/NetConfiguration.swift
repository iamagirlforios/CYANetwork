//
//  CYANetConfiguration.swift
//  WDSwiftDemo
//
//  Created by 吴丹 on 2023/7/18.
//

import Foundation
import Alamofire

/*
 业务相关数据业务方自己实现
 */
class NetConfiguration: INetConfiguration {
    var url: String
    var requestParams: [String : Any]?
    var publicHeader: HTTPHeaders = ["system": "ios"]
    var timeoutInterval: TimeInterval = 300
    var method: HTTPMethod
    var requestInterceptor: Alamofire.RequestInterceptor?
    
    init(url: String,
         requestParams: [String : Any]? = nil,
         method: HTTPMethod = .get,
         appendHeader: [String : String]? = nil)  //appendHeader有的接口需要加入其他额外的header
    {
        self.url = url
        self.requestParams = requestParams
        self.method = method
        
        if let header = appendHeader {
            for (key, value) in header  {
                publicHeader[key] = value
            }
        }
    }
}
