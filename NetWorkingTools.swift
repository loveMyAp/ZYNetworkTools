//
//  NetWorkingTools.swift
//  sniaWeiBo
//
//  Created by mac on 15/11/19.
//  Copyright © 2015年 cn.1069560719@qq. All rights reserved.
//

import UIKit
import AFNetworking
private let  weiboDomain = "com.baidu.data.error"
enum HTTPMothod: String {
    case POST = "POST"
    case GET = "GET"
}

class NetWorkingTools: AFHTTPSessionManager {
    
    static private var sharedTools: NetWorkingTools = {
        let urlString = "https://api.weibo.com/"
        let url = NSURL(string: urlString)
        let tools = NetWorkingTools(baseURL: url)
        tools.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return tools
    }()
    
    private func request(requestMethod: HTTPMothod ,urlString: String,parameters: [String:AnyObject]?,finished:(result: [String:AnyObject]?,error: NSError?) -> ()){
       
        if requestMethod == HTTPMothod.GET{
            NetWorkingTools.sharedTools.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [String:AnyObject] {
                    finished(result: dict, error: nil)
                }
                let dateError = NSError(domain: weiboDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey:"数据加载错误"])
                  finished(result: nil, error: dateError)
                }) { (_, error) -> Void in
                     finished(result: nil, error: error)
                    print(error)
            }
        }else if requestMethod == HTTPMothod.POST {
            NetWorkingTools.sharedTools.GET(urlString, parameters: parameters, success: { (_, result) -> Void in
                if let dict = result as? [String:AnyObject] {
                    finished(result: dict, error: nil)
                }
                let dateError = NSError(domain: weiboDomain, code: -10000, userInfo: [NSLocalizedDescriptionKey:"数据加载错误"])
                finished(result: nil, error: dateError)
                }) { (_, error) -> Void in
                    finished(result: nil, error: error)
                    print(error)
            }
        }
    }

}
