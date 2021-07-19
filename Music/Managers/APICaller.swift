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
        case DELETE
        case PUT
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
//                    print("APICaller result is \(result)")
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
    
    public func getCurrentUserAlbum(completion:@escaping(Result<[Album],Error>)->Void) {
        createRequest(with:URL(string: Constants.baseAPIURL+"/me/albums"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(LibraryAlbumResponse.self, from: data)
                    completion(.success(result.items.compactMap({$0.album})))
//                    print(result)
                }
                catch{
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    public func saveAlbum(album:Album,completion:@escaping(Bool)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/me/albums?ids=\(album.id)"), type: .PUT) { baseRequest in
            var request = baseRequest
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data,response, error in
                guard let code = (response as? HTTPURLResponse)?.statusCode,error==nil else
                {
                    completion(false)
                    return
                }
                print(code)
                completion(code == 200)
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
    public func getCurrentUserPlaylist(completion:@escaping(Result<[Playlist],Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/me/playlists"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error == nil else{
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(LibraryPlaylistResponse.self, from: data)
                    completion(.success(result.items))
//                    print(result)
                }
                catch{
                    print(error)
                    completion(.failure(error ))
                }
            }
            task.resume()
        }
    }
    public func createPlaylist(with name:String,completion:@escaping(Bool)->Void){
        getCurrentUserProfile { [weak self] result in
            switch result{
            case .success(let profile):
                let urlString = Constants.baseAPIURL + "/users/\(profile.id)/playlists"
                print(urlString)
                self?.createRequest(with: URL(string: urlString ?? ""), type: .POST, completion: { baseRequest in
                    
                    var request = baseRequest
                    let json = [
                        "name":name
                    ]
                    print("Starting Creation")
                    request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                        guard let data = data , error==nil else{
                            print("resturing ")
                            completion(false)
                            return
                        }
                        do{
                            let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            print("Created \(result)")
                            if let response = result as? [String:Any],response["id"] as?String != nil  {
                                print("created")
                                completion(true)
                            }else{
                            completion(false)
                            }
                        }
                        catch{
                            print("failed to create it")
                            print(error.localizedDescription)
                            completion(false)
                        }
                    }
                    task.resume()
                })
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    public func addTrackToPlaylist(track:AudioTrack,playlist:Playlist,completion:@escaping(Bool)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/playlists/\(playlist.id)/tracks"), type: .POST) { baseRequest in
             var request = baseRequest
            let jsons = [
                "uris":["spotify:track:\(track.id)"]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: jsons, options: .fragmentsAllowed)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else{
                    completion(false)
                    return
                    
                }
                do{
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    if let response = result as? [String : Any] , response["snapshot_id"] as? String != nil{
                     completion(true)
                    }
                    else{
                        completion(false)
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completion(false)
                }
            }
            task.resume()
        }
    }
    public func removeTrackFromPlaylist(track:AudioTrack,playlist:Playlist,completion:@escaping(Bool)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/playlists/\(playlist.id)/tracks"), type: .DELETE) { baseRequest in
             var request = baseRequest
            let jsons = [
                "tracks":[[
                    "uri":"spotify:track:\(track.id)"
                ]]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: jsons, options: .fragmentsAllowed)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else{
                    completion(false)
                    return
                    
                }
                do{
                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    print(result)
                    if let response = result as? [String : Any] , response["snapshot_id"] as? String != nil{
                     completion(true)
                    }
                    else{
                        print(error?.localizedDescription)
                        completion(false)
                    }
                }
                catch{
                    print(error.localizedDescription)
                    completion(false)
                }
            }
            task.resume()
        }
    }
    
    //    MARK:- Categories
    public func getAllCategories(completion:@escaping(Result<[Category],Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/categories?limit=50"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(AllCategoriesResponse.self, from: data)
                    //print(result)
                    completion(.success(result.categories.items))
                }
                catch{
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    public func getCategoryPlaylist(category:Category,completion:@escaping(Result<[Playlist],Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL+"/browse/categories/\(category.id)/playlists?limit=20"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(CategoryPlaylistResponse.self, from: data)
                    //JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(.success(result.playlists.items))
                    //                    print(result)
                }
                catch{
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
    //    MARK:- Search
    public func searchQuery(with query:String,completion:@escaping(Result<[SearchResult],Error>)->Void){
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?limit=6&type=album,artist,playlist,track&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data,error==nil else
                {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    var searchResult = [SearchResult]()
                    searchResult.append(contentsOf: result.tracks.items.compactMap({.track(model: $0)}))
                    searchResult.append(contentsOf: result.artists.items.compactMap({.artist(model: $0)}))
                    searchResult.append(contentsOf: result.playlists.items.compactMap({.playlist(model: $0)}))
                    searchResult.append(contentsOf: result.albums.items.compactMap({.album(model: $0)}))
                    completion(.success(searchResult))
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
