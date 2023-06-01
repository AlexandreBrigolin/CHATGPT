//
//  ProfileService.swift
//  CHATGPT
//
//  Created by Barbara Brigolin on 01/06/23.
//

import UIKit
import Alamofire

protocol ProfileServiceDelegate: GenericService {
    func getProfileAlamofire(completion: @escaping completion<ProfileUser?>)
    func getProfileUrlSession(completion: @escaping completion<ProfileUser?>)
    func getProfileFromJson(completion: @escaping completion<ProfileUser?>)
    
}

class ProfileService: ProfileServiceDelegate{
    func getProfileAlamofire(completion: @escaping completion<ProfileUser?>) {
        
        let url: String = "https://run.mocky.io/v3/726c9de0-f9fb-4548-9652-888df48fb841"
        
        AF.request( url, method: .get).validate(statusCode: 200...299).responseDecodable(of: ProfileUser.self) { response in
            print(#function)
            debugPrint(response)
            
            switch response.result {
            case .success(let success):
                print("SUCCESS -> \(#function)")
                completion(success, nil)
            case .failure(let error):
                print("ERROR -> \(#function)")
                completion(nil, ErrorProfile.errorRequest(error))
            }
        }
    }
    
    func getProfileUrlSession(completion: @escaping completion<ProfileUser?>) {
        let urlString: String = "https://run.mocky.io/v3/726c9de0-f9fb-4548-9652-888df48fb841"
        
        guard let url: URL = URL(string: urlString) else { return completion (nil, ErrorProfile.errorDetail(detail: urlString)) }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let dataResult = data else { return completion(nil, ErrorProfile.errorDetail(detail: "Error Data"))}
            
            let json = try? JSONSerialization.jsonObject(with: dataResult, options: [])
            print(json as Any)
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                do {
                    let profileData: ProfileUser = try JSONDecoder().decode(ProfileUser.self, from: dataResult)
                    print("SUCCESS -> \(#function)")
                    completion(profileData, nil)
                } catch {
                    print("ERROR -> \(#function)")
                    completion(nil, error)
                }
            } else {
                print("ERROR -> \(#function)")
                completion(nil, error)
            }
            
        }
        task.resume()
        
    }
    
    func getProfileFromJson(completion: @escaping completion<ProfileUser?>) {
        if let url = Bundle.main.url(forResource: "userProfile", withExtension: "json"){
            do {
                let data = try Data(contentsOf: url)
                let menu: ProfileUser = try JSONDecoder().decode(ProfileUser.self, from: data)
                completion(menu, nil)
                print("SUCCESS -> \(#function)")
            }catch {
                completion(nil,ErrorProfile.fileDecodingFailed(name: "data", error))
                print("ERROR -> \(#function)")
            }
        }
    }
    
}
