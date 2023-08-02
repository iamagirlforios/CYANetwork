//
//  ViewController.swift
//  CYANetWork
//
//  Created by 吴丹 on 2023/8/2.
//

import UIKit
import HandyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //net文件夹：请求类封装
        //middleware文件夹：业务相关
        
        var config: INetConfiguration = NetConfiguration(url: "https://ssssssss", requestParams: ["name":"wd"], method: .get)
        //使用方法1返回类型为dict、string、array。用法是一样的
        NetWork.manager.request(config) { (response: NetResponse<[String: Any]>) in
            if response.result == .Success {
                print("response.data 类型为字典\(response.data ?? [:])")
            }
        }
        
        //使用方法2：模型在to中进行转换
        NetWork.manager.request(config) { json in
            let model = Model(name: json?["name"] as? String, age: json?["age"] as? String)
            return model
        } complation: { (response: NetResponse) in
            if response.result == .Success {
                print("response.data 类型为Model类型\(response.data!)")
            }
        }
        
        //model遵循了Handyjson
        NetWork.manager.request(config) { (response: NetResponse<ModelAAA>) in
            if response.result == .Success {
                print("response.data 类型为ModelAAA类型\(response.data!)")
            }
        }
        
        //使用默认提供的DefaultConfiguration
        config = DefaultConfiguration()
        config.url = ""
        config.requestParams = [:]
        config.method = .get
        //新增解析response
        NetWork.manager.request(config) { (response: NewNetResponse<ModelAAA>) in
            if response.result == .Success {
                print("response.data 类型为ModelAAA类型\(response.data!)")
            }
        }
    }
}


class Model {
    var name: String?
    var age: String?
    init(name: String? = nil, age: String? = nil) {
        self.name = name
        self.age = age
    }
}


class ModelAAA: HandyJSON {
    var name: String?
    var age: String?
    required init(){}
}
