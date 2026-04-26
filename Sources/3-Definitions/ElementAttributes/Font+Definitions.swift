//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Attribute.Font {


    // MARK: - Component

    public var anyComponent: ValueBuilder { .base(nil) }

    public var content: ValueBuilder { .base(.value(.with(size: 16, weight: .regular))) }
    public var card: ValueBuilder { .base(.value(.with(size: 18, weight: .regular))) }
    public var textBlock: ValueBuilder { .base(.reference(\.content)) }

    /// Requires `Style.configuration.allowNavigationBarTitleAdjustments` to be enabled.
    /// (see ``StyleNavigationBarModifier``)
    public var navigationTitleInline: ValueBuilder {
        .base(.value(.with(size: 17, weight: .semibold))) // iOS 26 - size: 17, weight: .semibold
    }
    
    /// Requires `Style.configuration.allowNavigationBarTitleAdjustments` to be enabled.
    /// (see ``StyleNavigationBarModifier``)
    public var navigationTitleLarge: ValueBuilder {
        .base(.value(.with(size: 34, weight: .bold))) // iOS 26 - size: 34, weight: .bold
    }
    
    public var screenTitle: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .value(.with(size: 28, weight: .bold))
                case .secondary: .value(.with(size: 24, weight: .bold))
                case .tertiary: .value(.with(size: 20, weight: .bold))
            }
        }
    }
    
    public var buttonTitle: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .value(.with(size: 17, weight: .semibold))
                case .secondary: .value(.with(size: 13, weight: .medium))
                case .tertiary: .value(.with(size: 12, weight: .medium))
            }
        }
    }
    
    public var buttonIcon: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .value(.with(size: 17, weight: .semibold))
                case .secondary: .value(.with(size: 13, weight: .medium))
                case .tertiary: .value(.with(size: 12, weight: .medium))
            }
        }
    }
    
    public var buttonIconOnly: ValueBuilder {
        .builder { context in
            return switch context.component.hierarchy {
                case .any, .primary: .value(.with(size: 22, weight: .medium))
                case .secondary: .value(.with(size: 18, weight: .medium))
                case .tertiary: .value(.with(size: 14, weight: .medium))
            }
        }
    }


    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

    public var title: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .value(.with(size: 22, weight: .bold))
                case .secondary: .value(.with(size: 18, weight: .semibold))
                case .tertiary: .value(.with(size: 16, weight: .medium))
            }
        }
    }

    public var label: ValueBuilder { .base(nil) }

    public var icon: ValueBuilder { .base(.reference(\.title)) }

    public var accessory: ValueBuilder { .base(.reference(\.icon)) }

    public var value: ValueBuilder { .base(nil) }

    public var separator: ValueBuilder { .base(nil) }
    
    public var footnote: ValueBuilder { .base(.value(.with(size: 14, weight: .regular))) }


    // MARK: - List
    
    public var list: ValueBuilder {
        .base(.value(.with(size: 17, weight: .regular))) { context in
            return switch context.element.type {
                case .title: .value(.with(size: 17, weight: .medium))
                case .value: .value(.with(size: 17, weight: .medium))
                default: nil
            }
        }
    }

    public var listSectionHeader: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .any, .primary: .value(.with(size: 16, weight: .bold))
                case .secondary: .value(.with(size: 17, weight: .semibold))
                case .tertiary: .value(.with(size: 15, weight: .regular))
            }
        }
    }

    public var listIcon: ValueBuilder { .base(.value(.with(size: 20, weight: .regular))) }
    
    public var listAccessory: ValueBuilder { .base(.value(.with(size: 20, weight: .semibold))) }
    public var listAccessoryNavigation: ValueBuilder { .base(.value(.with(size: 14, weight: .semibold))) }

}
