//
//  MoodListViewController.swift
//  Mandala
//
//  Created by Edwin Cardenas on 6/13/25.
//

import UIKit

class MoodListViewController: UITableViewController {

    var moodEntries = [MoodEntry]()
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

        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(UITableViewCell.self),
            for: indexPath
        )

        let dateString = DateFormatter.localizedString(
            from: moodEntry.timestamp,
            dateStyle: .medium,
            timeStyle: .short
        )

        var content = UIListContentConfiguration.subtitleCell()
        content.text = "I was \(moodEntry.mood.name)"
        content.image = moodEntry.mood.image
        content.secondaryText = "on \(dateString)"

        cell.contentConfiguration = content

        return cell
    }
}
