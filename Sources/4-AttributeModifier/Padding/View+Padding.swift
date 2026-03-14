//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import SnapStyleBase
import SnapStyleComponents
import SwiftUI

extension View {
    
    public func style(padding keyPath: Style.Attribute.Padding.ValueBuilderKeyPath?) -> some View {
        modifier(PaddingAttributeModifier(keyPath: keyPath))
    }
    
    /// Convenience shortcut to define a `Padding` for an element via environment.
    public func styleDefine(padding key: Style.Attribute.Padding.ValueBuilderKeyPath?, for element: Style.Element.ElementType) -> some View {
        style(define: Style.Attribute.Padding.self, key: key, for: element)
    }
    
}


// MARK: - Modifier

package struct PaddingAttributeModifier: ViewModifier {
    
    @Environment(\.style) private var style
    
    let keyPath: Style.Attribute.Padding.ValueBuilderKeyPath?
    
    package func body(content: Content) -> some View {
        let padding = style.padding(for: keyPath)
        content
            .style(padding: padding?.leading, .leading)
            .style(padding: padding?.top, .top)
            .style(padding: padding?.trailing, .trailing)
            .style(padding: padding?.bottom, .bottom)
    }
    
}


// MARK: - Preview

#if DEBUG
extension Style.Component {
    
    static let previewPadding: Self = .init(
        "previewPadding",
        compositions: { element in
            switch element {
                case .icon: \.accentContainer
                default: nil
            }
        },
        paddings: { element in
            switch element {
                case .icon: \.containerCard
                default: nil
            }
        },
    )
                                         
}
#endif

#Preview("Component") {

    VStack(alignment: .leading, spacing: 15) {
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
            Text("Padding from Component")
                .style(element: .label)
        }
        HStack {
            Image(systemName: "star")
                .style(element: .icon)
                .styleDefine(padding: \.listRow, for: .icon)
            Text("Padding override")
                .style(element: .label)
        }
    }
    .style(component: .previewPadding)

}

#Preview("Animation") {

    @Previewable @State var isActive: Bool = true

    Text("Some Preview Content")
        .style(padding: isActive ? \.containerCard : nil)
        .background(.green)

    Button {
        withAnimation {
            isActive.toggle()
        }
    } label: {
        Text("Toggle")
    }

}
