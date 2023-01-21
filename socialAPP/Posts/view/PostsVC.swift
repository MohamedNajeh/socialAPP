//
//  PostsVC.swift
//  socialAPP
//
//  Created by MohamedNajeh on 21/01/2023.
//

import UIKit

class PostsVC: UIViewController {

    @IBOutlet weak var noInternetLbl: UILabel!
    @IBOutlet weak var noInternetView: UIView!
    @IBOutlet weak var postsTableView: UITableView!
    
    var posts:Posts = []
    var viewModel = PostsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        addObservers()
        viewModel.fetchPosts()
        bindData()
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        if NetworkMonitor.shared.isConnected {
            handleConnectionView(isConnected:true)
            //viewModel.fetchPosts()
        } else {
            handleConnectionView(isConnected:false)
        }
    }
    
    func handleConnectionView(isConnected:Bool) {
            UserDefaults.standard.set(isConnected, forKey: "isConnected")
            print("connection \(isConnected)")
            DispatchQueue.main.async {
                self.noInternetView.backgroundColor = isConnected ? .green : .red
                self.noInternetLbl.text             = isConnected ? "Connected" : "Check your connection"
                self.noInternetView.isHidden        = false
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                    self.noInternetView.isHidden    = isConnected ? true : false
                }
            }
        }
    
    func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(showOfflineDeviceUI(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
    }
    
    func setUpTableView(){
        postsTableView.delegate = self
        postsTableView.dataSource = self
        postsTableView.register(UINib(nibName: "postCell", bundle: nil), forCellReuseIdentifier: "postCell")
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
        
        viewModel.posts.bind { [weak self] posts in
            guard let posts = posts else { return }
            self?.posts = posts
            DispatchQueue.main.async {
                self?.postsTableView.reloadData()
            }
        }
        
        viewModel.errorType.bind { [weak self] type in
            guard let type = type else { return }
            if type == .noInternet {
                self?.viewModel.getData()
            }
        }
    }

}

extension PostsVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! postCell
        cell.configureCell(post: posts[indexPath.row])
        cell.favBtn.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsVC
        vc.postID = posts[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
