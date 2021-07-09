//
//  APICallerViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    private init(){}
    struct Constants{
        static let baseAPIURL = "https://api.spotify.com/v1"
        
    }
    
    enum HTTPMethod:String{
        case GET
        case POST
    }
    enum APIError:Error{
        case failedToGetData
        
    }
    public func getCurrentUserProfile(completion:@escaping(Result<UserProfile,Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/me"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data=data,error==nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                
                }
                do{
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print("APICaller result is \(result)")
                    completion(.success(result))
                }
                catch{
                    print("API caller error \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
            
        }
    }
    
    private func createRequest(with url:URL?,type:HTTPMethod,completion:@escaping(URLRequest)->Void){
        AuthManager.shared.withValidToken { token  in
            guard let apiUrl = url else{
                return
            }
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
    
    
}
