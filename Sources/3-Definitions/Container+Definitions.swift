//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Container.Properties {
    
    // MARK: - Base
    
    public static let base: Self = .init("base",
        composition: \.anyContainer,
        shape: \.anyContainer,
        padding: \.anyContainer,
    )

    
    // MARK: - Screen

    public static let screen: Self = .init("screen",
        ignoresSafeAreaEdges: .all,
        composition: \.screen,
        shape: nil,
    )
    
    
    // MARK: - Content Card
    
    public static let contentCard: Self = .init("contentCard",
        composition: \.containerContentCard,
        shape: \.containerCard,
        padding: \.containerCard,
    )
    
    
    // MARK: - Accent Card
    
    public static let accentCard: Self = .init("accentCard",
        requiresSecondaryAccent: true,
        composition: \.containerAccentCard,
        shape: \.containerCard,
        padding: \.containerCard,
    )
    
    
    // MARK: - Metric Card
    
    public static let metricCard: Self = .init("metricCard",
        requiresSecondaryAccent: true,
        composition: \.containerMetricCard,
        shape: \.containerMetricCard,
        padding: \.containerMetricCard,
    )
    
    
    // MARK: - List
    
    public static let listRow: Self = .init("listRow",
        composition: \.listRow,
        padding: \.listRow,
    )
    
    
    // MARK: - Button
    
    public static let button: Self = .init("button",
        composition: \.containerAction,
        shape: \.containerAction,
        padding: \.containerAction,
    )
    
    public static let buttonIconOnly: Self = .init("buttonIconOnly",
        composition: \.interactiveContainer,
        shape: \.containerActionIconOnly,
        padding: \.containerActionIconOnly,
    )
    
}
