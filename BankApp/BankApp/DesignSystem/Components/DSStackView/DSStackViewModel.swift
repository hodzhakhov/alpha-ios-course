import UIKit

struct DSStackViewModel {
    let axis: NSLayoutConstraint.Axis
    let spacing: CGFloat
    let distribution: UIStackView.Distribution
    let alignment: UIStackView.Alignment
    
    init(
        axis: NSLayoutConstraint.Axis = .vertical,
        spacing: CGFloat = Spacing.containerMedium,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill
    ) {
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
}

