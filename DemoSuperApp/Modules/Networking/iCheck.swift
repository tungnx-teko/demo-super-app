//
//  iCheck.swift
//  DemoSuperApp
//
//  Created by Tung Nguyen on 12/8/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation
import TekCoreNetwork
import TekCoreService
import Alamofire

enum iCheck {
    
    class TokenGenerateCode: TekoStringCode {
        
        override var successCode: String {
            return "200"
        }
        
        private enum Keys: String, CodingKey {
            case statusCode = "statusCode"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            let statusCode = try container.decodeIfPresent(String.self, forKey: .statusCode)
            super.init(code: statusCode, message: "")
        }
        
    }
    
    class TokenGenerateService: BasicWorkerService {
        
        init(url: URL) {
            super.init(url: url)
        }
        
        func requestToGenerateToken(completion: @escaping ((String?) -> Void)) {
            let request = TokenGenerateRequest()
            apiManager.call(request, onSuccess: { response in
                completion(response.data?.token)
            }) { (error, _) in
                completion(nil)
            }
            
        }
        
    }
    
    struct TokenGenerateRequest: BaseRequestProtocol {
        typealias ResponseType = TokenGenerateResponse
        
        var encoder: APIParamEncoder {
            return .singleParams([:], encoding: Alamofire.URLEncoding.default)
        }
        
        var hasToken: Bool {
            false
        }
        
        var method: APIMethod {
            .get
        }
        
        var path: String {
            "/shop/genToken"
        }
        
    }
    
    class TokenGenerateData: Decodable {
        
        var token: String?
        
        private enum Keys: String, CodingKey {
            case token = "token"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            token = try container.decodeIfPresent(String.self, forKey: .token)
        }
        
    }
    
    class TokenGenerateResponse: BaseResponse<TokenGenerateCode> {
        
        let data: TokenGenerateData?
        
        private enum Keys: String, CodingKey {
            case data = "data"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            data = try container.decodeIfPresent(TokenGenerateData.self, forKey: .data)
            try super.init(from: decoder)
        }
        
    }
    
}
