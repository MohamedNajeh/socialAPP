//
//  CommentsViewModel.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import Foundation
protocol CommentsViewModelProtocol {
    func fetchCommnts(postID:Int)
    func setError(_ message: ErrorMessages)
    var comments: Observable<Comments?> { get  set } //1
    var errorMessage: Observable<ErrorMessages?> { get set }
    var error: Observable<Bool> { get set }
    var isLoading: Observable<Bool> { get set }
}

class CommentsViewModel : CommentsViewModelProtocol{
   
    
    var comments: Observable<Comments?>           = Observable(nil)
     
    var errorMessage: Observable<ErrorMessages?>  = Observable(nil)
    
    var error: Observable<Bool>                   = Observable(false)
    
    var isLoading: Observable<Bool>               = Observable(false)
    
    var api:CommentsAPIProtocol?
    
    init(apiService:CommentsAPIProtocol = CommentsAPI()){
        api = apiService
    }
    
    func fetchCommnts(postID:Int) {
        self.isLoading.value = true
        api?.getComments(postID: postID, completion: { [weak self] response in
            self?.isLoading.value = false
            switch response {
            case .success(let comments):
                self?.comments.value = comments
            case .failure(let error):
                self?.setError(error)
            }
        })
    }
    
    func setError(_ message: ErrorMessages) {
        self.errorMessage.value = message
        self.error.value        = true
    }
    
}
