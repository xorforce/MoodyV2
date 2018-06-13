//
//  LibraryViewController.swift
//  Moody_Updated
//
//  Created by Bhagat  Singh on 13/06/18.
//  Copyright © 2018 Bhagat Singh. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  let libraries = ["ChromaColorPicker", "Hue", "SwiftMQTT", "BRYXBanner"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
  }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return libraries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell", for: indexPath) as! AboutUsTableViewCell
    cell.heading.text = libraries[indexPath.row]
    return cell
  }
}

