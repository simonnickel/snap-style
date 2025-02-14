//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.Component {
    
    public static let base: Self = .init("base",
        padding: { element in
            switch element {
                case .any: \.paddingAnyElement
                case .container: \.paddingAnyContainer
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .any, .container: \.anyElement
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
                case .container: \.anyContainer
                case .title: \.title
                case .label: \.label
                case .icon: \.icon
                case .value: \.value
                case .cta: \.cta
                case .separator: \.separator
            }
        },
        shapes: { element in
            switch element {
                case .container: \.containerAnyComponent
                default: nil
            }
        }
    )
    
    public static let screen: Self = .init("screen",
        padding: { element in
            nil // Padding can not be defined here, because of scroll indicator placement.
        },
        fonts: { element in
            nil
        },
        colors: { element in
            nil
        },
        surfaces: { element in
            switch element {
                case .container: \.screen
                default: nil
            }
        },
        shapes: { element in
            nil
        }
    )
    
    public static let content: Self = .init("content",
        padding: { element in
            switch element {
                case .container: \.paddingContent
                default: nil
            }
        },
        fonts: { element in
            nil
        },
        colors: { element in
            nil
        },
        surfaces: { element in
            switch element {
                case .container: \.content
                default: nil
            }
        },
        shapes: { element in
            switch element {
                case .container: \.containerContent
                default: nil
            }
        }
    )
    
    public static let card: Self = .init("card",
        padding: { element in
            switch element {
                case .container: \.paddingCard
                default: nil
            }
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
            switch element {
                case .container: \.card
                default: nil
            }
        },
        shapes: { element in
            switch element {
                case .container: \.containerCard
                default: nil
            }
        }
    )
    
}
