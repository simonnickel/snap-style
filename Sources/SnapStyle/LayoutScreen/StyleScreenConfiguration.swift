//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public enum StyleScreenConfiguration: Equatable {

    /// Restricts screen width to fit `\.widthReadableContent`
    /// Configuration `.allowReadableContentOverflow` controls if it uses contentMargin or safeAreaPadding. ListStyle `.insetGrouped` requires to use contentMargin, to get rid of system inset and properly apply `\.paddingScreenHorizontal`.
    case readableContentWidth
    
    /// Allows screen to overflow `.readableContentWidth`, e.g. for horizontal scrollViews or background.
    case allowReadableContentOverflow
    
    /// Wraps content in a ScrollView.
    case scrollView
    
    /// Wraps content in a VStack with `\.spacingSections`.
    case verticalSectionSpacing
}

extension [StyleScreenConfiguration] {
    /// A default set of configurations for a typical content screen.
    public static var content: Self { [.scrollView, .verticalSectionSpacing, .readableContentWidth, .allowReadableContentOverflow] }
    
    /// A default set of configurations for a system list screen.
    public static var list: Self { [.readableContentWidth] }
}


// MARK: ViewModifier

internal struct ConfigurationModifierInset: ViewModifier {
    
    let applyReadableWidth: Bool
    let allowOverflow: Bool
    
    func body(content: Content) -> some View {
        ScreenInsetContainer(applyReadableWidth: applyReadableWidth, allowOverflow: allowOverflow) {
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
        StyleVStack(spacing: \.spacingSections) {
            content
        }
    }
}
