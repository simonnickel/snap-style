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
    
    public static let base: Self = .init(
        "base",
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

    public static let screen: Self = .init(
        "screen",
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

    
    // MARK: - Card
    
    public static let card: Self = .init(
        "card",
        container: .card,
        spacing: \.spacingElements,
    )
    
    // MARK: Content Card
    
    public static let contentCard: Self = Self.card.adjusted(
        "contentCard",
        container: .set(.contentCard),
        fonts: .set({ element in
            switch element {
                case .any: \.content
                case .title, .icon, .accessory: \.title
                case .footnote: \.footnote
                default: nil
            }
        }),
    )


    // MARK: Accessory Card

    public static let infoCard: Self = Self.contentCard.adjusted(
        "infoCard",
        container: .set(.infoCard),
    )


    // MARK: Accent Card

    public static let accentCard: Self = Self.contentCard.adjusted(
        "accentCard",
        container: .set(.accentCard),
    )


    // MARK: Metric Card

    public static let metricCard: Self = Self.card.adjusted(
        "metricCard",
        container: .set(.metricCard),
        fonts: .set({ element in
            switch element {
                case .title: \.content
                case .icon: \.title
                case .value: \.title
                default: nil
            }
        }),
    )
    
    
    // MARK: - List
    
    public static let list: Self = .init(
        "list",
        container: .screen,
        fonts: { element in
            switch element {
                case .title: \.listSectionHeader
                default: nil
            }
        },
    )
    
    public static let listRow: Self = .init(
        "listRow",
        container: .listRow,
        compositions: { element in
            switch element {
            case .icon, .accessory: \.interactiveIndicator
            default: nil
            }
        },
        fonts: { element in
            switch element {
                case .any: \.list
                case .icon: \.listIcon
                case .accessory: \.listAccessory
                default: nil
            }
        },
    )
    
    
    // MARK: - Button

    /// Used for `Style.Views.Button.Variant.primary / .secondary`.
    public static func button(_ hierarchy: Hierarchy) -> Self {
        Self("button", hierarchy: hierarchy,
            container: .button,
            fonts: { element in
               switch element {
                   case .title: \.buttonTitle
                   case .icon: \.buttonIcon
                   default: nil
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
