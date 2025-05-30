//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLabel<Content: View>: View {
    
    public typealias Icon = SnapStyle.IconKey.ValueBuilderKeyPath
    
    public enum Constants {
        public static var defaultSpacing: SnapStyle.NumberKey.ValueBuilderKeyPath { \.spacingLabel }
    }
    
    @Environment(\.style) private var style
    
    private let content: () -> Content
    private let icon: Icon?
    private let systemImage: String?
    private let spacing: SnapStyle.NumberKey.ValueBuilderKeyPath
    
    public init(
        content: @escaping () -> Content,
        icon: Icon? = nil,
        systemImage: String? = nil,
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath = Constants.defaultSpacing
    ) {
        self.content = content
        self.icon = icon
        self.systemImage = systemImage
        self.spacing = spacing
    }
    
    public init(
        _ title: String,
        icon: Icon? = nil,
        systemImage: String? = nil,
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath = Constants.defaultSpacing
    ) where Content == Text {
        self.content = { Text(title) }
        self.icon = icon
        self.systemImage = systemImage
        self.spacing = spacing
    }

    public init(
        icon: Icon? = nil,
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath = Constants.defaultSpacing
    ) where Content == EmptyView {
        self.content = { EmptyView() }
        self.icon = icon
        self.systemImage = nil
        self.spacing = spacing
    }

    public init(
        systemImage: String? = nil,
        spacing: SnapStyle.NumberKey.ValueBuilderKeyPath = Constants.defaultSpacing
    ) where Content == EmptyView {
        self.content = { EmptyView() }
        self.icon = nil
        self.systemImage = systemImage
        self.spacing = spacing
    }
    
    public var body: some View {
        Label(title: content, icon: {
            if let icon {
                if let iconName = style.value(for: icon)?.wrappedValue {
                    Image(systemName: iconName)
                }
            } else if let systemImage {
                Image(systemName: systemImage)
            } else {
                EmptyView()
            }
        })
        .labelStyle(.style(spacing: spacing))
    }
    
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
        StyleHStack(spacing: spacing) {
            configuration.icon
            configuration.title
        }
    }
}


// MARK: - Preview

#Preview {
    StyleVStack(spacing: \.spacingSections) {
        StyleVStack {
            
            StyleLabel(content: {
                Text("Content")
            }, icon: \.favorite)
            
            StyleLabel(content: {
                Text("Content")
            })
            
            StyleLabel(icon: \.favorite)
            
            StyleLabel(systemImage: "rectangle")
            
            StyleLabel("Title", icon: \.favorite)
            StyleLabel("Custom Spacing", icon: \.favorite, spacing: \.spacingSections)
        }

        
        StyleVStack {
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
