import Foundation

public enum GLFWError : Error, LocalizedError {
    case none
    case unknown
    case notInitialized
    case noCurrentContext
    case invalidEnum
    case invalidValue
    case outOfMemory
    case apiUnavailable
    case versionUnavailable
    case platformSpecific
    case formatUnavailable
    case noWindowContext

    internal static func from(cCode: CInt) -> GLFWError {
        switch cCode {
        case 0x00000000: return .none
        case 0x00010001: return .notInitialized
        case 0x00010002: return .noCurrentContext
        case 0x00010003: return .invalidEnum
        case 0x00010004: return .invalidValue
        case 0x00010005: return .outOfMemory
        case 0x00010006: return .apiUnavailable
        case 0x00010007: return .versionUnavailable
        case 0x00010008: return .platformSpecific
        case 0x00010009: return .formatUnavailable
        case 0x0001000A: return .noWindowContext
        default: return .unknown
        }
    }

    public var errorDescription: String? {
        switch self {
        case .none:
            return "No error has occurred."

        case .unknown:
            return "An unknown error has occurred."

        case .notInitialized:
            return "A GLFW function was called that must not be called unless the library is initialized."

        case .noCurrentContext:
            return """
                   A GLFW function was called that needs and operates on the current OpenGL or OpenGL ES context but \
                   no context is current on the calling thread.
                   """

        case .invalidEnum:
            return "A GLFW function was called with an invalid enum value."

        case .invalidValue:
            return "A GLFW function was called with an invalid value for a given enum."

        case .outOfMemory:
            return "A memory allocation failed."

        case .apiUnavailable:
            return "GLFW could not find support for the requested API on the system."

        case .versionUnavailable:
            return """
                   The requested OpenGL or OpenGL ES version (including any requested context or framebuffer hints) is \
                   not available on this machine.
                   """

        case .platformSpecific:
            return "A platform-specific error occurred that does not match any of the more specific categories."

        case .formatUnavailable:
            return """
                   If emitted during window creation, the requested pixel format is not supported.
                   If emitted when querying the clipboard, the contents of the clipboard could not be converted to the \
                   requested format.
                   """

        case .noWindowContext:
            return """
                   A window that does not have an OpenGL or OpenGL ES context 
                   was passed to a function that requires it to have one.
                   """
        }
    }
}
