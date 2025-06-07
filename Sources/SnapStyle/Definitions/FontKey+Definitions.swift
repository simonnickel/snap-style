//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.FontKey {


    // MARK: - Component

    public var anyComponent: ValueBuilder { .base(nil) }

    public var content: ValueBuilder { .base(.definition(.font(.system(size: 16)))) }
    public var card: ValueBuilder { .base(.definition(.font(.system(size: 18)))) }

    public var screenTitle: ValueBuilder {
        .base(.definition(.font(.title))) { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 32, weight: .bold))
                case .secondary: .definition(.with(size: 26, weight: .bold))
                case .tertiary: .definition(.with(size: 20, weight: .bold))
            }
        }
    }


    // MARK: - Element

    public var anyElement: ValueBuilder { .base(nil) }

    public var title: ValueBuilder {
        .base(.definition(.font(.title))) { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 16, weight: .bold))
                case .secondary: .definition(.with(size: 14, weight: .medium))
                case .tertiary: .definition(.with(size: 12, weight: .medium))
            }
        }
    }

    public var label: ValueBuilder { .base(nil) }

    public var icon: ValueBuilder { .base(nil) } // TODO: Could be an adjustment to content (content + 2 ?)

    public var accessory: ValueBuilder { .base(.reference(\.icon)) }

    public var value: ValueBuilder { .base(nil) }

    public var action: ValueBuilder {
        .base(.definition(.font(.title))) { context in
            return switch context.element.hierarchy {
                case .any, .primary: .definition(.with(size: 16, weight: .medium))
                case .secondary: .definition(.with(size: 14, weight: .medium))
                case .tertiary: .definition(.with(size: 12, weight: .medium))
            }
        }
    }

    public var separator: ValueBuilder { .base(nil) }


    // MARK: - List

    public var listSectionHeader: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .any, .primary: .definition(.font(.system(size: 15, weight: .bold)))
                case .secondary: .definition(.font(.system(size: 15, weight: .medium)))
                case .tertiary: .definition(.font(.system(size: 15, weight: .regular)))
            }
        }
    }

    public var listIcon: ValueBuilder { .base(.definition(.font(.system(size: 20)))) }

}
