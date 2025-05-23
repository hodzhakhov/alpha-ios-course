import UIKit

final class DSLabel: UILabel {
    func configure(with viewModel: DSLabelViewModel) {
        text = viewModel.text
        textAlignment = viewModel.alignment
        
        switch viewModel.style {
        case .headline:
            font = Font.h1
        case .title:
            font = Font.h2
        case .subtitle:
            font = Font.h3
        case .body:
            font = Font.bodyMedium
        case .caption:
            font = Font.captionSmall
        case .error:
            font = Font.captionSmall
        }
        
        textColor = viewModel.color ?? {
            switch viewModel.style {
            case .error:
                return Color.error
            default:
                return Color.black
            }
        }()
        
        numberOfLines = 0
    }
}

