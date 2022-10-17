//
//  HomeViewModel.swift
//  Combine_MVVM
//
//  Created by admin on 17/10/2022.
//

import Foundation
import Combine
final class HomeViewModel {
    let searchUserPublisher = PassthroughSubject<String, Never>()
    let reloadSearchUserPublisher = PassthroughSubject<Void, Never>()
    var subscriptions = Set<AnyCancellable>()
    let users: [String] = ["long", "Trường", "Truong", "nam", "Tuấn", "Tuan"]
    var seachUser:[String] = []
    
    init() {
        seachUser = users
        
        searchUserPublisher.sink { search in
            let upcasedSearch = search.folding(options: .diacriticInsensitive, locale: nil).uppercased()
            if search.isEmpty {
                self.seachUser = self.users
            }
            else{
                self.seachUser = self.users.filter{$0.folding(options: .diacriticInsensitive, locale: nil)
                                                     .uppercased()
                                                     .contains(upcasedSearch)}
         }
        self.reloadSearchUserPublisher.send(())
        }.store(in: &subscriptions)
}
    
    
    func numberOfRows() -> Int {
        return seachUser.count
    }
    
    
    func userForAt(_ index: Int) -> String {
        return seachUser[index]
    }
    

}
