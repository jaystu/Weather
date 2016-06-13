//
//  HourTableViewController.swift
//  Weather
//
//  Created by John Stuart on 6/12/16.
//  Copyright © 2016 John Stuart. All rights reserved.
//

import UIKit

class HourTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hours.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "HourTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! HourTableViewCell

        // Configure the cell...
        //cell.selectionStyle = .None
        let hour = hours[indexPath.row]
        // hour
        let dateFormatterForHour = NSDateFormatter()
        dateFormatterForHour.dateFormat = "ha"
        dateFormatterForHour.AMSymbol = "AM"
        dateFormatterForHour.PMSymbol = "PM"
        let dateString = dateFormatterForHour.stringFromDate(hour.time)
        cell.hourLabel.text = dateString
        // icon
        if let image = UIImage(named: hour.icon) {
            cell.icon.image = image
        } else {
            cell.icon.image = UIImage(named: "question-mark")
        }
        // temperature
        let index = hour.temperature.startIndex
        var temperatureString = hour.temperature.substringToIndex(index.advancedBy(2))
        temperatureString.append("\u{00B0}" as Character)
        cell.temperatureLabel.text = temperatureString

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
