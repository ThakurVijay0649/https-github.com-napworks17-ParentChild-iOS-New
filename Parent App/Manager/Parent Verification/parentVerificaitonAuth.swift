//
//  parentVerificaitonAuth.swift
//  Parent App
//
//  Created by Nap Works on 08/02/23.
//

import Foundation
import Alamofire

class Verification {
    
    ///Method to send otp on parent's email
    
    func sendOTP(email: String, isLive: String, completion: @escaping (Bool, String) -> Void) {
            let headers : HTTPHeaders = [
                .contentType("application/json"),
                .authorization("aae3b9d9-44f9-4ec7-81e9-25de9502f32d")
            ]
            
            // request url for sign up api
            let url = Constants.BASE_URL+"forgetpassword"
            
            //params for signup api
            let params: [String: Any] = ["email": email,
                                         "isLive": isLive,
            ]
            
            //request for signup api using alamofire
            let request = AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
            
            //response of request
            request.responseDecodable(of: SignupModel.self) { response in
                guard let result = response.value else { return }
                if result.status == 1 {
                    completion(true, result.message!)
                }
                else {
                    completion(false, result.message!)
                }
            }
        }
    
}
