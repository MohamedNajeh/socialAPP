//
//  postsViewModel.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation

protocol PostsViewModelProtocol {
    func fetchPosts()
    func setError(_ message: ErrorMessages)
    var posts: Observable<Posts?> { get  set } //1
    var errorMessage: Observable<ErrorMessages?> { get set }
    var error: Observable<Bool> { get set }
    var errorType: Observable<ErrorMessages?> { get set }
    var isLoading: Observable<Bool> { get set }
}

class PostsViewModel : PostsViewModelProtocol{
   
    
    var posts: Observable<Posts?>                  = Observable(nil)
     
    var errorMessage: Observable<ErrorMessages?>   = Observable(nil)
    
    var errorType: Observable<ErrorMessages?>      = Observable(nil)
    
    var error: Observable<Bool>                    = Observable(false)
    
    var isLoading: Observable<Bool>                = Observable(false)
    
    var api:PostsAPIProtocol?
    
    init(apiService: PostsAPIProtocol = PostsAPI()){
        self.api = apiService
    }
    
    func fetchPosts() {
        self.isLoading.value = true
        api?.getPosts(completion: { response in
            self.isLoading.value = false
            switch response {
            case .success(let posts):
                self.posts.value = posts
                self.saveData(posts: posts ?? [])
            case .failure(_):
                self.setError(.invalidResponse)
            }
        })
    }
    
    func setError(_ message: ErrorMessages) {
        self.errorMessage.value = message
        self.errorType.value    = message
        self.error.value        = true
    }
    
    func saveData(posts:Posts){
         do {
             let encoder = JSONEncoder()
             let data = try encoder.encode(posts)
             UserDefaults.standard.set(data, forKey: "posts")
         } catch {
             // Fallback
             self.setError(.errorSavingDataLocally)
         }
     }
     
     func getData(){
         guard let data = UserDefaults.standard.data(forKey: "posts") else {
             return
         }
         do {
             let decoder = JSONDecoder()
             let posts = try decoder.decode(Posts.self, from: data)
             self.posts.value = posts
         } catch {
             // Fallback
             self.setError(.errorRetivingFromLocal)
         }
     }
}
