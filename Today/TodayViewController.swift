//
//  TodayViewController.swift
//  Today
//
//  Created by sunny on 2017/6/30.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate lazy var dataSource: [String] = {
        let userdefault = UserDefaults(suiteName: "group.com.sunny.group")
        let list = (userdefault?.array(forKey: "com.sunny.todolist") ?? []) as! [String]
        return list
    }()
    
    fileprivate let identifier = "tableviewidentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.rowHeight = 60
        preferredContentSize = CGSize.zero
        
        
        
        // iOS10 添加折叠按钮
        if #available(iOSApplicationExtension 10.0, *) {
            extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            // iOS8 、iOS9 上需要自己添加折叠按钮
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.failed)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        // 由于 iOS8 、iOS9 上没有这个代理。需要对自己添加的按钮设置 target-action 然后进行修改
        switch activeDisplayMode {
        case .compact:
            preferredContentSize = maxSize
        case .expanded:
            preferredContentSize = CGSize(width: 0.0, height: 60 * CGFloat(dataSource.count))
        }
    }
    
}

// Today widget's User Interface
extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.extensionContext?.open(NSURL(string: "sunny://action=\(dataSource[indexPath.row])")! as URL, completionHandler: { (success) in
            print(success)
        })
    }
}
