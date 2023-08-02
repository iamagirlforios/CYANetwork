//
//  NetWork+HandyJson.swift
//  WDSwiftDemo
//
//  Created by 吴丹 on 2023/8/1.
//

import Foundation
import HandyJSON

//使用了HandyJson，可以替换成其他的工具类
extension NetWork {
    func request<T, V: BaseResponse<T>>(_ config: INetConfiguration, complation: CYARequestComplate<V>?) where T : HandyJSON {
        request(config, toTansform: { json in
            return T.deserialize(from: json)
        }, complation: complation)
    }
}
