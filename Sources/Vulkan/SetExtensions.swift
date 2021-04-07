public protocol Option : RawRepresentable, Hashable, CaseIterable { }

extension Set where Element : Option, Element.RawValue : BinaryInteger {
    internal var rawValue: Element.RawValue {
        var value = Element.RawValue(0)
        for (index, element) in Element.allCases.enumerated() where contains(element) {
            value |= 1 << index
        }
        return value
    }
}
