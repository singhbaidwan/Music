//
//  ProfileViewController.swift
//  Music
//
//  Created by Dalveer singh on 04/07/21.
//

import UIKit
import SDWebImage
class ProfileViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    private var models = [String]()
    
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        super.viewDidLoad()
        title = "Profile"
      fetchProfile()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func fetchProfile(){
        APICaller.shared.getCurrentUserProfile { [weak self]result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedToGetProfile()
                }
            }
        }
    }
    private func updateUI(with model:UserProfile){
        tableView.isHidden = false
        models.append("Full Name : \(model.display_name)")
        models.append("Email Address : \(model.email)")
        models.append("User Id: \(model.id)")
        models.append("Plan : \(model.product)")
        createTableHeader(with:model.images.first?.url)
        tableView.reloadData()
    }
    private func createTableHeader(with string:String?){
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        let imageSize:CGFloat = headerview.height/2
        let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerview.addSubview(imageview)
        imageview.center = headerview.center
        imageview.backgroundColor = .secondarySystemBackground
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = imageSize/2
        guard let urlString = string, let url = URL(string: urlString) else{
            imageview.image = UIImage(systemName: "person")
            tableView.tableHeaderView = headerview
            return }
      
        imageview.sd_setImage(with: url, completed: nil)
        tableView.tableHeaderView = headerview
    }
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        label.text = "Failed to Load Profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}
