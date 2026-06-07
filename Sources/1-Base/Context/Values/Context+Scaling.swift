//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

extension Style.Context {

    public typealias ScaleFactor = Style.Attribute.Number.Value.WrappedValue

    public static let scaleFactorDefault: ScaleFactor = 1.0

    public var scaleFactor: ScaleFactor { getValue(for: Self.scaleFactor) ?? Self.scaleFactorDefault }

    public static var scaleFactor: Attribute<String, ScaleFactor> { .init(key: "ScaleFactor", valueDefault: Self.scaleFactorDefault) }
    

    // MARK: - Dynamic Type
    
    public var scaleDynamicType: ScaleFactor { getValue(for: Self.scaleDynamicType) ?? Self.scaleFactorDefault }
    
    package static var scaleDynamicType: Attribute<String, ScaleFactor> { .init(key: "ScaleDynamicType", valueDefault: Self.scaleFactorDefault) }


}
