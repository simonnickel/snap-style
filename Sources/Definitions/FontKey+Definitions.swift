//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Keys.Font {


    // MARK: - Component

    public var anyComponent: ValueBuilder { .base(nil) }

    public var content: ValueBuilder { .base(.definition(.with(size: 16, weight: .regular))) }
    public var card: ValueBuilder { .base(.definition(.with(size: 18, weight: .regular))) }
    public var textBlock: ValueBuilder { .base(.reference(\.content)) }

    /// Requires `Style.configuration.styleAllowNavigationBarTitleAdjustments` to be enabled.
    /// (see ``StyleNavigationBarModifier``)
    public var navigationTitleInline: ValueBuilder {
        .base(.definition(.with(size: 17, weight: .semibold))) // iOS 26 - size: 17, weight: .semibold
    }
    
    /// Requires `Style.configuration.styleAllowNavigationBarTitleAdjustments` to be enabled.
    /// (see ``StyleNavigationBarModifier``)
    public var navigationTitleLarge: ValueBuilder {
        .base(.definition(.with(size: 34, weight: .bold))) // iOS 26 - size: 34, weight: .bold
    }
    
    public var screenTitle: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 28, weight: .bold))
                case .secondary: .definition(.with(size: 24, weight: .bold))
                case .tertiary: .definition(.with(size: 20, weight: .bold))
            }
        }
    }
    
    public var buttonTitle: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 17, weight: .semibold))
                case .secondary: .definition(.with(size: 13, weight: .medium))
                case .tertiary: .definition(.with(size: 12, weight: .medium))
            }
        }
    }
    
    public var buttonIcon: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 17, weight: .semibold))
                case .secondary: .definition(.with(size: 13, weight: .medium))
                case .tertiary: .definition(.with(size: 12, weight: .medium))
            }
        }
    }
    
    public var buttonIconOnly: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 22, weight: .medium))
                case .secondary: .definition(.with(size: 18, weight: .medium))
                case .tertiary: .definition(.with(size: 14, weight: .medium))
            }
        }
    }


    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

    public var title: ValueBuilder {
        .builder { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 18, weight: .bold))
                case .secondary: .definition(.with(size: 16, weight: .medium))
                case .tertiary: .definition(.with(size: 14, weight: .medium))
            }
        }
    }

    public var label: ValueBuilder { .base(nil) }

    public var icon: ValueBuilder { .base(.reference(\.title)) }

    public var accessory: ValueBuilder { .base(.reference(\.icon)) }

    public var value: ValueBuilder { .base(nil) }

    public var separator: ValueBuilder { .base(nil) }
    
    public var footnote: ValueBuilder { .base(.definition(.with(size: 14, weight: .regular))) }


    // MARK: - List
    
    public var list: ValueBuilder {
        .base(.definition(.with(size: 17, weight: .regular))) { context in
            return switch context.element.type {
                case .title: .definition(.with(size: 17, weight: .medium))
                case .value: .definition(.with(size: 17, weight: .medium))
                default: nil
            }
        }
    }

    public var listSectionHeader: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 16, weight: .bold))
                case .secondary: .definition(.with(size: 17, weight: .semibold))
                case .tertiary: .definition(.with(size: 15, weight: .regular))
            }
        }
    }

    public var listIcon: ValueBuilder { .base(.definition(.with(size: 20, weight: .regular))) }
    
    public var listAccessory: ValueBuilder { .base(.definition(.with(size: 20, weight: .semibold))) }
    public var listAccessoryNavigation: ValueBuilder { .base(.definition(.with(size: 14, weight: .semibold))) }

}
