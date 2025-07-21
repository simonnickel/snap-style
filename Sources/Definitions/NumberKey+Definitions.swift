//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

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


    // MARK: - Container: Padding

    public var paddingScreenTop: ValueBuilder { .base(.definition(.value(10))) }
    public var paddingScreenBottom: ValueBuilder { .base(.definition(.value(10))) }
    public var paddingScreenHorizontal: ValueBuilder { .base(.definition(.value(10))) }

    /// The leading padding to inset a title to fit the screen title.
    public var paddingScreenTitleLeading: ValueBuilder { .base(.definition(.value(8))) }

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
    public var paddingMetricCard: ValueBuilder { .base(.reference(\.paddingComponent)) }
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

    public var paddingListBottom: ValueBuilder { .base(.reference(\.paddingScreenBottom)) }
    public var paddingListSectionFirst: ValueBuilder { .base(.definition(.value(10))) }
    public var paddingListSection: ValueBuilder { .base(.definition(.value(28))) }
    public var paddingListHeaderBottom: ValueBuilder { .base(.definition(.value(10))) }
    public var paddingListRowTop: ValueBuilder { .base(.definition(.value(16))) }
    public var paddingListRowBottom: ValueBuilder { .base(.reference(\.paddingListRowTop)) }
    public var paddingListRowLeading: ValueBuilder { .base(.definition(.value(18))) }
    public var paddingListRowTrailing: ValueBuilder { .base(.reference(\.paddingListRowTop)) }


    // MARK: - Shape: CornerRadius

    /// A corner radius definition based on the level in the component stack.
    public var cornerRadiusComponent: ValueBuilder { .base(.definition(.value(30))) }

    public var cornerRadiusCard: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }
    public var cornerRadiusMetricCard: ValueBuilder { .base(.definition(.value(15))) }
    public var cornerRadiusList: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }


    // MARK: - Animation

    public var animationInteractionHighlightDuration: ValueBuilder { .base(.definition(.value(0.3))) }
    
    
    // MARK: - Others
    
    public var fontSizeNavigationTitleMax: ValueBuilder { .base(.definition(.value(60))) }

}
