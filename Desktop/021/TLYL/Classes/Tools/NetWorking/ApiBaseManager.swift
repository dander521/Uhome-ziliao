//
//  ApiBaseManager.swift
//  SearchGithubUserInfo
//
//  Created by menhao on 17/5/15.
//  Copyright © 2017年 menhao. All rights reserved.
//
import Foundation
import Alamofire
import SVProgressHUD


@objc enum ManagerRequestMethod : Int {
    
    case RequestMethodRestGET//, HEAD, , PUT, PATCH, DELETE, TRACE, CONNECT
    case RequestMethodRestPOST
}

//reform data for containers(Array/Dictionary) to contain strings for view to display
@objc protocol DataAdaptorProtocol {
    func reformResponseData(responseData: AnyObject, withManager: ApiBaseManager) -> AnyObject?
}


//every children class need to conform to this protocol
@objc protocol ApiManagerProtocol {
    
    var requestMethod: ManagerRequestMethod {get }
    var responseDataType: APIResponseDataType {get}
    @objc optional
    var isShowNodata:Bool{get}
     @objc optional
    var isShowNoNet:Bool{get}
     @objc optional
    var isShowError:Bool{get}
     @objc optional
    var isShowHud:Bool{get}
     @objc optional
    var isHomePage:Bool{get}
    
}
//git tag -a v1.1.0.0 -m “1.1.0.0版本 ”
class ApiBaseManager: SessionDelegate {
    
    //MARK: - functions
    func loadData() -> NSNumber? {
  
    
        guard let urlProvider = urlProviderDelegate else {
            return nil
        }
        
        cleanResponseData()
        
        let urlComponent = urlProvider.urlPathComponentForManager(manager: self)

//        let urlPath = "http://192.168.1.241:82/" + urlComponent//高栋栋
//        let urlPath = "http://192.168.1.113:8080/" + urlComponent//接口测试服务器地址
        let urlPath = "http://192.168.1.51:8080/" + urlComponent//接口测试服务器地址

        if urlPath.isEmpty {
            return nil
        }
//        let sessionManager = SessionManager.default
//        sessionManager.delegate = self
        var header = [String : String]()
        let parameters = urlProvider.parametersForManager(manager: self)
        let token = UserDefaults.standard.object(forKey: "Token") as? String
        let userid = UserDefaults.standard.object(forKey: "userId") as? String
        if token != nil && token != ""{
        
            header = ["Token":token!,"platformCode":"2","userId":userid!]
        }else{
           header = urlProvider.headerForManager!(manager: self)!
        }
        var requestMethod = ManagerRequestMethod.RequestMethodRestGET
        var responseDataType = APIResponseDataType.Json
        
        if let _ = requestCustomizeDelegate {
            requestMethod = requestCustomizeDelegate!.requestMethod
            responseDataType = requestCustomizeDelegate!.responseDataType
        }
            let status = NetworkReachabilityManager(host:"www.baidu.com")
            if status?.isReachable == true {
//              let host = NetworkReachabilityManager(host: "http://192.168.1.51:8080/web/-api/api/v4/net_is_work")
//                if host?.isReachable == false {
//                    if requestCustomizeDelegate?.isShowError == true{
//                    let erwindow = MCErrorWindow.alertInstance()
//                        erwindow?.showModelWindow()
//                        return 0
//                    }
//                }
    
            }
            else {//    无网络状态
//                if requestCustomizeDelegate?.isShowNoNet == true && requestCustomizeDelegate?.isHomePage == false{
//                    let erwindow = MCNONetWindow.alertInstance()
//                        erwindow?.showModelWindow()
//                    return 0
//                }

        }
   
   
        var requestId: NSNumber
        if requestCustomizeDelegate?.isShowHud == true {
//            SVProgressHUD.show(withStatus: "请稍后...")
//            SVProgressHUD.setBackgroundColor(UIColor.white)
        }
        
        
        
        

        switch requestMethod {
            
        case .RequestMethodRestGET:
            
            requestId = ApiProxy.sharedInstance.makeRestGetRequestForUrl(url: urlPath, parameters: parameters, responseDataType: responseDataType,header: header, successedCallBack: requestSuccessed, failedCallBack: requestFailed)
            
        case .RequestMethodRestPOST:
            
            requestId = ApiProxy.sharedInstance.makeRestPostRequestForUrl(url: urlPath, parameters: parameters, responseDataType: responseDataType,header:header, successedCallBack: requestSuccessed, failedCallBack: requestFailed)
        }
      
        allRequestIds.append(requestId)
        return requestId
    }
    
    //clean data for new request
    func cleanResponseData() {
        ResponseRawData = nil
        ResponseError = nil
    }
    
    func cancellRequest(requestId: NSNumber) {
        
        guard let index = getRequestIndex(requestId: requestId) else {
            return
        }
        
        ApiProxy.sharedInstance.cancellRequestForId(requestId: requestId)
        allRequestIds.remove(at: index)
    }
    
