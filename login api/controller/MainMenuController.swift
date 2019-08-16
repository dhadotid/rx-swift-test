//
//  MainMenuController.swift
//  login api
//
//  Created by Yudha on 10/05/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainMenuController : UIViewController {
    
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnSampleTableView: UIButton!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblText.contentMode = .scaleToFill
        lblText.numberOfLines = 0
        if PreferenceManager.instance.email != nil {
            self.lblText.text = "Email: " + PreferenceManager.instance.email!
        }
        
        onLogoutClicked()
        onSampleTableViewClicked()
    }
    
    static func instantiateNav() -> UINavigationController {
        let controller = StoryboardManager.instance.main.instantiateViewController(withIdentifier: "DetailAkunNav") as! UINavigationController
        print("masuk detail")
        return controller
    }
    
    func onLogoutClicked(){
        btnLogout.rx.tap
            .bind{
                PreferenceManager.instance.token = nil
                PreferenceManager.instance.email = nil
                
                let controller = StoryboardManager.instance.main.instantiateViewController(withIdentifier: "LoginStoryBoard") as! LoginController
                self.present(controller, animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
    }
    
    func onSampleTableViewClicked(){
        btnSampleTableView.rx.tap
            .bind{
                let controller = StoryboardManager.instance.main.instantiateViewController(withIdentifier: "SampleTableStoryBoard") as! SimpleTableViewController
                self.present(controller, animated: true, completion: nil)
        }
        .disposed(by: disposeBag)
    }
}
