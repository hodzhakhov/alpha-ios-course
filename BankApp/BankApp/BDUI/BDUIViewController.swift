import UIKit

final class BDUIViewController: UIViewController, BDUIReloadable {
    private let mapper: BDUIMapperProtocol
    private let jsonString: String
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(mapper: BDUIMapperProtocol, jsonString: String) {
        self.mapper = mapper
        self.jsonString = jsonString
        super.init(nibName: nil, bundle: nil)
        mapper.setReloadableDelegate(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        loadContent()
    }
    
    private func loadContent() {
        loadingIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.alpha = 0
        }, completion: { _ in
            self.contentView.subviews.forEach { $0.removeFromSuperview() }
            
            do {
                guard let jsonData = self.jsonString.data(using: .utf8) else {
                    throw BDUIError.invalidContent
                }
                
                let model = try JSONDecoder().decode(BDUIModel.self, from: jsonData)
                let mappedView = try self.mapper.map(model)
                
                self.contentView.addSubview(mappedView)
                
                NSLayoutConstraint.activate([
                    mappedView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Spacing.spacing16),
                    mappedView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Spacing.spacing16),
                    mappedView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Spacing.spacing16),
                    mappedView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -Spacing.spacing16)
                ])
                
                self.contentView.alpha = 0
                UIView.animate(withDuration: 0.3, animations: {
                    self.contentView.alpha = 1
                }, completion: { _ in
                    self.loadingIndicator.stopAnimating()
                })
                
            } catch {
                let errorLabel = UILabel()
                errorLabel.text = "Ошибка: \(error.localizedDescription)"
                errorLabel.textColor = .red
                errorLabel.textAlignment = .center
                errorLabel.numberOfLines = 0
                
                self.view.addSubview(errorLabel)
                errorLabel.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    errorLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                    errorLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                    errorLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
                    errorLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
                ])
                
                self.loadingIndicator.stopAnimating()
            }
        })
    }
    
    func reload() {
        loadContent()
    }
} 