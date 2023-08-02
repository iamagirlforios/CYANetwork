//
//  CYABaseResponse.swift
//  WDSwiftDemo
//
//  Created by 吴丹 on 2023/7/18.
//

import Foundation

/*
 业务相关解析业务方自己实现
 */
class NetResponse<T>: BaseResponse<T> {
    override class func fromData(_ data: Data?) -> BaseResponse<OriginResponseDataType> {
        let model = NetResponse<OriginResponseDataType>()
        let json = Dictionary.fromData(data) ?? [:]   //data返回的是json类型，BaseResponse中定义了dict、array和string类型
        model.message = json["message"] as? String
        let code = json["code"] as? Int
        model.result = code == 0 ? .Success : .Failure  //code = 0时为成功
        model.data = json["data"] as? [String: Any]  //需要用到的data，如果
        return model
    }
}


class NewNetResponse<T>: BaseResponse<T> {
    override class func fromData(_ data: Data?) -> BaseResponse<OriginResponseDataType> {
        let model = NetResponse<OriginResponseDataType>()
        let json = Dictionary.fromData(data) ?? [:]   //data返回的是json类型，BaseResponse中定义了dict、array和string类型
        model.message = json["message"] as? String
        let status = json["status"] as? Int
        model.result = (status == 1 || status == 2) ? .Success : .Failure  //status = 1或者2时为成功
        model.data = json["data"] as? [String: Any]  //需要用到的data，如果
        return model
    }
}
