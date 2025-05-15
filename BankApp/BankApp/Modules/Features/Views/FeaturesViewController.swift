import UIKit

class FeaturesViewController: UIViewController, FeaturesViewProtocol {
    var presenter: FeaturesPresenterProtocol?

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()

    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var featuresStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var ratesLabel: UILabel = {
        let label = UILabel()
        label.text = "Курсы валют к 1 доллару"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()

    private lazy var ratesContainerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.fetchFeatures()
        ratesTableView.isHidden = true
        ratesLoadingIndicator.startAnimating()
        presenter?.fetchCurrencyRates()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

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

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),

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
        featuresStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        features.forEach { feature in
            let button = UIButton(type: .system)
            button.setTitle(feature.title, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 8
            button.addTarget(self, action: #selector(featureButtonTapped(_:)), for: .touchUpInside)
            button.tag = features.firstIndex(where: { $0.id == feature.id }) ?? 0
            featuresStack.addArrangedSubview(button)
        }
    }

    @objc private func featureButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                sender.transform = .identity
            }
        }

        guard let title = sender.titleLabel?.text else { return }
        let selectedFeature = Feature(id: title.lowercased(), title: title, description: "")
        presenter?.didSelectFeature(selectedFeature)
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
