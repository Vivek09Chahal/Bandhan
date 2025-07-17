//
//  profileDataServices.swift
//  Bandhan
//
//  Created by Vivek on 7/14/25.
//

import Foundation
import Combine

class profileDataServices: ObservableObject {
    
    @Published var allProfiles: [ProfilesData] = []
    var profileSubscription: AnyCancellable?
    
    init(){
        getProfiles()
    }
    
    // MARK: - getting data
    func getProfiles(){
        guard let url = URL(string: "http://demo7592193.mockable.io/Profiles")
        else {
            return
        }
        
        profileSubscription = networkManager.download(url: url)
            .decode(type: [ProfilesData].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkManager.handelCompletion, receiveValue: { [weak self] returnedProfiles in
                self?.allProfiles = returnedProfiles
                self?.profileSubscription?.cancel()
            })
    }
}
