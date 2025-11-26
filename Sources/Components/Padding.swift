//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

extension Style {

    public struct Padding {

        public typealias Value = Keys.Number.ValueBuilderKeyPath

        package let leading: Value?
        package let top: Value?
        package let trailing: Value?
        package let bottom: Value?

        public init(_ value: Value, edges: Edge.Set = .all) {
            self.leading = edges.contains(.leading) ? value : nil
            self.top = edges.contains(.top) ? value : nil
            self.trailing = edges.contains(.trailing) ? value : nil
            self.bottom = edges.contains(.bottom) ? value : nil
        }

        public init(horizontal: Value? = nil, vertical: Value? = nil) {
            self.leading = horizontal
            self.top = vertical
            self.trailing = horizontal
            self.bottom = vertical
        }

        public init(leading: Value? = nil, top: Value? = nil, trailing: Value? = nil, bottom: Value? = nil) {
            self.leading = leading
            self.top = top
            self.trailing = trailing
            self.bottom = bottom
        }

    }
    
}
