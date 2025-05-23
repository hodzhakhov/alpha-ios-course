import UIKit

enum DSTextFieldStyle {
    case standard
    case bordered
    case error
}

struct DSTextFieldViewModel {
    let placeholder: String?
    let text: String?
    let style: DSTextFieldStyle
    let isSecure: Bool
    let keyboardType: UIKeyboardType
    let leftIcon: UIImage?
    let errorText: String?
    let autocapitalizationType: UITextAutocapitalizationType
    let onTextChanged: ((String) -> Void)?
    
    init(
        placeholder: String? = nil,
        text: String? = nil,
        style: DSTextFieldStyle = .standard,
        isSecure: Bool = false,
        keyboardType: UIKeyboardType = .default,
        leftIcon: UIImage? = nil,
        errorText: String? = nil,
        autocapitalizationType: UITextAutocapitalizationType = .sentences,
        onTextChanged: ((String) -> Void)? = nil
    ) {
        self.placeholder = placeholder
        self.text = text
        self.style = style
        self.isSecure = isSecure
        self.keyboardType = keyboardType
        self.leftIcon = leftIcon
        self.errorText = errorText
        self.autocapitalizationType = autocapitalizationType
        self.onTextChanged = onTextChanged
    }
}
