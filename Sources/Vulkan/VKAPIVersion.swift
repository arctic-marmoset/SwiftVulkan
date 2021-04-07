// Sadly, only literals are allowed
public enum VKAPIVersion : UInt32 {
    case onePointZero = 0x00400000
    case onePointOne = 0x00401000
    case onePointTwo = 0x00402000
}

extension VKAPIVersion : CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .onePointZero: return "v1.0.0"
        case .onePointOne: return "v1.1.0"
        case .onePointTwo: return "v1.2.0"
        }
    }
}
