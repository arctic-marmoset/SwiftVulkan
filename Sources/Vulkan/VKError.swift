import CVulkan

public enum VKError : Error {
    case unknown
    case initializationFailed

    internal static func from(rawValue: VkResult) -> VKError {
        switch rawValue {
        case VK_ERROR_INITIALIZATION_FAILED: return .initializationFailed
        default: return .unknown
        }
    }
}
