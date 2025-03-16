//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase

extension SnapStyle.NumberKey {
    
    
    // MARK: - Screen

    public var widthReadableContent: ValueBuilder { .base(.definition(.value(750))) }
    
    
    // MARK: - Spacing

    public var spacingSections: ValueBuilder { .base(.definition(.value(32))) }
    public var spacingGroups: ValueBuilder { .base(.definition(.value(16))) }
    public var spacingElements: ValueBuilder { .base(.definition(.value(8))) }
    public var spacingLines: ValueBuilder { .base(.definition(.value(4))) }
    
    
    // MARK: - Container: Padding
    
    public var paddingAnyElement: ValueBuilder { .base(nil) }

    public var paddingAnyContainer: ValueBuilder { .base(nil) }
    public var paddingScreenVertical: ValueBuilder { .base(.definition(.value(10))) }
    public var paddingScreenHorizontal: ValueBuilder { .base(.definition(.value(10))) }
    
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
    
    public var paddingContent: ValueBuilder { .base(.reference(\.paddingComponent)) }
    public var paddingList: ValueBuilder { .base(.reference(\.paddingComponent)) }
    public var paddingCard: ValueBuilder { .base(.reference(\.paddingComponent)) }
    public var paddingAction: ValueBuilder { .base(.definition(.value(8))) }
    public var paddingActionButtonHorizontalAdditional: ValueBuilder { .base(.definition(.value(8))) }
    
    
    // MARK: - Shape: CornerRadius
    
    /// A corner radius definition based on the level in the component stack.
    public var cornerRadiusComponent: ValueBuilder {
        .builder { context in
            switch context.componentStack.levelOverall {
                case 1: .definition(.value(20))
                case 2: .definition(.value(8)) // Outer corner radius - gap // TODO: this could be calculated from references
                case 3: .definition(.value(4))
                default: nil
            }
        }
    }
    
    public var cornerRadiusContent: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }
    public var cornerRadiusList: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }
    public var cornerRadiusCard: ValueBuilder { .base(.reference(\.cornerRadiusComponent)) }
    
    
    // MARK: - Animation
    
    public var animationInteractionHighlightDuration: ValueBuilder { .base(.definition(.value(0.2))) }
    
}
