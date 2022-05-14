//
//  ListVC.swift
//  PlayOTask
//
//  Created by sunil biloniya on 14/05/22.
//

import UIKit
import Alamofire
class ListVC: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var tblList: UITableView!
    // MARK: VARIABLES
    private var articleArray: [Article]?
    private let cellIdentifire = "ListTableCell"
    private let refreshControl = UIRefreshControl()
    
    private var isRefresh = false
    // MARK: VIEW LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadCells()
        self.pullRefresh()
        self.getList()
    }
    private func loadCells(){
        tblList.register(UINib(nibName: cellIdentifire, bundle: nil), forCellReuseIdentifier: cellIdentifire)
        tblList.dataSource = self
        tblList.delegate = self
        tblList.tableFooterView = UIView()
    }
    private func pullRefresh(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblList.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: Any) {
        isRefresh = true
        self.getList()
        
    }
}
// MARK: UITABLEVIEW DATASOURCE
extension ListVC : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath) as! ListTableCell
        cell.getConfige(articleArray?[indexPath.row])
        return cell
    }
}

// MARK: UITABLEVIEW DELEGATE
extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = articleArray?[indexPath.row].url {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
            vc.url = url
            self.show(vc, sender: nil)
        }
       
    }
}

// MARK: API METHODS
extension ListVC {
    private func getList() {
        if !Reachability.isConnectedToNetwork(){
            print("Please check your net conection.")
            return
        }
        
        if isRefresh == false {
            self.startLoading()
        }
        var url:String!
        url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=d37631430874456ca3166fff9115496d"
        
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result{
            case .success(let json):
                DispatchQueue.main.async {
                    self.stopLoading()
                    self.refreshControl.endRefreshing()
                    print(response)
                    if let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                        do {
                            let jsonDecoder = JSONDecoder()
                            let user = try jsonDecoder.decode(ListModel.self, from: jsonData)
                            self.articleArray = user.articles
                            self.tblList.reloadData()
                        } catch (let error){
                            print(error)
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
