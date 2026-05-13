//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents

extension Style.Container.Properties {
    
    // MARK: - Base
    
    public static let base: Self = .init(
        "base",
        composition: \.anyContainer,
        shape: \.anyContainer,
        padding: \.anyContainer,
    )

    
    // MARK: - Screen

    public static let screen: Self = .init(
        "screen",
        ignoresSafeAreaEdges: .all,
        composition: \.screen,
        shape: nil,
    )
    
    
    // MARK: - Card
    
    public static let card: Self = .init(
        "card",
        shape: \.containerCard,
        padding: \.containerCard,
    )
    
    // MARK: Content Card
    
    public static let contentCard: Self = Self.card.adjusted(
        "contentCard",
        composition: .set(\.containerContentCard),
    )


    // MARK: Accessory Card

    public static let infoCard: Self = Self.card.adjusted(
        "infoCard",
        composition: .set(\.containerInfoCard),
    )


    // MARK: Accent Card

    public static let accentCard: Self = Self.card.adjusted(
        "accentCard",
        requiresSecondaryAccent: .set(true),
        composition: .set(\.containerAccentCard),
    )


    // MARK: Metric Card

    public static let metricCard: Self = Self.card.adjusted(
        "metricCard",
        requiresSecondaryAccent: .set(true),
        composition: .set(\.containerMetricCard),
        shape: .set(\.containerMetricCard),
        padding: .set(\.containerMetricCard),
    )
    
    
    // MARK: - List
    
    public static let listRow: Self = .init(
        "listRow",
        composition: \.listRow,
        padding: \.listRow,
    )
    
    
    // MARK: - Button
    
    public static let button: Self = .init(
        "button",
        composition: \.containerAction,
        shape: \.containerAction,
        padding: \.containerAction,
        border: \.border,
    )
    
    public static let buttonIconOnly: Self = .init(
        "buttonIconOnly",
        composition: \.interactiveContainer,
        shape: \.containerActionIconOnly,
        padding: \.containerActionIconOnly,
    )
    
}
