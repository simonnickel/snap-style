//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.ComponentDefinition {
    
    
    // MARK: - Base
    
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
                case .any: \.anyElement
                case .container: \.anyComponent
                case .title: \.title
                case .label: \.label
                case .icon: \.icon
                case .value: \.value
                case .action: \.action
                case .separator: \.separator
            }
        },
        surfaces: { element in
            switch element {
                case .any: \.anyElement
                case .container: \.anyContainer
                case .title: \.title
                case .label: \.label
                case .icon: \.icon
                case .value: \.value
                case .action: \.action
                case .separator: \.separator
            }
        },
        shapes: { element in
            switch element {
                case .container: \.anyContainer
                default: nil
            }
        }
    )
    
    
    // MARK: - Screen
    
    public static let screen: Self = .init("screen",
       // Padding can not be defined here, because of scroll indicator placement.
        surfaces: { element in
            switch element {
                case .container: \.screen
                default: nil
            }
        }
    )
    
    
    // MARK: - Content
    
    public static let content: Self = .init("content",
        padding: { element in
            switch element {
                case .container: \.paddingContent
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title: \.title
                default: \.content
            }
        },
        surfaces: { element in
            switch element {
                case .container: \.containerContent
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
    
    
    // MARK: - List
    
    public static let list: Self = .init("list",
        fonts: { element in
            switch element {
                case .title: \.listSectionheader
                default: nil
            }
        },
        surfaces: { element in
            switch element {
                case .container: \.screen
                default: nil
            }
        }
    )
    
    
    // MARK: - Card
    
    public static let card: Self = .init("card",
        requiresAlternativeAccent: true,
        padding: { element in
            switch element {
                case .container: \.paddingCard
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title: \.title
                default: \.card
            }
        },
        surfaces: { element in
            switch element {
                case .container: \.containerCard
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
    
    public static let valueCard: Self = .init("valueCard",
        padding: { element in
            switch element {
                case .container: \.paddingCard
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title: \.title
                case .icon: \.title
                case .value: \.title
                default: \.card
            }
        },
        surfaces: { element in
            switch element {
                case .container: \.containerCard
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
    
    
    // MARK: - Action
    
    public static let action: Self = .init("action",
        padding: { element in
            switch element {
                case .container: \.paddingAction
                default: nil
            }
        },
        surfaces: { element in
            switch element {
                case .container: \.containerAction
                default: nil
            }
        },
        shapes: { element in
            switch element {
                case .container: \.containerAction
                default: nil
            }
        }
    )
    
}
