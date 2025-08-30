//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLabel<Content: View>: View {
    
    public typealias IconKeyPath = SnapStyle.IconKey.ValueBuilderKeyPath
    
    @Environment(\.style) private var style
    @Environment(\.styleLabelSpacing) private var styleLabelSpacing
    
    private let content: () -> Content
    private let icon: StyleIcon.Definition?
    
    public init(
        icon: IconKeyPath? = nil,
        systemImage: String? = nil,
        content: @escaping () -> Content,
    ) {
        self.content = content
        self.icon = .init(icon: icon, systemImage: systemImage)
    }
    
    public init(
        _ title: String,
        icon: IconKeyPath? = nil,
        systemImage: String? = nil,
    ) where Content == Text {
        self.content = { Text(title) }
        self.icon = .init(icon: icon, systemImage: systemImage)
    }

    public init(
        icon: IconKeyPath? = nil,
        systemImage: String? = nil,
    ) where Content == EmptyView {
        self.content = { EmptyView() }
        self.icon = .init(icon: icon, systemImage: systemImage)
    }
    
    public var body: some View {
        Label(title: content, icon: {
            if let icon {
                StyleIcon(icon)
                    .style(element: .icon)
            } else {
                EmptyView()
            }
        })
        .labelStyle(.style(spacing: styleLabelSpacing))
    }
    
}


// MARK: - Environment

extension EnvironmentValues {
    @Entry var styleLabelSpacing: SnapStyle.NumberKey.ValueBuilderKeyPath = \.spacingLabel
}


// MARK: - CustomSpacingLabelStyle

extension LabelStyle where Self == CustomSpacingLabelStyle {
    static func style(spacing: SnapStyle.NumberKey.ValueBuilderKeyPath) -> CustomSpacingLabelStyle {
        CustomSpacingLabelStyle(spacing: spacing)
    }
}

struct CustomSpacingLabelStyle: LabelStyle {
    
    let spacing: SnapStyle.NumberKey.ValueBuilderKeyPath
    
    func makeBody(configuration: Configuration) -> some View {
        StyleStack(.horizontal, spacing: spacing, isStretching: false) {
            configuration.icon
            configuration.title
        }
    }
}


// MARK: - Preview

#Preview {
    StyleStack(spacing: \.spacingSections) {
        StyleStack {
            
            StyleLabel(icon: \.favorite) {
                Text("Content")
            }
            
            StyleLabel(content: {
                Text("Content")
            })
            
            StyleLabel(icon: \.favorite)
            
            StyleLabel(systemImage: "rectangle")
            
            StyleLabel("Title", icon: \.favorite)
            StyleLabel("Custom Spacing", icon: \.favorite)
                .environment(\.styleLabelSpacing, \.spacingSections)
        }

        
        StyleStack {
            Label("System Label", systemImage: "circle")
                .font(.footnote)
            StyleLabel("Style Label", systemImage: "circle")
                .font(.footnote)
            Label("System Label", systemImage: "circle")
            StyleLabel("Style Label", systemImage: "circle")
            Label("System Label", systemImage: "circle")
                .font(.largeTitle)
            StyleLabel("Style Label", systemImage: "circle")
                .font(.largeTitle)
            
        }
    }
}
