import UIKit

enum DSCardStyle {
    case bordered
    case filled
}


struct DSCardViewModel {
    let title: String?
    let subtitle: String?
    let image: UIImage?
    let style: DSCardStyle
    let action: (() -> Void)?
    
    public init(
        title: String? = nil,
        subtitle: String? = nil,
        image: UIImage? = nil,
        style: DSCardStyle = .bordered,
        action: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
        self.style = style
        self.action = action
    }
}
