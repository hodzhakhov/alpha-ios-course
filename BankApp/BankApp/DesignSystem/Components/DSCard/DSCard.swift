import UIKit

final class DSCard: UIView {
    private let titleLabel = DSLabel()
    private let subtitleLabel = DSLabel()
    private let imageView = UIImageView()
    private let stackView = DSStackView()
    private var viewModel: DSCardViewModel?
    
    public func configure(with viewModel: DSCardViewModel) {
        self.viewModel = viewModel
        setupCard()
    }
    
    private func setupCard() {
        guard let viewModel = viewModel else { return }
        
        stackView.configure(with: DSStackViewModel(
            axis: .horizontal,
            spacing: Spacing.spacing8,
            distribution: .equalSpacing,
            alignment: .center
        ))
        
        if let image = viewModel.image {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            stackView.addArrangedSubview(imageView)
        }
        
        if let title = viewModel.title {
            titleLabel.configure(with: DSLabelViewModel(
                text: title,
                style: .caption,
                alignment: .left
            ))
            stackView.addArrangedSubview(titleLabel)
        }
        
        if let subtitle = viewModel.subtitle {
            subtitleLabel.configure(with: DSLabelViewModel(
                text: subtitle,
                style: .caption,
                alignment: .right
            ))
            stackView.addArrangedSubview(subtitleLabel)
        }
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.spacing12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.spacing12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.spacing12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.spacing12)
        ])
        
        layer.cornerRadius = Radius.medium
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        
        switch viewModel.style {
        case .bordered:
            backgroundColor = Color.background
            layer.borderWidth = 1
            layer.borderColor = Color.black.withAlphaComponent(0.1).cgColor
            
        case .filled:
            backgroundColor = Color.secondaryBackground
        }
        
        if viewModel.action != nil {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
            addGestureRecognizer(tapGesture)
            isUserInteractionEnabled = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateCardDown()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateCardUp()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animateCardUp()
    }
    
    private func animateCardDown() {
        UIView.animate(withDuration: 0.1) {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
            self.layer.shadowOpacity = 0.2
        }
    }
    
    private func animateCardUp() {
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
            self.layer.shadowOpacity = 0.1
        }
    }
    
    @objc private func cardTapped() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.alpha = 1.0
            }
            self.viewModel?.action?()
        }
    }
}
