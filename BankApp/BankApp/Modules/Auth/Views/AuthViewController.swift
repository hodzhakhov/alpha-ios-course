import UIKit

class AuthViewController: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol?
    
    private lazy var usernameTextField: DSTextField = {
        let textField = DSTextField()
        let viewModel = DSTextFieldViewModel(
            placeholder: "Email",
            style: .bordered,
            keyboardType: .emailAddress,
            autocapitalizationType: .none,
            onTextChanged: { [weak self] text in
                self?.textFieldDidChange()
            }
        )
        textField.configure(with: viewModel)
        return textField
    }()
    
    private lazy var passwordTextField: DSTextField = {
        let textField = DSTextField()
        let viewModel = DSTextFieldViewModel(
            placeholder: "Пароль",
            style: .bordered,
            isSecure: true,
            autocapitalizationType: .none,
            onTextChanged: { [weak self] text in
                self?.textFieldDidChange()
            }
        )
        textField.configure(with: viewModel)
        return textField
    }()
    
    private lazy var confirmPasswordTextField: DSTextField = {
        let textField = DSTextField()
        let viewModel = DSTextFieldViewModel(
            placeholder: "Подтвердите пароль",
            style: .bordered,
            isSecure: true,
            autocapitalizationType: .none,
            onTextChanged: { [weak self] text in
                self?.textFieldDidChange()
            }
        )
        textField.configure(with: viewModel)
        textField.isHidden = true
        return textField
    }()
    
    private lazy var loginButton: DSButton = {
        let button = DSButton()
        let viewModel = DSButtonViewModel(
            title: "Войти",
            style: .primary,
            action: { [weak self] in
                self?.authButtonTapped()
            }
        )
        button.configure(with: viewModel)
        return button
    }()
    
    private lazy var switchAuthModeButton: DSButton = {
        let button = DSButton()
        let viewModel = DSButtonViewModel(
            title: "Нет аккаунта? Зарегистрироваться",
            style: .plain,
            action: { [weak self] in
                self?.switchAuthMode()
            }
        )
        button.configure(with: viewModel)
        return button
    }()
    
    private lazy var errorLabel: DSLabel = {
        let label = DSLabel()
        let viewModel = DSLabelViewModel(
            text: "",
            style: .error,
            alignment: .center
        )
        label.configure(with: viewModel)
        return label
    }()
    
    private lazy var formStackView: DSStackView = {
        let stackView = DSStackView()
        stackView.configure(with: DSStackViewModel(
            axis: .vertical,
            spacing: Spacing.spacing16
        ))
        return stackView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Color.background
        
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formStackView)
        view.addSubview(loadingIndicator)
        
        formStackView.addArrangedSubview(usernameTextField)
        formStackView.addArrangedSubview(passwordTextField)
        formStackView.addArrangedSubview(confirmPasswordTextField)
        formStackView.addArrangedSubview(loginButton)
        formStackView.addArrangedSubview(switchAuthModeButton)
        formStackView.addArrangedSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            formStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Spacing.spacing40),
            formStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.containerMedium),
            formStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.containerMedium),
            
            loadingIndicator.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: Spacing.spacing20),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTextField.heightAnchor.constraint(equalToConstant: 30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func authButtonTapped() {
        let email = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        presenter?.authButtonTapped(email: email, password: password, confirmPassword: confirmPassword)
    }
    
    private func switchAuthMode() {
        presenter?.toggleAuthMode()
    }
    
    private func textFieldDidChange() {
        let email = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirm = confirmPasswordTextField.isHidden ? nil : confirmPasswordTextField.text
        presenter?.validateInput(email: email, password: password, confirmPassword: confirm)
    }
    
    func showLoginScreen() {
        confirmPasswordTextField.isHidden = true
        loginButton.configure(with: DSButtonViewModel(title: "Войти", style: .primary, action: { [weak self] in
            self?.authButtonTapped()
        }))
        switchAuthModeButton.configure(with: DSButtonViewModel(title: "Нет аккаунта? Зарегистрироваться", style: .plain, action: { [weak self] in
            self?.switchAuthMode()
        }))
    }
    
    func showRegistrationScreen() {
        confirmPasswordTextField.isHidden = false
        loginButton.configure(with: DSButtonViewModel(title: "Зарегистрироваться", style: .primary, action: { [weak self] in
            self?.authButtonTapped()
        }))
        switchAuthModeButton.configure(with: DSButtonViewModel(title: "Уже есть аккаунт? Войти", style: .plain, action: { [weak self] in
            self?.switchAuthMode()
        }))
    }
    
    func showLoading(_ isLoading: Bool) {
        loginButton.isEnabled = !isLoading
        if isLoading {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func showError(_ message: String) {
        errorLabel.configure(with: DSLabelViewModel(text: message, style: .error, alignment: .center))
    }
    
    func setAuthButtonEnabled(_ enabled: Bool) {
        loginButton.configure(with: DSButtonViewModel(
            title: loginButton.titleLabel?.text ?? "Войти",
            style: .primary,
            isEnabled: enabled,
            action: { [weak self] in
                self?.authButtonTapped()
            }
        ))
    }
}
