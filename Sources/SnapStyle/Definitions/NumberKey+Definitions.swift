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
    public var paddingContent: ValueBuilder { .base(.definition(.value(12))) }
    public var paddingList: ValueBuilder { .base(.definition(.value(12))) }
    public var paddingCard: ValueBuilder { .base(.definition(.value(16))) }
    public var paddingAction: ValueBuilder { .base(.definition(.value(10))) }
    
    
    // MARK: - Shape: CornerRadius
    
    public var cornerRadiusContent: ValueBuilder { .base(.definition(.value(20))) }
    public var cornerRadiusList: ValueBuilder { .base(.reference(\.cornerRadiusContent)) }
    public var cornerRadiusCard: ValueBuilder { .base(.definition(.value(8))) }
    
    
    // MARK: - Animation
    
    public var animationInteractionHighlightDuration: ValueBuilder { .base(.definition(.value(0.2))) }
    
}
