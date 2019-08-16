//
//  SimpleTableView.swift
//  login api
//
//  Created by yudha on 14/08/19.
//  Copyright © 2019 Yudha. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SimpleTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let disposeBag = DisposeBag()
    var items: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addData()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func addData(){
        for i in 1...20 {
            self.items.append("Value ke-\(i)")
        }
        self.items.remove(at: 9)
        self.items[9] = "Item 10 dan 11 hilang"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
//        cell.preservesSuperviewLayoutMargins = false
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        let actions: [UIAlertController.AlertAction] = [
            .action(title: "No", style: .destructive),
            .action(title: "Yes")
        ]
        
        UIAlertController.present(in: self, title: "You selected cell #\(indexPath.row)!", message: "Value you select: \(items[indexPath.row])", style: .alert, actions: actions)
            .subscribe(onNext: { buttonIndex in
                print(buttonIndex)
            })
            .disposed(by: disposeBag)
    }
}
