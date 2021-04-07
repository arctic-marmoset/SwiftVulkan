import GLFW
import Vulkan

class Application {
    public let name: String

    public init(name: String) {
        self.name = name
    }

    public func run() throws {
        try initWindow()
        try initVulkan()
        mainLoop()
    }

    private func initWindow() throws {
        _context = try GLFW()
        _window = try _context.createWindow(width: 1280, height: 720, title: name)
    }

    private func initVulkan() throws {
        let appInfo = VKApplicationInfo(
            applicationName: name,
            applicationVersion: VKVersion(major: 0, minor: 1, patch: 0),
            engineName: "SOCC", // Seriously Over-Complicated Creation
            engineVersion: VKVersion(major: 0, minor: 1, patch: 0),
            apiVersion: .onePointTwo
        )

        let instanceInfo = VKInstanceCreateInfo(applicationInfo: appInfo)
        _instance = try VKInstance(createInfo: instanceInfo)
    }

    private func mainLoop() {
        while (!_window.shouldClose()) {
            _context.pollEvents()
        }
    }

    private var _context: GLFW!
    private var _window: GLFWWindow!
    private var _instance: VKInstance!
}
