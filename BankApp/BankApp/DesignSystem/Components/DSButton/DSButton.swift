import UIKit

final class DSButton: UIButton {
    private var viewModel: DSButtonViewModel?
    
    public func configure(with viewModel: DSButtonViewModel) {
        self.viewModel = viewModel
        setupButton()
    }
    
    private func setupButton() {
        guard let viewModel = viewModel else { return }
        
        setTitle(viewModel.title, for: .normal)
        isEnabled = viewModel.isEnabled
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        if let icon = viewModel.icon {
            setImage(icon, for: .normal)
            configuration?.imagePadding = Spacing.spacing12
        }
        
        layer.cornerRadius = Radius.medium
        titleLabel?.font = Font.bodyMedium
        
        switch viewModel.style {
        case .primary:
            backgroundColor = viewModel.isEnabled ? Color.primary : Color.primary.withAlphaComponent(0.5)
            setTitleColor(Color.textPrimary, for: .normal)
            setTitleColor(Color.textPrimary.withAlphaComponent(0.5), for: .disabled)
            
        case .secondary:
            backgroundColor = viewModel.isEnabled ? Color.secondaryBackground : Color.secondaryBackground.withAlphaComponent(0.5)
            setTitleColor(Color.textSecondary, for: .normal)
            setTitleColor(Color.textSecondary.withAlphaComponent(0.5), for: .disabled)
            
        case .bordered:
            backgroundColor = .clear
            layer.borderWidth = 1
            layer.borderColor = viewModel.isEnabled ? Color.black.cgColor : Color.black.withAlphaComponent(0.5).cgColor
            setTitleColor(viewModel.isEnabled ? Color.primary : Color.primary.withAlphaComponent(0.5), for: .normal)
            
        case .plain:
            backgroundColor = .clear
            setTitleColor(viewModel.isEnabled ? Color.primary : Color.primary.withAlphaComponent(0.5), for: .normal)
        }
        
        configuration?.contentInsets = NSDirectionalEdgeInsets(top: Spacing.spacing12, leading: Spacing.spacing16, bottom: Spacing.spacing12, trailing: Spacing.spacing16)
    }
    
    @objc private func buttonTapped() {
        animateButtonPress()
        viewModel?.action?()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateButtonDown()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateButtonUp()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateButtonUp()
    }
    
    private func animateButtonDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    private func animateButtonUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }
    
    private func animateButtonPress() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1.0
            }
        }
    }
}
