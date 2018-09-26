//
//  DetailViewController.swift
//  NYC Schools
//
//  Created by Brian Makuch on 9/25/18.
//  Copyright © 2018 Brian Makuch. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var neighborhoodLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var numTestTakersLabel: UILabel!
    @IBOutlet weak var avgReadingScoreLabel: UILabel!
    @IBOutlet weak var avgWritingScoreLabel: UILabel!
    @IBOutlet weak var avgMathScoreLabel: UILabel!
    
    var schoolInfo = NYCSchoolDetail() {
        didSet {
            // Update the view.
            configureSchoolInfo()
        }
    }

    var scoreInfo = NYCSchoolSATResults() {
        didSet {
            // Update the view.
            configureScoreInfo()
        }
    }

    func configureView() {
        print("configure view")
        // Clear contents of labels to be retrieved
        clearLabels()
        
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = schoolNameLabel {
                label.text = detail.name
            }
            if let label = neighborhoodLabel {
                label.text = detail.neighborhood
            }
            retrieveSchoolDetail(detail.id)
            retrieveSATDetail(detail.id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NYCSchoolSummary? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    func retrieveSchoolDetail(_ id: String) {
        DataAccess.getSchoolInfo(for: id, completion: { (result) in
            switch result {
            case .success(let schoolResults):
                self.schoolInfo = schoolResults
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
    
    func retrieveSATDetail(_ id: String) {
        DataAccess.get2012SATResults(for: id, completion: { (result) in
            switch result {
            case .success(let scoreResults):
                self.scoreInfo = scoreResults
            case .failure(let error):
                print("error: \(error)")
            }
        })
    }
    
    func clearLabels() {
        if let label = schoolNameLabel {
            label.text = " "
        }
        if let label = neighborhoodLabel {
            label.text = " "
        }
        if let label = summaryLabel {
            label.text = " "
        }
        if let label = numTestTakersLabel {
            label.text = " "
        }
        if let label = avgReadingScoreLabel {
            label.text = " "
        }
        if let label = avgWritingScoreLabel {
            label.text = " "
        }
        if let label = avgMathScoreLabel {
            label.text = " "
        }
    }
    
    func configureSchoolInfo() {
        if let label = schoolNameLabel {
            label.text = schoolInfo.name
        }
        if let label = neighborhoodLabel {
            label.text = schoolInfo.neighborhood
        }
        if let label = summaryLabel {
            label.text = schoolInfo.summary
        }
    }
    
    func configureScoreInfo() {
        if let label = numTestTakersLabel {
            label.text = scoreInfo.numTakers
        }
        if let label = avgReadingScoreLabel {
            label.text = scoreInfo.avgReadingScore
        }
        if let label = avgWritingScoreLabel {
            label.text = scoreInfo.avgWritingScore
        }
        if let label = avgMathScoreLabel {
            label.text = scoreInfo.avgMathScore
        }
    }

}

