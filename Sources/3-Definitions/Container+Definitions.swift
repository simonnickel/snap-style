//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Container.Properties {
    
    // MARK: - Base
    
    public static let base: Self = .init("base",
        compositions: \.anyContainer,
        shapes: \.anyContainer,
        padding: \.anyContainer,
    )

    
    // MARK: - Screen

    public static let screen: Self = .init("screen",
        ignoresSafeAreaEdges: .all,
        compositions: \.screen,
        shapes: nil,
    )
    
    
    // MARK: - Content Card
    
    public static let contentCard: Self = .init("contentCard",
        compositions: \.containerContentCard,
        shapes: \.containerCard,
        padding: \.containerCard,
    )
    
    
    // MARK: - Accent Card
    
    public static let accentCard: Self = .init("accentCard",
        requiresSecondaryAccent: true,
        compositions: \.containerAccentCard,
        shapes: \.containerCard,
        padding: \.containerCard,
    )
    
    
    // MARK: - Metric Card
    
    public static let metricCard: Self = .init("metricCard",
        requiresSecondaryAccent: true,
        compositions: \.containerMetricCard,
        shapes: \.containerMetricCard,
        padding: \.containerMetricCard,
    )
    
    
    // MARK: - List
    
    public static let listRow: Self = .init("listRow",
        compositions: \.listRow,
        padding: \.listRow,
    )
    
    
    // MARK: - Button
    
    public static let button: Self = .init("button",
        compositions: \.containerAction,
        shapes: \.containerAction,
        padding: \.containerAction,
    )
    
    public static let buttonIconOnly: Self = .init("buttonIconOnly",
        compositions: \.interactiveContainer,
        shapes: \.containerActionIconOnly,
        padding: \.containerActionIconOnly,
    )
    
}
