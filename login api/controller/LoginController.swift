//
//  LoginController.swift
//  login api
//
//  Created by Yudha on 07/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class LoginController : UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSignInStream()
    }
    
    func setupSignInStream(){
        
        let signInForm = Observable.combineLatest(txtEmail.rx.text, txtPassword.rx.text){
            email, password in
            return (email: email, password: password)
        }
        
        setupEmailSignInWithStreams(formStream: signInForm, button: btnLogin)
    }
    
    func setupEmailSignInWithStreams(formStream: Observable<(email: String?, password: String?)>, button: UIButton){
        button.rx.tap
            .withLatestFrom(formStream)
            .filter{ (email, password) -> Bool in
                if (email?.isEmpty)! || (password?.isEmpty)!{
                    print("show pop up here!")
                    return false
                }else {
                    return true
                }
            }
            .bind{ (email, password) in
                print("email: " + email! + "\npassword: "+password!)
            }.disposed(by: disposeBag)
    }
}
