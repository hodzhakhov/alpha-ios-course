import UIKit

final class DSStackView: UIStackView {
    public func configure(with config: DSStackViewModel) {
        axis = config.axis
        spacing = config.spacing
        distribution = config.distribution
        alignment = config.alignment
    }
    
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { addArrangedSubview($0) }
    }
}
