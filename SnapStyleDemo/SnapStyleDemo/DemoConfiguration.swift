//
//  SNAP - https://github.com/simonnickel/snap
//  Created by Simon Nickel
//

import Observation
import SnapStyle
import SwiftUI

@Observable
class DemoConfiguration {
    
    typealias Accent = Style.Keys.Accent.Value.WrappedValue

    var accentPrimary: Accent
    var accentSecondary: Accent

    var scaleFactor: Style.Context.ScaleFactor
    
    var fontDesign: Font.Design

    var fontWidth: Font.Width

    init(
        accentPrimary: Accent = .fallbackPrimary,
        accentSecondary: Accent = .fallbackSecondary,
        scaleFactor: Style.Context.ScaleFactor = Style.Context.scaleFactorDefault,
        fontDesign: Font.Design = Style.Context.fontDesignDefault,
        fontWidth: Font.Width = Style.Context.fontWidthDefault,
        cornerRadius: CornerRadiusOption = .medium,
    ) {
        self.accentPrimary = accentPrimary
        self.accentSecondary = accentSecondary
        self.scaleFactor = scaleFactor
        self.fontDesign = fontDesign
        self.fontWidth = fontWidth
        self.cornerRadius = cornerRadius
    }


// MARK: - Corner Radius

    var cornerRadius: CornerRadiusOption
    
    enum CornerRadiusOption: String, CaseIterable {
        case small, medium, large
        
        var valueComponent: Style.Keys.Number.ValueBuilderKeyPath {
            switch self {
                case .small: \.cornerRadiusMedium
                case .medium: \.cornerRadiusLarge
                case .large: \.cornerRadiusLargest
            }
        }
        var valueMetricCard: Style.Keys.Number.ValueBuilderKeyPath {
            switch self {
                case .small: \.cornerRadiusSmallest
                case .medium: \.cornerRadiusSmall
                case .large: \.cornerRadiusMedium
            }
        }
    }
}


// MARK: - Environment

extension EnvironmentValues {

    @Entry var demoConfiguration: DemoConfiguration = DemoConfiguration()

}
