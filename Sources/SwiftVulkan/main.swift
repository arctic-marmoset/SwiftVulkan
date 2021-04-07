import Foundation
import GLFW

let app = Application(name: "Swift Vulkan")

do {
    try app.run()
} catch let error {
    print(error.localizedDescription)
    exit(1)
}
