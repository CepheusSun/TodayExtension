//
//  TodoCell.swift
//  Extension
//
//  Created by sunny on 2017/6/30.
//  Copyright © 2017年 CepheusSun. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    class func cell(with tableview:UITableView!) -> TodoCell {
        var cell  = tableview.dequeueReusableCell(withIdentifier: "TodoCell")
        if cell == nil {
            cell = Bundle.main.loadNibNamed("TodoCell", owner: nil, options: nil)?.first as? TodoCell
        }
        return cell as! TodoCell
    }
    
}
