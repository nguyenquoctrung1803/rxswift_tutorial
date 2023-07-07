//
//  LoginViewController.swift
//  Swift_tutorial_RxSwift
//
//  Created by Trung Nguyễn Quốc on 07/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation


class LoginViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    //MARK: - Properties
    let loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createObservable()
        
    }
    private func createObservable (){
        txtEmail.rx.text.map {$0 ?? ""}
            .bind(to: loginViewModel.emailField)
            .disposed(by: disposeBag)
        
        txtPassword.rx.text.map {$0 ?? ""}
            .bind(to: loginViewModel.passwordField)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid
            .bind(to: btnLogin.rx.isEnabled)
            .disposed(by: disposeBag)
    
        loginViewModel.isValid.subscribe(onNext: { [weak self] isValid in
            self?.btnLogin.backgroundColor = isValid ? .systemBlue : .red
            print(isValid)
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "ViewControlller") as! ViewController
        self.navigationController?.pushViewController(storyBoard, animated: true)
    }
    

}
