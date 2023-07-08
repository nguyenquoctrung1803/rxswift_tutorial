//
//  MainViewModel.swift
//  Swift_tutorial_RxSwift
//
//  Created by Trung Nguyễn Quốc on 07/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire



class MainViewModel {
    
    //MARK: - Properties
    var users = BehaviorSubject(value: [UserModel]())
    
    
    func fetchUsers(){
        let url = "http://localhost:3000/users"
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                do {
                    let jsondata = try JSONDecoder().decode([UserModel].self, from: data!)
                    self.users.on(.next(jsondata))
                }catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addUser (user: UserModel){
        guard var user = try? users.value() else {return}
        user.insert(contentsOf: user, at: 0)
        users.on(.next(user))
    }
    
    func editUser (title: String, index: Int){
        guard var user = try? users.value() else {return}
        user[index].title = title
        users.on(.next(user))
    }
    
    func deleteUser(index: Int) {
        guard var user = try? users.value() else {return}
        user.remove(at: index)
        users.on(.next(user))
    }
    
}
