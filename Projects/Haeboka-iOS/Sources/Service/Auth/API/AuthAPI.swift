//import Foundation
//
//import Moya
//
//import Core
//
//public enum AuthAPI {
//    case sendMail(target: String)
//    case mailCheck(target: String, code: String)
//    case signup(nickName: String, password: String, email: String)
//    case login(nickName: String, password: String)
//}
//
//extension AuthAPI: TargetType {
//    public var baseURL: URL {
//        return URL(string: "fjkdsl")!
//    }
//    
//    public var path: String {
//        switch self {
//        case .sendMail:
//            return "api/mail/send"
//        case .mailCheck:
//            return "api/mail/verify"
//        case .signup:
//            return "/api/auth/register"
//        case .login:
//            return "/api/auth/login"
//        }
//    }
//    
//    public var method: Moya.Method {
//        return .post
//    }
//    
//    public var task: Moya.Task {
//        switch self {
//        case let .sendMail(target):
//            return .requestParameters(
//                parameters: [
//                    "target": target
//                ],
//                encoding: URLEncoding.queryString
//            )
//        case let .mailCheck(target, code):
//            return .requestParameters(
//                parameters: [
//                    "target": target,
//                    "code": code
//                ], encoding: URLEncoding.queryString
//            )
//        case let .signup(nickName, password, email):
//            return .requestParameters(
//                parameters: [
//                        "nickname": nickName,
//                        "password": password,
//                        "email": email
//                ],
//                encoding: JSONEncoding.default
//            )
//            case let .login(nickName, password):
//                return .requestParameters(
//                    parameters: [
//                        "nickname": nickName,
//                        "password": password
//                    ],
//                    encoding: JSONEncoding.default
//                )
//        default:
//            return .requestPlain
//        }
//    }
//    
//    public var headers: [String : String]? {
//        return nil
//    }
//    
//}
