import CGLFW
import Foundation

public class GLFW {
    public var primaryMonitor: GLFWMonitor? {
        get {
            guard let monitor = glfwGetPrimaryMonitor() else {
                return nil
            }

            return GLFWMonitor(cMonitor: monitor)
        }
    }

    public init() throws {
        glfwSetErrorCallback(errorHandler)
        if glfwInit() != GLFW_TRUE {
            throw GLFW.lastError
        }
        glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API)
    }

    deinit {
        glfwTerminate()
    }

    public func createWindow(
        width: UInt,
        height: UInt,
        title: String,
        monitor: GLFWMonitor? = nil,
        share: GLFWWindow? = nil
    ) throws -> GLFWWindow {
        try GLFWWindow(width: width, height: height, title: title, monitor: monitor, share: share)
    }

    public func pollEvents() {
        glfwPollEvents()
    }

    // TODO: Is this really needed?
    internal static var lastError: GLFWError {
        get {
            _errorLock.lock()
            defer {
                _errorLock.unlock()
            }
            return _lastError
        }
        set {
            _errorLock.lock()
            _lastError = newValue
            _errorLock.unlock()
        }
    }

    private static let _errorLock = NSLock()
    private static var _lastError: GLFWError = GLFWError.none
}

private func errorHandler(code: CInt, message: UnsafePointer<CChar>?) {
    GLFW.lastError = GLFWError.from(cCode: code)
}
