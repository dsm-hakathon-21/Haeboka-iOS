import Foundation
import Moya

import Core

struct Message: Codable {
    let role: String
    let content: String
}

enum GPTAPI {
    case GPT(model: String, message: Message)
}

extension GPTAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openai.com/v1/chat/completions")!
    }
    
    var path: String {
        return "/api"
    }
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case let .GPT(model, message):
            return .requestParameters(
                parameters: [
                    "model": model,
                    "messages": [
                        "role": message.role,
                        "content": message.content
                    ]
                ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
    }

}
