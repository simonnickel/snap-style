//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

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
                case .accessory: \.accessory
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
                case .accessory: \.accessory
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
        padding: { element in
            switch element {
                case .title: Padding(\.paddingScreenTitleLeading, edges: .leading)
                // Container Padding can not be defined here, because of scroll indicator placement.
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
                case .container: \.screen
                default: nil
            }
        }
    )
    
    
    // MARK: - Content Card
    
    public static let contentCard: Self = .init("contentCard",
        padding: { element in
            switch element {
                case .container: Padding(\.paddingCard)
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
                case .container: \.containerContentCard
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
    
    
    // MARK: - Accent Card
    
    public static let accentCard: Self = .init("accentCard",
        requiresSecondaryAccent: true,
        padding: { element in
            switch element {
                case .container: Padding(\.paddingCard)
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
                case .container: \.containerAccentCard
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
    
    
    // MARK: - Metric Card
    
    public static let metricCard: Self = .init("metricCard",
        requiresSecondaryAccent: true,
        padding: { element in
            switch element {
                case .container: Padding(\.paddingMetricCard)
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
                case .container: \.containerMetricCard
                default: nil
            }
        },
        shapes: { element in
            switch element {
                case .container: \.containerMetricCard
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
        padding: { element in
            switch element {
                case .container: .listRow
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
                case .container: \.listRow
                case .icon, .accessory: \.interactiveIndicator
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
    
    public static let actionIcon: Self = .init("actionIcon",
        padding: { element in
            switch element {
                case .container: Padding(\.paddingActionIcon)
                default: nil
            }
        },
        fonts: { element in
           switch element {
               default: \.actionLarge
           }
        },
        compositions: { element in
            switch element {
                case .container: \.interactiveContainer
                default: nil
            }
        },
        shapes: { element in
            switch element {
                case .container: \.containerActionIcon
                default: nil
            }
        }
    )
    
}
