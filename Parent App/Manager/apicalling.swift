//
//  apicalling.swift
//  Parent App
//
//  Created by Nap Works on 23/01/23.
//

import Foundation
import Alamofire


class APICalling {
    static let shared = APICalling()
    static let TAG = String(describing: APICalling.self)
    
    //MARK: - Signup API
    ///Signup API to login the user
    static func register(model: UserData, password: String, completionHandler: @escaping (Bool, String) -> Void ) {
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .authorization("aae3b9d9-44f9-4ec7-81e9-25de9502f32d")
        ]
        
        // request url for sign up api
        let url = Constants.BASE_URL+"signup"
        
        //params for signup api
        let params: [String: Any] = ["fullName": model.fullName!,
                                     "email": model.email!,
                                     "deviceType": model.deviceType!,
                                     "password": password,
                                     "accountType": model.accountType!
        ]
        
        //request for signup api using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: SignupModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completionHandler(true, result.message!)
                Auth.shared.saveAccountType(accountType: (result.userData?.accountType)!)
                Auth.shared.saveUser(user: result.userData!)
            }
            else {
                completionHandler(false, result.message!)
            }
        }
    }
    
    //MARK: - Login API
    ///Login API to login the user
    static func login(email: String, password: String, completion: @escaping (Bool, String)->Void) {
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .authorization("aae3b9d9-44f9-4ec7-81e9-25de9502f32d")
        ]
        
        //url for the login request
        let url = Constants.BASE_URL+"login"
        
        //params for the login request
        let params = ["email": email,
                      "password": password,
                      "loginType": Constants.LOGIN_TYPE,
                      "accountType": Constants.ACCOUNT_TYPE,
                      "deviceType": Constants.DEVICE_TYPE
        ]
        
        //login api request using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: SignupModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completion(true, result.message!)
                Auth.shared.saveAccountType(accountType: (result.userData?.accountType)!)
                Auth.shared.saveUser(user: result.userData!)
            }
            else {
                completion(false, result.message!)
            }
        }
        
    }
    
    //MARK: - Add Child API
    ///Add Child API to add the child
    static func addChild(model: ChildPostData, childimage: String,phoneNumber: String, userId: Int,session: String, auth: String, completionHandler: @escaping (Bool, String?, String?) -> Void ) {
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Authorization": "aae3b9d9-44f9-4ec7-81e9-25de9502f32d",
                                    "auth": auth
        ]
        
        // request url for sign up api
        let url = Constants.BASE_URL+"parent/addChild"
        
        //params for signup api
        let params: [String: Any] = ["fullName": model.fullName!,
                                     "userId": userId,
                                     "image": childimage,
                                     "phoneNumber": phoneNumber,
                                     "dateOfBirth": model.dateOfBirth!,
                                     "gradeField": model.grade!,
                                     "session": session
        ]
        
        //request for signup api using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: AddChildModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completionHandler(true, result.userData!.userName!, result.userData!.childPassword!)
            }
            else {
                completionHandler(false, nil, nil)
            }
        }
    }
    
    //MARK: - Get Child List API
    /// Get Child List API to fetch the child list from the backend
    static func getChildList( userId: Int,session: String, auth: String, completionHandler: @escaping (Bool, [ChildListData]?) -> Void ) {
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Authorization": "aae3b9d9-44f9-4ec7-81e9-25de9502f32d",
                                    "auth": auth
        ]
        
        // request url for sign up api
        let url = Constants.BASE_URL+"parent/getChildList"
        
        //params for signup api
        let params: [String: Any] = ["userId": userId,
                                     "session": session
        ]
        
        //request for signup api using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: GetChildListModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completionHandler(true, result.data!)
                //                Auth.shared.saveChildList(child: result.data!)
            }
            else {
                completionHandler(false, nil)
            }
        }
    }
    
    //MARK: - Delete Child API
    /// Delete Child API to delete the child  from the backend
    static func deleteChild( userId: Int,session: String, auth: String,childId: Int, completionHandler: @escaping (Bool) -> Void ) {
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Authorization": "aae3b9d9-44f9-4ec7-81e9-25de9502f32d",
                                    "auth": auth
        ]
        
        // request url for sign up api
        let url = Constants.BASE_URL+"parent/deleteChild"
        
        //params for signup api
        let params: [String: Any] = ["userId": userId,
                                     "session": session,
                                     "childId": childId
        ]
        
        //request for signup api using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: ChildDeleteModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completionHandler(true)
            }
            else {
                completionHandler(false)
            }
        }
    }
    
    //MARK: - Upload ChildImage API
    ///Upload child image API to upload the profile picture of the child
    static func uploadImage(image: UIImage, completionHandler: @escaping (Bool, String?) -> Void){
        let params = ["type": "child", "mediaType": "images"]
        let headers : HTTPHeaders = [.contentType("multipart/form-data"),
                                     .authorization("aae3b9d9-44f9-4ec7-81e9-25de9502f32d")
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imageData = image.pngData(){
                multipartFormData.append(imageData, withName: "file", fileName: "file.png", mimeType: "image/png")
                for (key, value) in params {
                    if let temp = value as? String{
                        multipartFormData.append(temp.data(using: .utf8)!, withName: key )
                    }
                }
            }
        }, to: Constants.BASE_URL+"upload", method: .post, headers: headers).responseDecodable(of: ChildImageModel.self) {response in
            guard let result = response.value else {return}
            
            if result.status == 1 {
                completionHandler(true, result.url!)
            }
            else {
                completionHandler(false, nil)
            }
        }
    }
    
    //MARK: - Get Child Profile API
    ///Get Child Profile API to fetch the profile of the individual child from the server
    static func getChildProfile(childId: Int,session: String, auth: String, completionHandler: @escaping (Bool, ChildProfileData?) -> Void ) {
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Authorization": "aae3b9d9-44f9-4ec7-81e9-25de9502f32d",
                                    "auth": auth
        ]
        
        // request url for sign up api
        let url = Constants.BASE_URL+"child/getChildProfileData"
        
        //params for signup api
        let params: [String: Any] = ["userId": childId,
                                     "session": session
        ]
        
        //request for signup api using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: ChildProfileModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completionHandler(true, result.userData!)
            }
            else {
                completionHandler(false, nil)
            }
        }
    }
    
    //MARK: - Update Child API
    ///Update Child API to update the child
    static func updateChild(model: ChildPostData, childimage: String,phoneNumber: String, userId: Int,childId: Int, session: String, auth: String, completionHandler: @escaping (Bool) -> Void ) {
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Authorization": "aae3b9d9-44f9-4ec7-81e9-25de9502f32d",
                                    "auth": auth
        ]
        
        // request url for sign up api
        let url = Constants.BASE_URL+"parent/editChildProfile"
        
        //params for signup api
        let params: [String: Any] = ["fullName": model.fullName!,
                                     "userId": userId,
                                     "childId": childId,
                                     "image": childimage,
                                     "phoneNumber": phoneNumber,
                                     "dateOfBirth": model.dateOfBirth!,
                                     "gradeField": model.grade!,
                                     "session": session
        ]
        
        //request for signup api using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: UpdateChildProfileModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completionHandler(true)
            }
            else {
                completionHandler(false)
            }
        }
    }
    
    //MARK: - Login with google API
    ///Login with google API to login the user with google
    static func loginWithGoogle(email: String, fullName: String, googleId: String, completion: @escaping (Bool, String)->Void) {
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .authorization("aae3b9d9-44f9-4ec7-81e9-25de9502f32d")
        ]
        
        //url for the login request
        let url = Constants.BASE_URL+"login"
        
        //params for the login request
        let params = ["email": email,
                      "loginType": Constants.GOOGLE_LOGIN,
                      "accountType": Constants.ACCOUNT_TYPE,
                      "deviceType": Constants.DEVICE_TYPE,
                      "fullName": fullName,
                      "googleId": googleId
        ]
        
        //login api request using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: SignupModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completion(true, result.message!)
                Auth.shared.saveAccountType(accountType: (result.userData!.accountType)!)
                Auth.shared.saveUser(user: result.userData!)
            }
            else {
                completion(false, result.message!)
            }
        }
        
    }
    
    //MARK: - Login with facebook API
    ///Login with facebook API to login the user with google
    static func loginWithFacebook(email: String, fullName: String, facebookId: String, completion: @escaping (Bool, String)->Void) {
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .authorization("aae3b9d9-44f9-4ec7-81e9-25de9502f32d")
        ]
        
        //url for the login request
        let url = Constants.BASE_URL+"login"
        
        //params for the login request
        let params = ["email": email,
                      "loginType": Constants.FACEBOOK_LOGIN,
                      "accountType": Constants.ACCOUNT_TYPE,
                      "deviceType": Constants.DEVICE_TYPE,
                      "fullName": fullName,
                      "facebookId": facebookId
        ]
        
        //login api request using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: SignupModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completion(true, result.message!)
                Auth.shared.saveAccountType(accountType: (result.userData?.accountType)!)
                Auth.shared.saveUser(user: result.userData!)
            }
            else {
                completion(false, result.message!)
            }
        }
        
    }
    
    //MARK: - Child Login API
    ///Login child API to login the child
    static func loginChild(childCode: String, childPassword: String, completion: @escaping (Bool, String)->Void) {
        let headers : HTTPHeaders = [
            .contentType("application/json"),
            .authorization("aae3b9d9-44f9-4ec7-81e9-25de9502f32d")
        ]
        
        //url for the login request
        let url = Constants.BASE_URL+"child/login"
        
        //params for the login request
        let params = ["userName": childCode,
                      "password": childPassword,
                      "deviceType": Constants.DEVICE_TYPE,
        ]
        
        //login api request using alamofire
        let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
        
        //response of request
        request.responseDecodable(of: ChildLoginModel.self) { response in
            guard let result = response.value else { return }
            if result.status == 1 {
                completion(true, result.message!)
                Auth.shared.saveAccountType(accountType: result.userData!.accountType!)
                Auth.shared.saveChild(child: result.userData!)
            }
            else {
                completion(false, result.message!)
            }
        }
        
    }
}


