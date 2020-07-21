//
//  StepCountTableViewCell.swift
//  Livongo
//
//  Created by Luke Solomon on 7/20/20.
//  Copyright © 2020 Observatory. All rights reserved.
//

import UIKit
import HealthKit

struct StepCountCellViewModel {
  
  var stepCount: String
  var date:String
  
  init(sample: HKQuantitySample) {
    //      print("Samples: \(samples)")
    //      for sample in samples {
    //        stepResults.append(sample.quantity.doubleValue(for: .count()))
    //        print("Sample:\(sample)")
    //        dates.append(sample.startDate)
    //        print("Sample Double Value: \(sample.quantity.doubleValue(for: .count()))")
    //        // Process each sample here.
    //      }
    
    self.stepCount = String(sample.quantity.doubleValue(for: .count()))
    
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEE, MMM d, yyyy"
    
    self.date = formatter.string(from: sample.startDate) //TODO: Use a dateformatter here
  }
  
}




class StepCountTableViewCell: UITableViewCell {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var stepCountLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func configure(viewModel:StepCountCellViewModel) {
    self.stepCountLabel.text = viewModel.stepCount
    self.dateLabel.text = viewModel.date
  }
  
}
