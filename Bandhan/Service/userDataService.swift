//
//  userDataService.swift
//  Bandhan
//
//  Created by Vivek on 7/16/25.
//

import Foundation
import Combine

class UserDataServices {
    
    @Published var userData: ProfilesData?
    var userSubscription: AnyCancellable?
    
    init(){
        getProfile()
    }
    
    func getProfile(){
        guard let url = URL(string: "")
        else{
            return
        }
        
        userSubscription = networkManager.download(url: url)
            .decode(type: ProfilesData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkManager.handelCompletion) { [weak self] returnedProfile in
                self?.userData = returnedProfile
                self?.userSubscription?.cancel()
            }
    }
}
