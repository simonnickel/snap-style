//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// ComponentDefinition is used to:
// - assign KeyPaths to elements

extension Style.ComponentDefinition {
    
    
    // MARK: - Base
    
    public static let base: Self = .init("base",
        padding: { element in
            switch element {
                case .any: Padding(\.paddingAnyElement)
                default: nil
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
        container: .base,
    )
    
    
    // MARK: - Screen
    
    public static let screen: Self = .init("screen",
        padding: { element in
            switch element {
                case .title: Padding(\.paddingScreenTitleLeading, edges: .leading)
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title: \.screenTitle
                default: nil
            }
        },
        compositions: { element in
            switch element {
                default: nil
            }
        },
        container: .screen,
    )
    
    
    // MARK: - Content Card
    
    public static let contentCard: Self = .init("contentCard",
        padding: { element in
            switch element {
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title, .icon, .accessory: \.title
                default: \.content
            }
        },
        compositions: { element in
            switch element {
                default: nil
            }
        },
        container: .contentCard,
    )
    
    
    // MARK: - Accent Card
    
    public static let accentCard: Self = .init("accentCard",
        requiresSecondaryAccent: true,
        padding: { element in
            switch element {
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title, .icon, .accessory: \.title
                default: \.content
            }
        },
        compositions: { element in
            switch element {
                default: nil
            }
        },
        container: .accentCard,
    )
    
    
    // MARK: - Metric Card
    
    public static let metricCard: Self = .init("metricCard",
        requiresSecondaryAccent: true,
        padding: { element in
            switch element {
                default: nil
            }
        },
        fonts: { element in
            switch element {
                case .title: \.content
                case .icon: \.title
                case .value: \.title
                default: \.card
            }
        },
        compositions: { element in
            switch element {
                default: nil
            }
        },
        container: .metricCard,
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
                default: nil
            }
        },
        container: .list,
    )
    
    public static let listRow: Self = .init("listRow",
        padding: { element in
            switch element {
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
        compositions: { element in
            switch element {
                case .icon, .accessory: \.interactiveIndicator
                default: nil
            }
        },
        container: .listRow,
    )
    
    
    // MARK: - Button
    
    public static let button: Self = .init("button",
        padding: { element in
            switch element {
                default: nil
            }
        },
        fonts: { element in
           switch element {
               case .icon: \.buttonIcon
               default: \.buttonTitle
           }
        },
        compositions: { element in
            switch element {
                default: nil
            }
        },
        container: .button,
    )
    
    public static let buttonIconOnly: Self = .init("buttonIconOnly",
        padding: { element in
            switch element {
                default: nil
            }
        },
        fonts: { element in
           switch element {
               default: \.buttonIconOnly
           }
        },
        compositions: { element in
            switch element {
                default: nil
            }
        },
        container: .buttonIconOnly,
    )
    
}
