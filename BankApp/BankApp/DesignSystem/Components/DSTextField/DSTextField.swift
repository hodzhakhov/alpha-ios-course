import UIKit

final class DSTextField: UITextField {
    private var viewModel: DSTextFieldViewModel?
    
    func configure(with viewModel: DSTextFieldViewModel) {
        self.viewModel = viewModel
        setupView()
    }
    
    private func setupView() {
        guard let viewModel = viewModel else { return }
        
        placeholder = viewModel.placeholder
        text = viewModel.text
        isSecureTextEntry = viewModel.isSecure
        keyboardType = viewModel.keyboardType
        autocapitalizationType = viewModel.autocapitalizationType
        isUserInteractionEnabled = true
        font = Font.bodyMedium
        delegate = self
        
        if let leftIcon = viewModel.leftIcon {
            let iconView = UIImageView(image: leftIcon)
            leftView = iconView
        }
        
        switch viewModel.style {
        case .standard:
            layer.cornerRadius = 0
            layer.borderWidth = 0
            layer.borderColor = nil
            backgroundColor = .clear
            borderStyle = .none
        case .bordered:
            layer.cornerRadius = Radius.medium
            layer.borderWidth = 1
            layer.borderColor = Color.black.cgColor
            backgroundColor = .clear
            borderStyle = .none
        case .error:
            layer.cornerRadius = Radius.small
            layer.borderWidth = 1
            layer.borderColor = Color.error.cgColor
            backgroundColor = .clear
            borderStyle = .none
        }
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Spacing.spacing12, height: frame.height))
        leftView = leftView ?? paddingView
        leftViewMode = .always
    }
}

extension DSTextField: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel?.onTextChanged?(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
