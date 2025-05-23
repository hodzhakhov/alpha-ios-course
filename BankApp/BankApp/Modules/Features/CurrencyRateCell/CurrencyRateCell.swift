import UIKit

final class CurrencyRateCell: UITableViewCell {
    static let reuseIdentifier = "CurrencyRateCell"
    
    private lazy var cardView: DSCard = {
        let card = DSCard()
        return card
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.spacing2),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.spacing2),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.spacing8),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.spacing8),
            cardView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with viewModel: CurrencyRateCellViewModel) {
        let cardViewModel = DSCardViewModel(
            title: viewModel.currencyCode,
            subtitle: viewModel.rateText,
            style: .filled,
            action: { [weak self] in
                print("Выбрана валюта: \(viewModel.currencyCode) с курсом \(viewModel.rateText)")
            }
        )
        cardView.configure(with: cardViewModel)
    }
}
