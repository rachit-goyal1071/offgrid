enum MockError: Error {
    case networkFailure
    case invalidData
    case unauthorized(statusCode: Int)
    case unknown
}
