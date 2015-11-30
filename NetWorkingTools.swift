//
//  NetWorkingTools.swift
//  sniaWeiBo
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 cn.1069560719@qq. All rights reserved.
//

import UIKit
import AFNetworking
private let Domain = "com.baidu.data.error"
enum HTTPMothod: String {
    case POST = "POST"
    case GET = "GET"
}

class NetWorkingTools: AFHTTPSessionManager {
    
     //定义单例对象
     /* 
       我添加的一个text解析方式,可以根据自己的项目需求自己手动的添加解析方式
       tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
    
    */
    static var sharedTools: NetWorkingTools = {
        let tools = NetWorkingTools()
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    //定义网络访问方法  以后所有的网络访问都经过该方法调用 AFN
    //加载字典数据
    /*
     requestMethod: 发送网络请求的方法类型(枚举)
     urlString:  网络请求地址
     parameters: 拼接网络地址参数
     finished:   返回结果回调(result: 字典类型的数据回调,error: 返回错误信息)
    */
     func request(requestMethod: HTTPMothod ,urlString: String,parameters: [String:AnyObject]?,finished:(result: [String:AnyObject]?,error: NSError?) -> ()){
        
        //调用AFN具体的 GET,POST方法
        if requestMethod == HTTPMothod.GET{
            NetWorkingTools.sharedTools.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [String:AnyObject] {
                    finished(result: dict, error: nil)
                }
                let dateError = NSError(domain: Domain, code: -10000, userInfo: [NSLocalizedDescriptionKey:"数据加载错误"])
                  finished(result: nil, error: dateError)
                }) { (_, error) -> Void in
                     finished(result: nil, error: error)
                    print(error)
            }
        }else if requestMethod == HTTPMothod.POST {
            NetWorkingTools.sharedTools.POST(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [String:AnyObject] {
                    finished(result: dict, error: nil)
                }
                let dateError = NSError(domain: Domain, code: -10000, userInfo: [NSLocalizedDescriptionKey:"数据加载错误"])
                finished(result: nil, error: dateError)
                }) { (_, error) -> Void in
                    finished(result: nil, error: error)
                    print(error)
            }
        }
    }
    
     //加载数组数据
    func requestArray(requestMethod: HTTPMothod ,urlString: String,parameters: [String:AnyObject]?,finished:(result: [AnyObject]?,error: NSError?) -> ()){
        
        //调用AFN具体的 GET,POST方法
        if requestMethod == HTTPMothod.GET{
            NetWorkingTools.sharedTools.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [AnyObject] {
                    finished(result: dict, error: nil)
                }
                let dateError = NSError(domain: Domain, code: -11000, userInfo: [NSLocalizedDescriptionKey:"数据加载错误"])
                finished(result: nil, error: dateError)
                }) { (_, error) -> Void in
                    finished(result: nil, error: error)
                    print(error)
            }
        }else if requestMethod == HTTPMothod.POST {
            NetWorkingTools.sharedTools.POST(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [AnyObject] {
                    finished(result: dict, error: nil)
                }
                let dateError = NSError(domain: Domain, code: -11000, userInfo: [NSLocalizedDescriptionKey:"数据加载错误"])
                finished(result: nil, error: dateError)
                }) { (_, error) -> Void in
                    finished(result: nil, error: error)
                    print(error)
            }
        }
    }
    
    
    //添加上传图片的方法
    func uploadImage(urlString: String,parmaters: [String : AnyObject]?,imageData: NSData,finished: (result: [String : AnyObject]?, error: NSError?) -> ()) {
        
        POST(urlString, parameters: parmaters, constructingBodyWithBlock: { (multipartFormData) -> Void in
            
            //1.data  要上传的文件的二进制数据
            //2.name 表示上传的文件服务器对应的字段
            //3.filename 表示服务器接受后 存储的名字   名字可以随便取
            //4.上传文件的格式  image/jpeg
            multipartFormData.appendPartWithFileData(imageData, name: "pic", fileName: "OMG", mimeType: "image/jpeg")
            }, success: { (_, result) -> Void in
                if let dict = result as? [String : AnyObject] {
                    finished(result: dict, error: nil)
                }
                
            }) { (_, error) -> Void in
                finished(result: nil, error: error)
                print(error)
        }
    }


}
