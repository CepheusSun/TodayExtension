//
//  ViewController.swift
//  Extension
//
//  Created by sunny on 2017/6/30.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let userdefaultKey = "com.sunny.todolist"
    
    static let userdefault = UserDefaults(suiteName: "group.com.sunny.group")
    
    let disposeBag = DisposeBag()
    fileprivate lazy var dataSource: [String] = {
        guard let arr = userdefault?.array(forKey: self.userdefaultKey) else {
            return []
        }
        return arr as! [String]
    }()
    
    fileprivate let identifier = "tableviewidentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.tableFooterView = UIView()
    }

    @IBAction func addItem(_ sender: Any) {
        let alert = UIAlertController(title: "添加任务", message: "请输入你要添加的任务", preferredStyle: .alert)
        let todo = Variable<String?>("")
        alert.addTextField {
            [unowned self, todo] (textField) in
            textField.rx.text.bind(to: todo).addDisposableTo(self.disposeBag)
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: {
            [unowned self, todo] (action) in
            self.dataSource.append(todo.value!)
            self.tableView.reloadData()
            ViewController.userdefault?.set(self.dataSource, forKey: self.userdefaultKey)
            print(self.dataSource)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = .none
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if  editingStyle == .delete {
            dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ViewController.userdefault?.set(self.dataSource, forKey: self.userdefaultKey)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = UIViewController()
        detailViewController.view.backgroundColor = UIColor.white
        detailViewController.title = dataSource[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}



