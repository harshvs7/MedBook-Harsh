//
//  SignUpViewController.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 19/10/24.
//

import UIKit

import UIKit

class SignupViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var selectedCountry: String?
    private var viewModel = OnboardingViewModel()
    
    private let backButton : UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        backButton.tintColor = .black
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .next
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .next
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 8
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter your password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        return textField
    }()
    
    private let countryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SIGN UP", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let passwordToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addToolbarToTextFields()
        fetchCountriesFromAPI()
        setDefaultCountryFromIP()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

//MARK: Helper functions
extension SignupViewController {
    
    private func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(passwordToggleButton)
        view.addSubview(countryPicker)
        view.addSubview(signupButton)
        
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        countryPicker.delegate = self
        countryPicker.dataSource = self
        
        NSLayoutConstraint.activate([
            //Back Button at the top left
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            
            // Title Label left of backButton
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            
            // Email TextField below title
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password TextField below email textField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password Toggle Button on top right of password textField
            passwordToggleButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordToggleButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -8),
            passwordToggleButton.widthAnchor.constraint(equalToConstant: 30),
            passwordToggleButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Country Picker below password textField
            countryPicker.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            countryPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            countryPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            countryPicker.heightAnchor.constraint(equalToConstant: 150),
            
            // SignUp Button below country picker
            signupButton.topAnchor.constraint(equalTo: countryPicker.bottomAnchor, constant: 24),
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // Fetch countries from the API and store them locally
    private func fetchCountriesFromAPI() {
        viewModel.fetchCountries(completion: { [weak self] success in
            guard let self = self else { return }
            if success {
                DispatchQueue.main.async {
                    self.countryPicker.reloadAllComponents()
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert("Oops", "Something went wrong!")
                }
            }
        })
    }
    
    // Get the default country using the IP (had to bypass apple security check to call this api as it is not https)
    private func setDefaultCountryFromIP() {
        viewModel.setDefaultCountryFromIP(completion: { [weak self] success in
            guard let self = self, let index = self.viewModel.selectedIndex else { return }
            if success {
                DispatchQueue.main.async {
                    self.countryPicker.selectRow(index, inComponent: 0, animated: true)
                    self.selectedCountry = self.viewModel.countries[index]
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert("Oops", "Something went wrong!")
                }
            }
        })
    }
    
    //Email validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    // Password validation
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    //Adding done button to the keyboard
    private func addToolbarToTextFields() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(topDoneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [flexibleSpace, doneButton]
        
        emailTextField.inputAccessoryView = toolbar
        passwordTextField.inputAccessoryView = toolbar
    }
    
    // Navigate to Home Screen (Assume a HomeViewController exists)
    private func navigateToHomeScreen() {
        let homeVC = HomeViewController()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}

//MARK: PickerView Delegate
extension SignupViewController {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = viewModel.countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = viewModel.countries[row]
        label.textColor = .black
        label.textAlignment = .center
        return label
    }
}

//MARK: @objc functions
extension SignupViewController {
    
    @objc
    private func signupButtonTapped() {
        guard let email = emailTextField.text, isValidEmail(email) else {
            showAlert("Invalid Email", "Please enter a valid email address.")
            return
        }
        
        guard let password = passwordTextField.text, isValidPassword(password) else {
            showAlert("Invalid Password", "Password must have at least 8 characters, 1 uppercase, 1 number, and 1 special character.")
            return
        }
        
        AppDefaults.shared.countryName = selectedCountry
        AppDefaults.shared.email = email
        AppDefaults.shared.password = password
        AppDefaults.shared.loggedIn = true
        
        navigateToHomeScreen()
    }
    
    @objc
    private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        passwordToggleButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc
    private func topDoneButtonTapped() {
        if emailTextField.isFirstResponder {
            emailTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
    }
}

//MARK: TextField Delegates
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            signupButtonTapped()
        }
        return true
    }
}
