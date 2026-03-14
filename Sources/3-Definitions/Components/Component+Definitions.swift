//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// Style.Component is used to:
// - assign KeyPaths to elements

extension Style.Component {
    
    
    // MARK: - Base
    
    public static let base: Self = .init("base",
        container: .base,
        compositions: { element in
            switch element {
            case .any: \.anyElement
            case .title: \.title
            case .label: \.label
            case .icon: \.icon
            case .accessory: \.accessory
            case .value: \.value
            case .separator: \.separator
            case .footnote: \.footnote
            }
        },
        fonts: { element in
            switch element {
                case .any: \.anyElement
                case .title: \.title
                case .label: \.label
                case .icon: \.icon
                case .accessory: \.accessory
                case .value: \.value
                case .separator: \.separator
                case .footnote: \.footnote
            }
        },
        paddings: { element in
            switch element {
            case .any: \.anyElement
            default: nil
            }
        },
    )
    
    
    // MARK: - Screen

    public static let screen: Self = .init("screen",
        container: .screen,
        fonts: { element in
            switch element {
                case .title: \.screenTitle
                default: nil
            }
        },
        paddings: { element in
            switch element {
                case .title: \.screenTitleLeading
                default: nil
            }
        },
    )

    
    // MARK: - Content Card
    
    public static let contentCard: Self = .init("contentCard",
        container: .contentCard,
        fonts: { element in
            switch element {
                case .title, .icon, .accessory: \.title
                default: \.content
            }
        },
    )
    
    
    // MARK: - Accent Card
    
    public static let accentCard: Self = .init("accentCard",
        container: .accentCard,
        fonts: { element in
            switch element {
                case .title, .icon, .accessory: \.title
                default: \.content
            }
        },
    )
    
    
    // MARK: - Metric Card
    
    public static let metricCard: Self = .init("metricCard",
        container: .metricCard,
        fonts: { element in
            switch element {
                case .title: \.content
                case .icon: \.title
                case .value: \.title
                default: \.card
            }
        },
    )
    
    
    // MARK: - List
    
    public static let list: Self = .init("list",
        container: .screen,
        fonts: { element in
            switch element {
                case .title: \.listSectionHeader
                default: nil
            }
        },
    )
    
    public static let listRow: Self = .init("listRow",
        container: .listRow,
        compositions: { element in
            switch element {
            case .icon, .accessory: \.interactiveIndicator
            default: nil
            }
        },
        fonts: { element in
            switch element {
                case .icon: \.listIcon
                case .accessory: \.listAccessory
                default: \.list
            }
        },
    )
    
    
    // MARK: - Button

    public static func button(_ hierarchy: Hierarchy) -> Self {
        Self("button", hierarchy: hierarchy,
            container: .button,
            fonts: { element in
               switch element {
                   case .icon: \.buttonIcon
                   default: \.buttonTitle
               }
            },
        )
    }
    
    public static func buttonIconOnly(_ hierarchy: Hierarchy = .primary) -> Self {
        Self("buttonIconOnly", hierarchy: hierarchy,
            container: .buttonIconOnly,
            fonts: { element in
               switch element {
                   case .icon: \.buttonIconOnly
                   default: nil

               }
            },
        )
    }
    
}
