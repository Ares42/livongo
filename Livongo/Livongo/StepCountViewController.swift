//
//  StepCountViewController.swift
//  Livongo
//
//  Created by Luke Solomon on 7/20/20.
//  Copyright © 2020 Observatory. All rights reserved.
//

import UIKit
import HealthKit

class StepCountViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  
  var samples = [HKQuantitySample]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.dataSource = self
    
    // Do any additional setup after loading the view.
    HealthDataManager.shared.requestAuthorization(completion: { (result) in
      if result {
        print("Requesting Authorization Succeeded")
        
        HealthDataManager.shared.getStepCounts { (result) in
          do {
            let samples = try result.get()
            print("HealthData fetching steps Succeeded: \(samples)")
            self.samples = samples
            
            DispatchQueue.main.async {
              self.tableView.reloadData()
            }
          } catch {
            print("HealthData fetching steps failed")
          }
        }
      } else {
        print("Requesting Authorization Failed")
      }
    })
  }
  
  @IBAction func segmentedControlTapped(_ sender: Any) {
    self.segmentedControl.isUserInteractionEnabled = false
    
    self.samples.reverse()
    DispatchQueue.main.async {
      self.tableView.reloadData()
      self.segmentedControl.isUserInteractionEnabled = true
    }
  }
}

extension StepCountViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return samples.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StepCell", for: indexPath) as! StepCountTableViewCell
    
    let viewModel = StepCountCellViewModel(sample: samples[indexPath.row])
    
    cell.configure(viewModel: viewModel)
    
    return cell
  }
}
