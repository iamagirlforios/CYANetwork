//
//  NetWork.swift
//  WDSwiftDemo
//
//  Created by 吴丹 on 2023/7/18.
//

import Foundation
import Alamofire

typealias CYARequestComplate<V> = (_ response: V) -> Void

class NetWork {
    public static let manager = NetWork()
    private init(){}
    
    
    //返回的是原始后端返回的类型 dict、array、String
    func request<T: OriginResponseDataType, V: BaseResponse<T>>(_ config: INetConfiguration,
                                        complation: CYARequestComplate<V>?) {
        request(config, toTansform: nil, complation: complation)
    }
    
    /*
     网络请求接口
     V：IBaseResponse实现类，可自定义封装数据解析的成功和失败
        response.data：返回的数据
     toTransform：需要封装的model block，不传的话，返回dict
     
     config: 请求配置
     compete：请求完成回调，回调返回遵循IBaseResponse协议的对象
     */
    func request<T, V: BaseResponse<T>>(_ config: INetConfiguration,
                                          toTansform: (([String: Any]?) -> T?)?,
                                        complation: CYARequestComplate<V>?)
    {
        var encoding: ParameterEncoding = URLEncoding.default
        if config.method == .post {
            encoding = JSONEncoding.default
        }
        let request = AF.request(config.url, method: config.method, parameters: config.requestParams, encoding: encoding, headers: config.publicHeader as HTTPHeaders, interceptor: config.requestInterceptor)
        request.responseString { response in
            let responseM = V()
            responseM.httpStatus = response.response?.statusCode
            switch response.result {
            case .success(_):
                let parse = V.fromData(response.data)
                responseM.result = parse.result
                responseM.message = parse.message
                responseM.error = parse.error
                responseM.data = parse.data as? T
                
                if responseM.result == .Success, let transform = toTansform {
                    responseM.data = transform(parse.data as? [String: Any])
                    complation?(responseM)
                    return
                }
                complation?(responseM)
                
            case .failure(let error):
                responseM.result = .ServerError
                responseM.error = error
            }
            complation?(responseM)
        }
    }
}
