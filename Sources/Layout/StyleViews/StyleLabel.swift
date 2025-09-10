//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SwiftUI

public struct StyleLabel<Content: View>: View {
    
    public typealias IconKeyPath = Style.IconKey.ValueBuilderKeyPath
    
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
    @Entry var styleLabelSpacing: Style.NumberKey.ValueBuilderKeyPath = \.spacingLabel
    @Entry var styleLabelContent: [StyleLabelContent] = [.icon, .label]
}


// MARK: - CustomSpacingLabelStyle

extension LabelStyle where Self == CustomSpacingLabelStyle {
    static func style(spacing: Style.NumberKey.ValueBuilderKeyPath) -> CustomSpacingLabelStyle {
        CustomSpacingLabelStyle(spacing: spacing)
    }
}

struct CustomSpacingLabelStyle: LabelStyle {
    
    @Environment(\.styleLabelContent) private var styleLabelContent
    
    let spacing: Style.NumberKey.ValueBuilderKeyPath
    
    func makeBody(configuration: Configuration) -> some View {
        StyleStack(.horizontal, spacing: spacing, isStretching: false) {
            if styleLabelContent.contains(.icon) {
                configuration.icon
            }
            // TODO Accessibility: Should the label text be added as hint? Do we have access here to the text somehow?
            if styleLabelContent.contains(.label) {
                configuration.title
            }
        }
    }
}


// MARK: - ContentConfiguration

public enum StyleLabelContent {
    case icon, label
}

extension View {
    public func style(labelContent: [StyleLabelContent]) -> some View {
        environment(\.styleLabelContent, labelContent)
    }
}


// MARK: - Preview

#Preview {
    StyleStack(spacing: \.spacingSections) {
        StyleStack {
            
            StyleLabel(icon: \.favorite) {
                Text("Content")
            }
            .background(.yellow)
            
            StyleLabel(content: {
                Text("Content")
            })
            .background(.yellow)
            
            StyleLabel(icon: \.favorite)
                .background(.yellow)
            StyleLabel("Invisible", systemImage: "circle")
                .style(labelContent: [.icon])
                .background(.yellow)
            
            StyleLabel("Title", icon: \.favorite)
                .background(.yellow)
            StyleLabel("Custom Spacing", icon: \.favorite)
                .environment(\.styleLabelSpacing, \.spacingSections)
                .background(.yellow)
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
