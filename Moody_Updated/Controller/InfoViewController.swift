//
//  InfoViewController.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 13/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let sectionHeaders = ["Reset Hardware", "Rate Us", "Credits and Mentions"]
  let section1 = ["Recalibrate Device"]
  let section2 = ["Like Us on Facebook", "Rate Us on the App Store"]
  let section3 = ["Open Sourced Libraries Used"]
  override func viewDidLoad() {
    super.viewDidLoad()
    addNavbarItem()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
  }
  
  func addNavbarItem() {
    let barButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(navBarButtonPressed))
    barButtonItem.tintColor = .white
    navigationItem.leftBarButtonItem = barButtonItem
  }
  
  @objc func navBarButtonPressed() {
    dismiss(animated: true, completion: nil)
  }

}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionHeaders.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return section1.count
    }
    else if section == 1{
      return section2.count
    }
    else {
      return section3.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "aboutUsCell") as! AboutUsTableViewCell
    if indexPath.section == 0 {
      cell.heading.text = section1[indexPath.row]
    }
    else if indexPath.section == 1 {
      cell.heading.text = section2[indexPath.row]
    }
    else {
      cell.heading.text = section3[indexPath.row]
    }
    cell.selectionStyle = .none
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sectionHeaders[section]
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 2 {
      performSegue(withIdentifier: "creditsAndMentions", sender: self)
    }
  }
  
}
