import UIKit

enum DSLabelStyle {
    case headline
    case title
    case subtitle
    case body
    case caption
    case error
}

struct DSLabelViewModel {
    let text: String
    let style: DSLabelStyle
    let color: UIColor?
    let alignment: NSTextAlignment
    
    init(
        text: String,
        style: DSLabelStyle = .body,
        color: UIColor? = nil,
        alignment: NSTextAlignment = .center
    ) {
        self.text = text
        self.style = style
        self.color = color
        self.alignment = alignment
    }
}
