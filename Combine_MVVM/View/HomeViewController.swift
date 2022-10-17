//
//  HomeViewController.swift
//  Combine_MVVM
//
//  Created by admin on 17/10/2022.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    static func instance() -> HomeViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as! HomeViewController
        return vc
    }
    
    let viewModel = HomeViewModel()
    let cellViewModel = ListCellViewModel()
    @IBOutlet weak var searchtextField: UITextField!
    @IBOutlet weak var liststableView: UITableView!
    
    var subscriptions = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        onBind()

        
    }
    private func setupUI() {
        searchtextField.addTarget(self, action: #selector(didChangTextField(_:)), for: .editingChanged)
        setupTable()
        
    }
    
    private func onBind() {
        viewModel.reloadSearchUserPublisher
            .debounce(for: 0.35, scheduler: RunLoop.main)
            .sink(receiveValue: {self.liststableView.reloadData()}).store(in: &subscriptions)
        
    }
    @objc private func didChangTextField(_ textField: UITextField){
        if textField === searchtextField {
            viewModel.searchUserPublisher.send(textField.text ?? "")
        }
    }
    
    private func setupTable(){
        liststableView.delegate = self
        liststableView.dataSource = self
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListsTableViewCell
//        cell.lbName.text = viewModel.userForAt(indexPath.row)
        cell.lbName.attributedText = cellViewModel.setHigLight(searchtextField.text!, text: viewModel.userForAt(indexPath.row))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