    func cancellAllRequests() {
        
        let count = allRequestIds.count
        for index in 0..<count {
            ApiProxy.sharedInstance.cancellRequestForId(requestId: allRequestIds[index])
            allRequestIds.remove(at: index)
        }
    }
    
    func removeRequestId(requestId: NSNumber) {
        
        guard let index = getRequestIndex(requestId: requestId) else {
            return
        }
        
        allRequestIds.remove(at: index)
    }
    
    func getRequestIndex(requestId: NSNumber) -> Int? {
        for (index, value) in allRequestIds.enumerated() {
            if value == requestId {
                return index
            }
        }
        
        return nil
    }
    
    //called after request successed
    func getReformedDataByAdaptor(adaptor: DataAdaptorProtocol) -> AnyObject? {
        if let _ = self.ResponseRawData {
            return adaptor.reformResponseData(responseData: self.ResponseRawData!, withManager: self)
        }
        
        return self.ResponseRawData
    }

    private
    //request callbacks
    func requestSuccessed(responseObj: AnyObject, requestId: NSNumber) {
        
        if requestCustomizeDelegate?.isShowHud == true {
            SVProgressHUD.dismiss()
            BKIndicationView.dismiss()
        }
        
        let respone = responseObj as? DataResponse<Any>
        if respone == nil {
            if let _ = apiCallBackDelegate {
                apiCallBackDelegate?.managerCallAPIDidFailed(manager: self, errorCode: nil)
                
            }
            return
        }
        
        let dic = respone?.result.value as! Dictionary<String, AnyObject>
        ResponseRawData = dic["data"]
        responseMessage = dic["message"]as? String
        ResponseHeader = respone?.response?.allHeaderFields as AnyObject
        if responseMessage != nil {
           
        if(responseMessage?.contains("成功"))! || (responseMessage?.contains("查询"))!||(responseMessage?.contains("参数"))!{
        } else {
            if requestCustomizeDelegate?.isShowHud == true {
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.showInfo(withStatus:dic["message"]as! String)
            }
        }
        }
            let result = dic["code"] as! NSNumber
            if result == 200 {
                if let _ = apiCallBackDelegate {
                    apiCallBackDelegate?.managerCallAPIDidSuccess(manager: self)
                }
            }else {
            if result == 401 || result == 407 || result == 405{
                let token = UserDefaults.standard.object(forKey: "Token") as? String
                let userid = UserDefaults.standard.object(forKey: "userId") as? String
                if token == nil || token == "" && userid == nil || userid == "" {
                    if let _ = apiCallBackDelegate {
                        apiCallBackDelegate?.managerCallAPIDidFailed(manager: self, errorCode: ["code":result])

                    }
                    return
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PRESENT_LOGINVC_NOTICATION"), object: nil)
            }else{
                if let _ = apiCallBackDelegate {
                    apiCallBackDelegate?.managerCallAPIDidFailed(manager: self, errorCode: ["code":result])
                }
                return
            }
        }
        removeRequestId(requestId: requestId)
       
    }

    func requestFailed(responseError: NSError, requestId: NSNumber) {
        if requestCustomizeDelegate?.isShowHud == true {
            SVProgressHUD.dismiss()
            BKIndicationView.dismiss()
        }
        ResponseError = responseError
        
        if requestCustomizeDelegate?.isShowError == true && requestCustomizeDelegate?.isHomePage == false{
//            let erwindow = MCErrorWindow.alertInstance()
//            erwindow?.showModelWindow()
            return
        }
        if let _ = apiCallBackDelegate {
            apiCallBackDelegate?.managerCallAPIDidFailed(manager: self, errorCode: ["code":responseError])

        }
        
        removeRequestId(requestId: requestId)
   
    }
 
////    #pragma mark 1.收到服务器相应
//    
//
//    override func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
//        
//    }
//    
//    
////    #pragma mark 2.服务器开始传输数据（一点一点返回，这个代理方法会被反复调用，返回 NSData 数据）
//    
//    override func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//   
//        
//    }
//
////    #pragma mark 3.客户端接收数据完成的时候
//    
//    override func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
//        
//    }
//  
    
   
    //MARK: - life cycle
    init(urlProvider: ApiManagerProvider?) {
        super.init()
        urlProviderDelegate = urlProvider
        
        if self is ApiManagerProtocol {
            requestCustomizeDelegate = self as? ApiManagerProtocol
        }
    }
 
    deinit {
        cancellAllRequests()
    }
    
    //MARK: instance variables
    var ResponseRawData: AnyObject?
    var ResponseError: NSError?
    var allRequestIds = Array<NSNumber>()
    var ResponseHeader :AnyObject?
    var responseMessage :String?
    //delegates
    weak var apiCallBackDelegate: ApiManagerCallBackProtocol?
    weak var urlProviderDelegate: ApiManagerProvider?
    weak var requestCustomizeDelegate: ApiManagerProtocol?
}

