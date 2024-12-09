//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

extension SnapStyle.SurfaceKey {

    public enum Layer {
        case any
        case foreground
        case background
    }

    public enum Value {

        public struct ForLayer {
            
            let values: [Layer: AnyShapeStyle]

            public func surface(for layer: Layer) -> AnyShapeStyle? {
                values[layer] ?? values[.any]
            }

            public init(_ values: [Layer: AnyShapeStyle]) {
                self.values = values
            }

            public init<Foreground: ShapeStyle, Background: ShapeStyle>(foreground: Foreground, background: Background) {
                values = [.foreground: AnyShapeStyle(foreground), .background: AnyShapeStyle(background)]
            }

            public init(_ color: Color) {
                values = [.any: AnyShapeStyle(color)]
            }

            public init(foreground: Color) {
                values = [.foreground: AnyShapeStyle(foreground)]
            }

            public init(background: Color) {
                values = [.background: AnyShapeStyle(background)]
            }

        }

        case surface(ForLayer)
        case reference(SnapStyle.SurfaceKey)
        case erase

        var wrappedValue: ForLayer {
            switch self {
                case .surface(let forLayer): forLayer
                case .reference, .erase:
                    fatalError("A `.reference` SurfaceValue should never be used to generate a value.")
            }
        }

    }
    
}
