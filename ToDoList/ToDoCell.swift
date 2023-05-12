//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Ion Sebastian Rodriguez Lara on 12/05/23.
//

import UIKit

protocol CellDelegate: AnyObject {
    func checkMarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    weak var delegate: CellDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var isCompleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeButtonTapped(_ sender: UIButton) {
        delegate?.checkMarkTapped(sender: self)
    }
}
