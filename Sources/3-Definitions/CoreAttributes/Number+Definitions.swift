//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Attribute.Number {

    public var zero: ValueBuilder { .base(.value(.scaled(0))) }


    // MARK: - Screen

    public var widthReadableContent: ValueBuilder { .base(.value(.scaled(750))) }


    // MARK: - Spacing

    public var spacingSections: ValueBuilder { .base(.value(.scaled(32))) }
    public var spacingGroups: ValueBuilder { .base(.value(.scaled(16))) }
    public var spacingElements: ValueBuilder { .base(.value(.scaled(8))) }
    public var spacingLines: ValueBuilder { .base(.value(.scaled(4))) }

    public var spacingLabel: ValueBuilder { .base(.value(.scaled(8))) } // System default is 8 (iOS 18)


    // MARK: - Container: Padding

    public var paddingScreenTop: ValueBuilder { .base(.value(.scaled(10))) }
    public var paddingScreenBottom: ValueBuilder { .base(.value(.scaled(10))) }
    public var paddingScreenHorizontal: ValueBuilder { .base(.value(.scaled(10))) }

    /// The leading padding to inset a title to fit the screen title.
    public var paddingScreenTitleLeading: ValueBuilder { .base(.value(.scaled(8))) }

    public var paddingAnyElement: ValueBuilder { .base(nil) }
    public var paddingAnyContainer: ValueBuilder { .base(nil) }

    /// A padding definition based on the level in the container stack.
    public var paddingContainer: ValueBuilder {
        .builder { context in
            switch context.containerStack.levelOverall {
                case 2: .value(.scaled(10))
                case 3: .value(.scaled(8))
                default: .value(.scaled(12)) // also used for case 1 and -1 (empty)
            }
        }
    }

    public var paddingCard: ValueBuilder { .base(.reference(\.paddingContainer)) }
    public var paddingMetricCard: ValueBuilder { .base(.reference(\.paddingContainer)) }
    public var paddingActionHorizontal: ValueBuilder { .base(.value(.scaled(15))) }
    public var paddingActionVertical: ValueBuilder { .base(.value(.scaled(8))) }
    public var paddingActionIconOnly: ValueBuilder {
        .builder { context in
            switch context.component.hierarchy {
                case .secondary: .value(.scaled(14))
                case .tertiary: .value(.scaled(10))
                default: .value(.scaled(18)) // also used for .primary
            }
        }
    }

    public var paddingListBottom: ValueBuilder { .base(.reference(\.paddingScreenBottom)) }
    public var paddingListSectionFirst: ValueBuilder { .base(.value(.scaled(10))) }
    public var paddingListSection: ValueBuilder { .base(.value(.scaled(28))) }
    public var paddingListHeaderBottom: ValueBuilder { .base(.value(.scaled(10))) }
    public var paddingListFooterTop: ValueBuilder { .base(.value(.scaled(5))) }
    public var paddingListRowTop: ValueBuilder { .base(.value(.scaled(16))) }
    public var paddingListRowBottom: ValueBuilder { .base(.reference(\.paddingListRowTop)) }
    public var paddingListRowLeading: ValueBuilder { .base(.value(.scaled(18))) }
    public var paddingListRowTrailing: ValueBuilder { .base(.reference(\.paddingListRowTop)) }
    
    
    // MARK: - Shape
    
    public var strokeSelected: ValueBuilder { .base(.value(.scaled(2))) }


    // MARK: - Shape: CornerRadius

    /// A corner radius definition based on the level in the component stack.
    public var cornerRadiusComponent: ValueBuilder { .base(.reference(\.cornerRadiusLarge)) }

    public var cornerRadiusCard: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }
    public var cornerRadiusMetricCard: ValueBuilder { .base(.reference(\.cornerRadiusSmall)) }
    public var cornerRadiusList: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }
    
    public var cornerRadiusSmallest: ValueBuilder { .base(.value(.scaled(5))) }
    public var cornerRadiusSmall: ValueBuilder { .base(.value(.scaled(10))) }
    public var cornerRadiusMedium: ValueBuilder { .base(.value(.scaled(15))) }
    public var cornerRadiusLarge: ValueBuilder { .base(.value(.scaled(20))) }
    public var cornerRadiusLargest: ValueBuilder { .base(.value(.scaled(30))) }


    // MARK: - Animation

    public var animationInteractionHighlightDuration: ValueBuilder { .base(.value(.scaled(0.5))) }
    
    
    // MARK: - Others
    
    public var fontSizeNavigationTitleMax: ValueBuilder { .base(.value(.scaled(60))) }

}
