import CGLFW

public class GLFWMonitor {
    public func getPosition() throws -> (x: Int, y: Int) {
        var x: CInt = 0
        var y: CInt = 0
        glfwGetMonitorPos(cMonitor, &x, &y)

        guard x > 0, y > 0 else {
            throw GLFW.lastError
        }

        return (Int(x), Int(y))
    }

    public func getVideoMode() throws -> GLFWVideoMode {
        guard let pMode: UnsafePointer<GLFWVideoMode> = glfwGetVideoMode(cMonitor) else {
            throw GLFW.lastError
        }

        // TODO: Is this safe?
        return pMode.pointee
    }

    public func getVideoModes() throws -> [GLFWVideoMode] {
        var cCount: CInt = 0

        guard let pModes: UnsafePointer<GLFWVideoMode> = glfwGetVideoModes(cMonitor, &cCount) else {
            throw GLFW.lastError
        }

        let buffer = UnsafeBufferPointer(start: pModes, count: Int(cCount))
        return Array(buffer)
    }


    internal init(cMonitor: OpaquePointer) {
        self.cMonitor = cMonitor
    }

    internal let cMonitor: OpaquePointer
}
