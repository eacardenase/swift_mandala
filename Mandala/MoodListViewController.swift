//
//  MoodListViewController.swift
//  Mandala
//
//  Created by Edwin Cardenas on 6/13/25.
//

import UIKit

class MoodListViewController: UITableViewController {

    var moodEntries = [MoodEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self)
        )
    }
}

// MARK: - UITableViewDataSource

extension MoodListViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return moodEntries.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let moodEntry = moodEntries[indexPath.row]

//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: NSStringFromClass(UITableViewCell.self))
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(UITableViewCell.self),
            for: indexPath
        )

        let dateString = DateFormatter.localizedString(
            from: moodEntry.timestamp,
            dateStyle: .medium,
            timeStyle: .short
        )
        
//        cell.textLabel?.text = "I was \(moodEntry.mood.name)"
//        cell.imageView?.image = moodEntry.mood.image
//        cell.detailTextLabel?.text = "on \(dateString)"
//        cell.selectionStyle = .none

        var content = UIListContentConfiguration.subtitleCell()
        content.text = "I was \(moodEntry.mood.name)"
        content.image = moodEntry.mood.image
        content.imageProperties.maximumSize = CGSize(width: 57, height: 57)
        content.secondaryText = "on \(dateString)"

        cell.selectionStyle = .none
        cell.contentConfiguration = content

        return cell
    }
}

// MARK: - MoodsConfigurable

extension MoodListViewController: MoodsConfigurable {
    func add(_ moodEntry: MoodEntry) {
        moodEntries.insert(moodEntry, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .fade)
    }
}
