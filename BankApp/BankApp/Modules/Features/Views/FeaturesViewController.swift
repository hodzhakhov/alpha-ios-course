import UIKit

class FeaturesViewController: UIViewController, FeaturesViewProtocol {
    var presenter: FeaturesPresenterProtocol?
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentStack: DSStackView = {
        let stack = DSStackView()
        stack.configure(with: DSStackViewModel(
            axis: .vertical,
            spacing: Spacing.spacing16
        ))
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var featuresStack: DSStackView = {
        let stack = DSStackView()
        stack.configure(with: DSStackViewModel(
            axis: .vertical,
            spacing: Spacing.spacing12,
            distribution: .fillEqually
        ))
        return stack
    }()
    
    private lazy var featuresLabel: DSLabel = {
        let label = DSLabel()
        let viewModel = DSLabelViewModel(
            text: "Ваши возможности",
            style: .subtitle,
            alignment: .left
        )
        label.configure(with: viewModel)
        return label
    }()
    
    private lazy var ratesLabel: DSLabel = {
        let label = DSLabel()
        let viewModel = DSLabelViewModel(
            text: "Курсы валют к 1 доллару",
            style: .subtitle,
            alignment: .left
        )
        label.configure(with: viewModel)
        return label
    }()
    
    private lazy var ratesContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = Color.secondary.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = Radius.medium
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var ratesTableView: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = true
        table.refreshControl = refreshControl
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var ratesLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return control
    }()
    
    private let tableManager: TableManagerProtocol = TableManager()
    
    private var features: [Feature] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.fetchFeatures()
        ratesTableView.isHidden = true
        ratesLoadingIndicator.startAnimating()
        presenter?.fetchCurrencyRates()
    }
    
    private func setupUI() {
        view.backgroundColor = Color.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        
        contentStack.addArrangedSubview(featuresLabel)
        contentStack.addArrangedSubview(featuresStack)
        contentStack.addArrangedSubview(ratesLabel)
        contentStack.addArrangedSubview(ratesContainerView)
        
        ratesContainerView.addSubview(ratesTableView)
        ratesContainerView.addSubview(ratesLoadingIndicator)
        
        tableManager.setup(with: ratesTableView)
        tableManager.delegate = self
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Spacing.spacing16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Spacing.containerMedium),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Spacing.containerMedium),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -Spacing.containerMedium * 2),
            
            ratesTableView.topAnchor.constraint(equalTo: ratesContainerView.topAnchor),
            ratesTableView.leadingAnchor.constraint(equalTo: ratesContainerView.leadingAnchor),
            ratesTableView.trailingAnchor.constraint(equalTo: ratesContainerView.trailingAnchor),
            ratesTableView.bottomAnchor.constraint(equalTo: ratesContainerView.bottomAnchor),
            ratesTableView.heightAnchor.constraint(equalToConstant: 250),
            
            ratesLoadingIndicator.centerXAnchor.constraint(equalTo: ratesContainerView.centerXAnchor),
            ratesLoadingIndicator.centerYAnchor.constraint(equalTo: ratesContainerView.centerYAnchor)
        ])
    }
    
    @objc private func refreshData() {
        presenter?.fetchCurrencyRates()
    }
    
    func displayFeatures(_ features: [Feature]) {
        self.features = features
        featuresStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        features.forEach { feature in
            let button = DSButton()
            let viewModel = DSButtonViewModel(
                title: feature.title,
                style: .primary,
                action: { [weak self] in
                    self?.featureButtonTapped(feature)
                }
            )
            button.configure(with: viewModel)
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
            button.tag = features.firstIndex(where: { $0.id == feature.id }) ?? 0
            featuresStack.addArrangedSubview(button)
        }
    }
    
    private func featureButtonTapped(_ feature: Feature) {
        presenter?.didSelectFeature(feature)
    }
    
    func displayCurrencyRates(_ rates: [CurrencyRate]) {
        refreshControl.endRefreshing()
        ratesLoadingIndicator.stopAnimating()
        ratesTableView.isHidden = false
        
        let sortedRates = rates.sorted { $0.currency < $1.currency }
        
        let viewModels = sortedRates.map {
            CurrencyRateCellViewModel(
                currencyCode: $0.currency,
                rateText: String(format: "%.4f", $0.rate)
            )
        }
        
        tableManager.update(with: viewModels)
    }
    
    func showError(_ message: String) {
        refreshControl.endRefreshing()
        ratesLoadingIndicator.stopAnimating()
        ratesTableView.isHidden = false
        
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

extension FeaturesViewController: TableManagerDelegate {
    func didSelectRate(_ viewModel: CurrencyRateCellViewModel) {
        print("Выбрана валюта: \(viewModel.currencyCode)")
    }
}
