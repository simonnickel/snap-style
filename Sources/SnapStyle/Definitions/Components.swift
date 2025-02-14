//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.Component {
    
    public static let base: Self = .init("base",
        numbers: { element in
            nil
        },
        fonts: { element in
            switch element {
                case .any: \.anyElement
                case .title: \.title
                case .label: \.label
                case .icon: \.icon
                case .value: \.value
                case .cta: \.cta
                case .separator: \.separator
            }
        },
        colors: { element in
            nil
        },
        surfaces: { element in
            switch element {
                case .any: \.anyElement
                case .title: \.title
                case .label: \.label
                case .icon: \.icon
                case .value: \.value
                case .cta: \.cta
                case .separator: \.separator
            }
        },
        shapes: { element in
            nil
        }
    )
    
    public static let card: Self = .init("card",
        numbers: { element in
            nil
        },
        fonts: { element in
            switch element {
                case .title: \.label
                default: nil
            }
        },
        colors: { element in
            nil
        },
        surfaces: { element in
            nil
        },
        shapes: { element in
            nil
        }
    )
    
}
