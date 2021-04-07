import CVulkan

public class VKApplicationInfo : VKStructure {
    public let applicationName: String
    public let applicationVersion: VKVersion
    public let engineName: String
    public let engineVersion: VKVersion
    public let apiVersion: VKAPIVersion

    public init(
        applicationName: String,
        applicationVersion: VKVersion,
        engineName: String,
        engineVersion: VKVersion,
        apiVersion: VKAPIVersion
    ) {
        self.applicationName = applicationName
        self.applicationVersion = applicationVersion
        self.engineName = engineName
        self.engineVersion = engineVersion
        self.apiVersion = apiVersion
    }

    internal typealias CType = VkApplicationInfo

    internal static let structureType = VKStructureType.applicationInfo

    internal func withUnsafeCPointer<R>(_ body: (UnsafePointer<CType>) throws -> R) rethrows -> R? {
        try applicationName.withCString { pApplicationName throws in
            try engineName.withCString { pEngineName throws in
                let cStruct = CType(
                    sType: VKApplicationInfo.structureType.cType,
                    pNext: nil,
                    pApplicationName: pApplicationName,
                    applicationVersion: applicationVersion.rawValue,
                    pEngineName: pEngineName,
                    engineVersion: engineVersion.rawValue,
                    apiVersion: apiVersion.rawValue
                )

                return try withUnsafePointer(to: cStruct) { pCStruct throws in
                    try body(pCStruct)
                }
            }
        }
    }
}

public class VKInstanceCreateInfo : VKStructure {
    public enum Flag : UInt32, Option {
        case reserved = 0
    }

    public typealias Flags = Set<Flag>
    public typealias CType = VkInstanceCreateInfo

    public let flags: Flags
    public let applicationInfo: VKApplicationInfo?
    public let enabledLayerNames: [String]
    public let enabledExtensionNames: [String]

    public init(
        flags: Flags = [],
        applicationInfo: VKApplicationInfo? = nil,
        enabledLayerNames: [String] = [],
        enabledExtensionNames: [String] = []
    ) {
        self.flags = flags
        self.applicationInfo = applicationInfo
        self.enabledLayerNames = enabledLayerNames
        self.enabledExtensionNames = enabledExtensionNames
    }

    public func withUnsafeCPointer<R>(_ body: (UnsafePointer<CType>) throws -> R) rethrows -> R? {
        let layerNames = enabledLayerNames.map { UnsafePointer(strdup($0)) }
        let extensionNames = enabledExtensionNames.map { UnsafePointer(strdup($0)) }

        defer {
            layerNames.forEach { UnsafeMutablePointer(mutating: $0)?.deallocate() }
            extensionNames.forEach { UnsafeMutablePointer(mutating: $0)?.deallocate() }
        }

        return try layerNames.withUnsafeBufferPointer { ppLayerNames throws in
            try extensionNames.withUnsafeBufferPointer { ppExtensionNames throws in
                try withOptionalUnsafePointerToCStruct(structure: applicationInfo) { pAppInfo throws in
                    let cStruct = CType(
                        sType: VKInstanceCreateInfo.structureType.cType,
                        pNext: nil,
                        flags: flags.rawValue,
                        pApplicationInfo: pAppInfo,
                        enabledLayerCount: UInt32(enabledLayerNames.count),
                        ppEnabledLayerNames: ppLayerNames.baseAddress,
                        enabledExtensionCount: UInt32(enabledExtensionNames.count),
                        ppEnabledExtensionNames: ppExtensionNames.baseAddress
                    )

                    return try withUnsafePointer(to: cStruct) { pCStruct throws in
                        try body(pCStruct)
                    }
                }
            }
        }
    }

    internal static let structureType = VKStructureType.instanceCreateInfo
}

internal enum VKStructureType {
    case applicationInfo
    case instanceCreateInfo

    public var cType: VkStructureType {
        get {
            switch self {
            case .applicationInfo: return VK_STRUCTURE_TYPE_APPLICATION_INFO
            case .instanceCreateInfo: return VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO
            }
        }
    }
}

internal protocol VKStructure {
    associatedtype CType

    static var structureType: VKStructureType { get }

    func withUnsafeCPointer<R>(_ body: (UnsafePointer<CType>) throws -> R) rethrows -> R?
}

internal func withOptionalUnsafePointerToCStruct<T : VKStructure, R>(
    structure: T?,
    _ body: (UnsafePointer<T.CType>?) throws -> R
) rethrows -> R? {
    if let structure = structure {
        return try structure.withUnsafeCPointer { pCStruct throws in
            try body(pCStruct)
        }
    } else {
        return try body(nil)
    }
}
