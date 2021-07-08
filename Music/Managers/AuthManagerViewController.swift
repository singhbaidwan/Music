//
//  AuthManagerViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import Foundation

final class AuthManager{
    static let shared = AuthManager()
    private init(){}
    
    struct Constants{
        static let clientID = "1a28cbf77da14285bc2fdddf30cd21d1"
        static let clientSecret = "4606beaf82784c4284c78cd8b2326755"
        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
        static  let redirect = "https://spotify.com"
        static let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    
    public var signInUrl:URL?{
        let base = "https://accounts.spotify.com/authorize"
        
       
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(Constants.scope)&redirect_uri=\(Constants.redirect)&show_dialog=TRUE"
        return URL(string: string)
    }
    var isSignedIn:Bool{
        return accessToken != nil
        
    }
     
    private var accessToken:String?{return UserDefaults.standard .string(forKey: "access_token")}
    private var refreshToken:String?{return UserDefaults.standard.string(forKey: "refresh_token")}
    private var expirationDate:Date?{return UserDefaults.standard.object(forKey: "expirationDate") as? Date}
    private var shouldRefreshToken:Bool{
        guard let expirationDate = expirationDate else{
            return false
        }
        let currDate = Date()
        let timeInterval:TimeInterval = 300
        return currDate.addingTimeInterval(timeInterval)>=expirationDate
        
    }
    
    public func exchangeCodeForToken(code:String,completion: @escaping((Bool)->Void)){
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
        var componet = URLComponents()
        componet.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Constants.redirect)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64 = data?.base64EncodedString() else{
           completion(false)
            print("Failed to get base 64")
            return
        }
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        request.httpBody = componet.query?.data(using: .utf8)
        let task  =   URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data,error==nil else
            {
                completion(false)
                return
            }
            do{
                let json = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result:json )
                print(json)
                print("Json success \(json)")
                 completion(true)
            }
            catch{
                print("Error occur")
                completion(false)
            }
        }
        task.resume()
    }
    
    
    
    
    public func refreshAccessTokenIfNeeded(completion:@escaping(Bool)->Void){
//        guard shouldRefreshToken else
//        {
//            completion(true)
//            return
//        }
        
        guard let refreshToken = self.refreshToken else{
            completion(false)
            return
        }
        // do refreshing the token
        guard let url = URL(string: Constants.tokenAPIURL) else{
            return
        }
        var componet = URLComponents()
        componet.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        let basicToken = Constants.clientID+":"+Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64 = data?.base64EncodedString() else{
           completion(false)
            print("Failed to get base 64")
            return
        }
        request.setValue("Basic \(base64)", forHTTPHeaderField: "Authorization")
        request.httpBody = componet.query?.data(using: .utf8)
        let task  =   URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data,error==nil else
            {
                completion(false)
                return
            }
            do{
                let json = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Done refreshing ")
                self.cacheToken(result:json )
                print("Json success \(json)")
                 completion(true)
            }
            catch{
                print("Error occur")
                completion(false)
            }
        }
        task.resume()
        
    }
    private func cacheToken(result:AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refresh_token = result.refresh_token {
            UserDefaults.standard.setValue(refresh_token, forKey: "refresh_token")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}
