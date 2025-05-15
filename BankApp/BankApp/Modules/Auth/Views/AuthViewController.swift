import UIKit

class AuthViewController: UIViewController, AuthViewProtocol {
    var presenter: AuthPresenterProtocol?
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Подтвердите пароль"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.isHidden = true
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(authButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var switchAuthModeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нет аккаунта? Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(switchAuthMode), for: .touchUpInside)
        return button
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    private var isLoginMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [usernameTextField, passwordTextField, confirmPasswordTextField, loginButton, switchAuthModeButton, errorLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            switchAuthModeButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            switchAuthModeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: switchAuthModeButton.bottomAnchor, constant: 15),
            errorLabel.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor)
        ])
        
    }
    
    @objc private func authButtonTapped() {
        let email = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirmPassword = confirmPasswordTextField.text ?? ""
        
        if isLoginMode {
            presenter?.loginButtonTapped(email: email, password: password)
        } else {
            presenter?.registerButtonTapped(email: email, password: password, confirmPassword: confirmPassword)
        }
    }
    
    @objc private func switchAuthMode() {
        isLoginMode.toggle()
        loginButton.setTitle(isLoginMode ? "Войти" : "Зарегистрироваться", for: .normal)
        switchAuthModeButton.setTitle(isLoginMode ? "Нет аккаунта? Зарегистрироваться" : "Уже есть аккаунт? Войти", for: .normal)
        confirmPasswordTextField.isHidden = isLoginMode
        errorLabel.text = ""
        isLoginMode ? presenter?.didSwitchToLogin() : presenter?.didSwitchToRegister()
    }
    
    @objc private func textFieldDidChange() {
        let email = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let confirm = isLoginMode ? nil : confirmPasswordTextField.text
        presenter?.validateInput(email: email, password: password, confirmPassword: confirm)
    }
    
    func showLoginScreen() {
        isLoginMode = true
        loginButton.setTitle("Войти", for: .normal)
    }
    
    func showRegistrationScreen() {
        isLoginMode = false
        loginButton.setTitle("Зарегистрироваться", for: .normal)
    }
    
    func showLoading(_ isLoading: Bool) {
        loginButton.isEnabled = !isLoading
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
    }
    
    func setAuthButtonEnabled(_ enabled: Bool) {
        loginButton.isEnabled = enabled
        loginButton.alpha = enabled ? 1.0 : 0.5
    }
}
