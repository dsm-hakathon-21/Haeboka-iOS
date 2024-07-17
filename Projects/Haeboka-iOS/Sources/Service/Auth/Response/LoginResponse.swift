import Foundation

struct LoginResponse: Codable {
    let tokenResponse: LoginElement
    let message: String
}

struct LoginElement: Codable {
    let accessToken: String
    let refreshToken: String
}
