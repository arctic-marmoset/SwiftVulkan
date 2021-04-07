import CVulkan
import Foundation

public class VKInstance {
    public init(createInfo info: VKInstanceCreateInfo = VKInstanceCreateInfo()) throws {
        var instance: VkInstance?

        try info.withUnsafeCPointer { pInstanceInfo in
            let result = vkCreateInstance(pInstanceInfo, nil, &instance)
            guard result == VK_SUCCESS else {
                throw VKError.from(rawValue: result)
            }
        }

        _instance = instance!
    }

    deinit {
        vkDestroyInstance(_instance, nil)
    }

    private let _instance: VkInstance
}
