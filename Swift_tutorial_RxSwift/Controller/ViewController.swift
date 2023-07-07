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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        mainViewModel.fetchUsers()
        bindTableView()
    }
    
    
    func bindTableView(){
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        mainViewModel.users.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = element.title
            cell.detailTextLabel?.text = "\(element.id)"
            
        }.disposed(by: disposeBag)
    }

}

//MARK: - TableViewDelegate

extension ViewController: UITableViewDelegate {
    
}


