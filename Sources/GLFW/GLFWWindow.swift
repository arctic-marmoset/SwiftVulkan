import CGLFW

public class GLFWWindow {
    internal init(
        width: UInt,
        height: UInt,
        title: String,
        monitor: GLFWMonitor? = nil,
        share: GLFWWindow? = nil
    ) throws {
        guard width < UInt(Int.max) && height < UInt(Int.max) else {
            throw RuntimeError.illegalArgument
        }

        let width = CInt(width)
        let height = CInt(height)
        let title = title.cString(using: .utf8)
        let monitor = monitor?.cMonitor
        let share = share?.cWindow

        guard let window = glfwCreateWindow(width, height, title, monitor, share) else {
            throw GLFW.lastError
        }

        cWindow = window
    }

    deinit {
        glfwDestroyWindow(cWindow)
    }

    public func show() {
        glfwShowWindow(cWindow)
    }

    public func shouldClose() -> Bool {
        glfwWindowShouldClose(cWindow) == GLFW_TRUE
    }

    internal let cWindow: OpaquePointer
}
