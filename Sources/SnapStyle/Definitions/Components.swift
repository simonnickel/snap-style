//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

// ComponentDefinition is used to:
// - assign KeyPaths to elements

extension SnapStyle.ComponentDefinition {
    
    
    // MARK: - Base
    
    public static let base: Self = .init("base",
        padding: { element in
            switch element {
                case .any: Padding(\.paddingAnyElement)
                case .container: Padding(\.paddingAnyContainer)
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
        compositions: { element in
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
        fonts: { element in
            switch element {
                case .title: \.screenTitle
                default: nil
            }
        },
        compositions: { element in
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
                case .container: Padding(\.paddingContent)
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title: \.title
                default: \.content
            }
        },
        compositions: { element in
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
                case .title: \.listSectionHeader
                default: nil
            }
        },
        compositions: { element in
            switch element {
                case .container: \.screen
                default: nil
            }
        }
    )
    
    public static let listRow: Self = .init("listRow",
        compositions: { element in
            switch element {
                case .container: \.listRow
                case .icon: \.interactiveIndicator
                default: nil
            }
        }
    )
    
    
    // MARK: - Card
    
    public static let card: Self = .init("card",
        requiresAlternativeAccent: true,
        padding: { element in
            switch element {
                case .container: Padding(\.paddingCard)
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title: \.title
                default: \.card
            }
        },
        compositions: { element in
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
                case .container: Padding(\.paddingCard)
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
        compositions: { element in
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
                case .container: Padding(horizontal: \.paddingActionHorizontal, vertical: \.paddingActionVertical)
                default: nil
            }
        },
        fonts: { element in
           switch element {
               case .action: \.action
               default: \.action
           }
        },
        compositions: { element in
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
