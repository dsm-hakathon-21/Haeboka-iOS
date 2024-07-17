import Foundation
import Moya

struct UserRequest: Codable {
    let model: String
    let messages: [Message]

    struct Message: Codable {
        let role: String
        let content: String
    }
}

enum GPTAPI {
    case GPT(request: UserRequest)
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
        case let .GPT(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}
