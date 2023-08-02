//
//  IBaseResponse.swift
//  WDSwiftDemo
//
//  Created by 吴丹 on 2023/7/19.
//

import Foundation

enum ResponseResult {
    case Success   //请求成功
    case Failure   //请求失败
    case ServerError   //服务器出错
    case TimeOut  //请求超时
}

class BaseResponse<T> {
    var data: T?
    var error: Error?
    var message: String?
    var result: ResponseResult
    var httpStatus: Int?

    required init() {
        result = .Failure
    }

    //子类重写
    class func fromData(_ data: Data?) -> BaseResponse<OriginResponseDataType> {
        let model = BaseResponse<OriginResponseDataType>()
        model.data = parseData(data)
        model.result = .Success
        return model
    }
    
    class func parseData(_ data: Data?) -> OriginResponseDataType? {
        if let result = String.fromData(data) {
            return result
        }
        if let result = Dictionary.fromData(data) {
            return result
        }
        return nil
    }
}

//后端返回的数据类型
protocol OriginResponseDataType {
    static func fromData(_ data: Data?) -> Self?
}
 
extension String: OriginResponseDataType {
    //解析data
    static func fromData(_ data: Data?) -> String? {
        guard let data = data else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Dictionary<String, Any>: OriginResponseDataType {
    //解析data
    static func fromData(_ data: Data?) -> Dictionary<String, Any>? {
        guard let data = data else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
}

extension Array<Any>: OriginResponseDataType {
    //解析data
    static func fromData(_ data: Data?) -> Array<Any>? {
        guard let data = data else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [Any]
    }
}
