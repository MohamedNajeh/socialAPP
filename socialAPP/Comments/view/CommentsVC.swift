//
//  CommentsVC.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import UIKit

class CommentsVC: UIViewController {

    @IBOutlet weak var commentsTableView: UITableView!
    var comments:Comments = []
    var viewModel = CommentsViewModel()
    var postID:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        viewModel.fetchCommnts(postID: postID ?? 0)
        bindData()
        // Do any additional setup after loading the view.
    }
    
    func setUpTableView(){
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.register(UINib(nibName: "postCell", bundle: nil), forCellReuseIdentifier: "postCell")
    }
    
    func bindData(){
        
        viewModel.isLoading.bind { [weak self] isLoading in
            switch isLoading {
            case true:
                self?.showLoadingView()
            case false:
                self?.hideLoadingView()
            }
        }
        
        viewModel.comments.bind { [weak self] comments in
            guard let comments = comments else { return }
            self?.comments = comments
            DispatchQueue.main.async {
                self?.commentsTableView.reloadData()
            }
        }
    }
}

extension CommentsVC:UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postCell
        cell.configureCell(comment: comments[indexPath.row])
        return cell
    }
}
