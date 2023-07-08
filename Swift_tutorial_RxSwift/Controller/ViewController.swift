//
//  ViewController.swift
//  Swift_tutorial_RxSwift
//
//  Created by Trung Nguyễn Quốc on 07/07/2023.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    let mainViewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    let nib = UINib(nibName: "UserCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        let add = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(onTapAddButton))
        self.navigationItem.rightBarButtonItem = add
        mainViewModel.fetchUsers()
        bindTableView()
    }
    
    @objc func onTapAddButton () {
        let alert = UIAlertController(title: "Add", message: "Add User", preferredStyle: .alert)
        alert.addTextField { textField in
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {action in
            let textField = (alert.textFields![0]) as UITextField
            print(textField.text ?? "")
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
        
    }
    
    
    func bindTableView(){
        mainViewModel.users.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UserCell.self)) { row, element, cell in
            cell.label.text = element.title
            cell.labelDetail.text = String(element.id)
        }.disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.subscribe(onNext: {indexPath in
            print(indexPath.row)
            let alert = UIAlertController(title: "Note", message: "Edit Note", preferredStyle: .alert)
            alert.addTextField{ textFiled in
                
            }
            
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: {action in
                let textField = (alert.textFields![0]) as UITextField
                self.mainViewModel.editUser(title: textField.text ?? "", index: indexPath.row)
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true)
            }
            
        }).disposed(by: disposeBag)
        
        tableView.rx.itemDeleted.subscribe(onNext: {[weak self] index in
            guard let self = self else {return}
            self.mainViewModel.deleteUser(index: index.row)
        }).disposed(by: disposeBag)
    }

}

//MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate {
    
}


