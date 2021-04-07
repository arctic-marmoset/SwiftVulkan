public struct VKVersion {
    public let major: UInt8
    public let minor: UInt8
    public let patch: UInt8

    public init(major: UInt8, minor: UInt8, patch: UInt8 = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }

    public static func from(apiVersion: VKAPIVersion) -> VKVersion {
        switch apiVersion {
        case .onePointZero: return VKVersion(major: 1, minor: 0, patch: 0)
        case .onePointOne: return VKVersion(major: 1, minor: 1, patch: 0)
        case .onePointTwo: return VKVersion(major: 1, minor: 2, patch: 0)
        }
    }

    public var rawValue: UInt32 {
        (UInt32(major) << 22) | (UInt32(minor) << 12) | UInt32(patch)
    }
}

extension VKVersion : CustomDebugStringConvertible {
    public var debugDescription: String {
        "v\(major).\(minor).\(patch)"
    }
}
