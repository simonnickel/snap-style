//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public enum StyleScreenConfiguration: Equatable {
    
    /// Insets the content at least by `NumberKey.insetScreenHorizontal`.
    case insetHorizontalEdges

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
    public static var content: Self { [.scrollView, .verticalSectionSpacing, .insetHorizontalEdges, .readableContentWidth, .allowReadableContentOverflow] }
    
    /// A default set of configurations for a system list screen.
    public static var list: Self { [.insetHorizontalEdges, .readableContentWidth] }
}


// MARK: ViewModifier

internal struct ConfigurationModifierInset: ViewModifier {
    
    let insetHorizontalEdges: Bool
    let applyReadableWidth: Bool
    let allowOverflow: Bool
    
    func body(content: Content) -> some View {
        ScreenInsetContainer(insetHorizontalEdges: insetHorizontalEdges, applyReadableWidth: applyReadableWidth, allowOverflow: allowOverflow) {
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
