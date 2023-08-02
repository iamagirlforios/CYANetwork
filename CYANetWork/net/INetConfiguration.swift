//
//  INetConfiguration.swift
//  WDSwiftDemo
//
//  Created by 吴丹 on 2023/7/18.
//

import Foundation
import Alamofire

protocol INetConfiguration {
    var method: HTTPMethod {get set}
    var url: String {get set}//url
    var requestParams: [String: Any]? {get set}//请求参数
    var publicHeader: HTTPHeaders {get set}  //私有请求头
    var timeoutInterval: TimeInterval {get set}  //超时时间
    var requestInterceptor: RequestInterceptor? {get set}  //请求拦截器
}

class DefaultConfiguration: INetConfiguration {
    var method: Alamofire.HTTPMethod = .get
    var url: String = ""
    var requestParams: [String : Any]?
    var publicHeader: Alamofire.HTTPHeaders = [:]
    var timeoutInterval: TimeInterval = 30
    var requestInterceptor: Alamofire.RequestInterceptor?
}
