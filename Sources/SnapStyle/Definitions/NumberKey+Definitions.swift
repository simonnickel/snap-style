//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.NumberKey {

    public var zero: ValueBuilder { .base(.definition(.value(0))) }


    // MARK: - Screen

    public var widthReadableContent: ValueBuilder { .base(.definition(.value(750))) }


    // MARK: - Spacing

    public var spacingSections: ValueBuilder { .base(.definition(.value(32))) }
    public var spacingGroups: ValueBuilder { .base(.definition(.value(16))) }
    public var spacingElements: ValueBuilder { .base(.definition(.value(8))) }
    public var spacingLines: ValueBuilder { .base(.definition(.value(4))) }

    public var spacingLabel: ValueBuilder { .base(.definition(.value(8))) } // System default is 8 (iOS 18)

    public var spacingListRowTop: ValueBuilder { .base(.definition(.value(12))) }
    public var spacingListRowBottom: ValueBuilder { .base(.reference(\.spacingListRowTop)) }
    public var spacingListRowLeading: ValueBuilder { .base(.definition(.value(20))) }
    public var spacingListRowTrailing: ValueBuilder { .base(.reference(\.spacingListRowTop)) }


    // MARK: - Container: Padding

    public var paddingAnyElement: ValueBuilder { .base(nil) }
    public var paddingAnyContainer: ValueBuilder { .base(nil) }

    /// A padding definition based on the level in the component stack.
    public var paddingComponent: ValueBuilder {
        .builder { context in
            switch context.componentStack.levelOverall {
                case 1: .definition(.value(12))
                case 2: .definition(.value(10))
                case 3: .definition(.value(8))
                default: nil
            }
        }
    }

    public var paddingCard: ValueBuilder { .base(.reference(\.paddingComponent)) }
    public var paddingValueCard: ValueBuilder { .base(.reference(\.paddingComponent)) }
    public var paddingList: ValueBuilder { .base(.reference(\.paddingComponent)) }
    public var paddingActionHorizontal: ValueBuilder { .base(.definition(.value(18))) }
    public var paddingActionVertical: ValueBuilder { .base(.definition(.value(8))) }
    public var paddingActionIcon: ValueBuilder {
        .builder { context in
            switch context.element.hierarchy {
                case .primary: .definition(.value(18))
                case .secondary: .definition(.value(14))
                case .tertiary: .definition(.value(10))
                default: nil
            }
        }
    }

    public var insetScreenVertical: ValueBuilder { .base(.definition(.value(10))) }
    public var insetScreenHorizontal: ValueBuilder { .base(.definition(.value(10))) }


    // MARK: - Shape: CornerRadius

    /// A corner radius definition based on the level in the component stack.
    public var cornerRadiusComponent: ValueBuilder {
        .builder { context in
            switch context.componentStack.levelOverall {
                case 1: .definition(.value(20))
                case 2: .definition(.value(8)) // Outer corner radius - gap
                case 3: .definition(.value(4))
                default: nil
            }
        }
    }

    public var cornerRadiusCard: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }
    public var cornerRadiusList: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }


    // MARK: - Animation

    public var animationInteractionHighlightDuration: ValueBuilder { .base(.definition(.value(0.3))) }

}
