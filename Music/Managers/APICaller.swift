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
    
    
    // getting all new releases
    public func getNewAllReleases(completion:@escaping(Result<NewReleasesResponse,Error>)->Void){
        createRequest(with: URL(string:Constants.baseAPIURL + "/browse/new-releases?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error==nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                    
                }
                do{
                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
                    completion(.success(result))
                }
                catch
                {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // gettting Featured Playlist
    
    public func getFeaturedPlaylist(completion:@escaping(Result<FeaturedPlaylistResponse,Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/featured-playlists?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error==nil else {
                    print("Error is \(error)")
                    completion(.failure(APIError.failedToGetData))
                    return
                    
                }
                do{
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(FeaturedPlaylistResponse.self, from: data)
                    completion(.success(result))
                }
                catch
                {
                    print("Error is \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
        
    }
    
    
    // Get Recommendation Genres
    public func getRecommendationGenres(completion:@escaping((Result<RecommendationGenres,Error>)->Void)){
        createRequest(with: URL(string: Constants.baseAPIURL+"/recommendations/available-genre-seeds"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error==nil else {
                    completion(.failure(APIError.failedToGetData))
                    return

                }
                do{
                    let result = try JSONDecoder().decode(RecommendationGenres.self, from: data)
                    completion(.success(result))

                }
                catch
                {
                    completion(.failure(error))
                }
            }
            task.resume()

        }
    }
    
    
    
    
    
    // Get Recommendations
    public func getRecommendations(genres:Set<String>,completion:@escaping((Result<RecommendationReponse,Error>)->Void)){
        let seeds = genres.joined(separator: ",")
        createRequest(with: URL(string: Constants.baseAPIURL+"/recommendations?limit=40&seed_genres=\(seeds)"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error==nil else {
                    completion(.failure(APIError.failedToGetData))
                    return

                }
                do{
                    let result = try JSONDecoder().decode(RecommendationReponse.self, from: data)
                   
                    completion(.success(result))

                }
                catch
                {
                    completion(.failure(error))
                }
            }
            task.resume()

        }
    }
    
}

extension APICaller{
//    MARK:- Album
    public func getAlbumDetails(album:Album,completion:@escaping(Result<AlbumDetailResponse,Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/"+album.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AlbumDetailResponse.self,from: data)
                    completion(.success(result))
                }
                catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
//    MARK:- Playlist
    public func getPlaylistDetails(for playlist:Playlist,completion:@escaping(Result<PlaylistDetailResponse,Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/"+playlist.id), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(PlaylistDetailResponse.self, from: data)
                    completion(.success(result))
                }
                catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
}
