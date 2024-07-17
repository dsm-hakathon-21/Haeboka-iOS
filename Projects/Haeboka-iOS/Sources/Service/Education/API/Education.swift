import Foundation

import Moya

import Core

public struct WordElement: Codable {
    let eng: String
    let kor: String
}

public enum EducationAPI {
    case wordBookAll
    case wordBookDetail(id: UUID)
    case addWordBook(keyword: String, words: [WordElement])
    case quiz(id: UUID)
    case translation(input: String, source: String, target: String)
}

extension EducationAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "http://3.39.152.98:8080")!
    }
    
    public var path: String {
        switch self {
        case .wordBookAll:
            return "/api/wordbook"
        case .wordBookDetail(id: let id):
            return "/api/wordbook/\(id)"
        case .addWordBook:
            return "/api/wordbook"
        case .quiz(id: let id):
            return "/api/quiz/\(id)"
        case .translation:
            return "/api/translate"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .addWordBook, .translation:
            return .post
        default:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .addWordBook(keyword, words):
            return .requestParameters(
                parameters: [
                    "keyword": keyword,
                    "words": [
                        "eng": words.map { $0.eng },
                        "kor": words.map { $0.kor }
                    ]
                ], encoding: JSONEncoding.default)
        case let .translation(input, source, target):
            return .requestParameters(
                parameters: [
                    "q": input,
                    "source": source,
                    "target": target
                ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}

