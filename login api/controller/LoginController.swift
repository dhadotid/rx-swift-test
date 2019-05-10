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
import PKHUD

class LoginController : UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    let interactor = UserInteractor()
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
            .flatMap{ (arg) -> Observable<User> in
                let (email, password) = arg
                return self.interactor.signIn(email: email!, password: password!)
            }
            .do( onNext: { user in
                if let fullname = user.user_id {
                    print("Masuk")
                    
                    var j = fullname
                    if let n = user.full_name {
                        j = n
                    }
                    print(j)
                    HUD.flash(.success, delay: 2)
                    
                    let controller = MainMenuController.instantiateNav()
                    self.present(controller, animated: true, completion: nil)
                }
            }, onError: { errorType in
                let error = errorType as NSError
                print("error : \(error.localizedDescription)")
                HUD.flash(.error, delay: 2)
                
            })
        .retry()
        .subscribe()
        .disposed(by: disposeBag)
//            .bind{ (email, password) in
//                print("email: " + email! + "\npassword: "+password!)
//
//                let alert = UIAlertController(title: "Output", message: "Email: " + email! + "\nPassword: " + password!, preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
//                    print("This is OK Button Action")
//                }))
//                self.present(alert, animated: true)
//            }.disposed(by: disposeBag)
    }
}
