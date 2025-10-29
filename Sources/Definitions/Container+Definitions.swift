//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

// ComponentDefinition is used to:
// - assign KeyPaths to elements

extension Style.ContainerDefinition {
    
    // MARK: - Base
    
    public static let base: Self = .init("base",
        padding: Padding(\.paddingAnyContainer),
        compositions: \.anyContainer,
        shapes: \.anyContainer,
    )
    
    
    // MARK: - Content Card
    
    public static let contentCard: Self = .init("contentCard",
        padding: Padding(\.paddingCard),
        compositions: \.containerContentCard,
        shapes: \.containerCard,
    )
    
    
    // MARK: - Accent Card
    
    public static let accentCard: Self = .init("accentCard",
        requiresSecondaryAccent: true,
        padding: Padding(\.paddingCard),
        compositions: \.containerAccentCard,
        shapes: \.containerCard,
    )
    
    
    // MARK: - Metric Card
    
    public static let metricCard: Self = .init("metricCard",
        requiresSecondaryAccent: true,
        padding: Padding(\.paddingMetricCard),
        compositions: \.containerMetricCard,
        shapes: \.containerMetricCard,
    )
    
    
    // MARK: - List
    
    public static let listRow: Self = .init("listRow",
        padding: .listRow,
        compositions: \.listRow,
    )
    
    
    // MARK: - Button
    
    public static let button: Self = .init("button",
        padding: Padding(horizontal: \.paddingActionHorizontal, vertical: \.paddingActionVertical),
        compositions: \.containerAction,
        shapes: \.containerAction,
    )
    
    public static let buttonIconOnly: Self = .init("buttonIconOnly",
        padding: Padding(\.paddingActionIcon),
        compositions: \.interactiveContainer,
        shapes: \.containerActionIcon,
    )
    
}
