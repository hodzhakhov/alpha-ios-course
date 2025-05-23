import UIKit

enum DSButtonStyle {
    case primary
    case secondary
    case bordered
    case plain
}


struct DSButtonViewModel {
    let title: String
    let style: DSButtonStyle
    let icon: UIImage?
    let isEnabled: Bool
    let action: (() -> Void)?
    
    public init(
        title: String,
        style: DSButtonStyle = .primary,
        icon: UIImage? = nil,
        isEnabled: Bool = true,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.style = style
        self.icon = icon
        self.isEnabled = isEnabled
        self.action = action
    }
}
