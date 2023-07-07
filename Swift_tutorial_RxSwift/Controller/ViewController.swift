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
        mainViewModel.fetchUsers()
        bindTableView()
    }
    
    
    func bindTableView(){
        
        mainViewModel.users.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UserCell.self)) { row, element, cell in
            cell.items = element
        }.disposed(by: disposeBag)
    }

}

//MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}


