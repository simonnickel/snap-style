//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public enum StyleScreenConfiguration: Equatable {

    /// Insets the content at least by `NumberKey.paddingScreenHorizontal`.
    case insetHorizontalEdges

    /// Insets the content by `NumberKey.paddingScreenTop` and `NumberKey.paddingScreenBottom`.
    case insetVerticalEdges

    /// Restricts screen width to fit `NumberKey.widthReadableContent`
    /// Configuration `.allowReadableContentOverflow` controls if it uses contentMargin or safeAreaPadding. ListStyle `.insetGrouped` requires to use contentMargin, to get rid of system inset and properly apply `\.paddingScreenHorizontal`.
    case readableContentWidth

    /// Allows screen to overflow `.readableContentWidth`, e.g. for horizontal scrollViews or background.
    /// *Caution: content (and background) behave dependent on their .horizontal safe area configuration.*
    case allowReadableContentOverflow

    /// Wraps content in a ScrollView.
    case scrollView

    /// Wraps content in a VStack with `NumberKey.spacingSections`.
    case verticalSectionSpacing
}

extension [StyleScreenConfiguration] {
    /// A default set of configurations for a typical content screen.
    public static var content: Self { [.scrollView, .verticalSectionSpacing, .insetHorizontalEdges, .insetVerticalEdges, .readableContentWidth, .allowReadableContentOverflow] }

    /// A default set of configurations for a system list screen.
    public static var list: Self { [.insetHorizontalEdges, .readableContentWidth] } // TODO FB18231015: .readableContentWidth without .allowReadableContentOverflow does not work properly on iPadOS 26 with sidebar. Area outside of .readableContentWidth can not be used to scroll. (FB18231015: Content outside of SafeAreaPadding not interactive)
}


// MARK: ViewModifier

internal struct ConfigurationModifierInset: ViewModifier {

    let insetHorizontalEdges: Bool
    let insetVerticalEdges: Bool
    let applyReadableWidth: Bool
    let allowOverflow: Bool

    func body(content: Content) -> some View {
        ScreenInsetContainer(
            insetHorizontalEdges: insetHorizontalEdges,
            insetVerticalEdges: insetVerticalEdges,
            applyReadableWidth: applyReadableWidth,
            allowOverflow: allowOverflow
        ) {
            content
        }
    }
}

internal struct ConfigurationModifierScrollView: ViewModifier {
    func body(content: Content) -> some View {
        ScrollView {
            content
        }
    }
}

internal struct ConfigurationModifierVerticalSections: ViewModifier {
    func body(content: Content) -> some View {
        StyleStack(spacing: \.spacingSections) {
            content
        }
    }
}
