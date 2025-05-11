//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SwiftUI

public enum StyleScreenConfiguration: Equatable {
    /// Restricts screen width to fit `\.widthReadableContent`
    ///
    /// - Parameters:
    ///   - allowOverflow: controls if scroll views and backgrounds are allowed to overflow the restriction.
    ///   Value`false` uses contentMargin instead of safeAreaPadding, e.g. necessary for ListStyle `.insetGrouped` to get rid of system inset and use `\.paddingScreenHorizontal`.
    case readableContentWidth(allowOverflow: Bool)
    
    /// Wraps content in a ScrollView.
    case scrollView
    
    /// Wraps content in a VStack with `\.spacingSections`.
    case verticalSectionSpacing
}

extension [StyleScreenConfiguration] {
    /// A default set of configurations for a typical content screen.
    public static var content: Self { [.scrollView, .readableContentWidth(allowOverflow: true), .verticalSectionSpacing] }
    
    /// A default set of configurations for a system list screen.
    public static var list: Self { [.readableContentWidth(allowOverflow: false), .verticalSectionSpacing] }
}


// MARK: ViewModifier

internal struct ConfigurationModifierReadableContentContainer: ViewModifier {
    
    let allowOverflow: Bool
    
    func body(content: Content) -> some View {
        ReadableContentContainer(allowOverflow: allowOverflow) {
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
