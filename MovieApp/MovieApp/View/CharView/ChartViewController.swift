//
//  ChartViewController.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/01/07.
//

import UIKit
import SnapKit

class ChartViewController: UIViewController {
    
    let tableView = UITableView().then {
        $0.backgroundColor = UIColor(named: Colors.background)
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: identifiers.chart_table_cell)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Charts"
        self.view.backgroundColor = UIColor(named: Colors.background)
        
//        tableView.delegate = self
        tableView.dataSource = self
        
        
        //MARK: Draw UI
        
        tableView.backgroundColor = UIColor(named: Colors.background)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { $0.edges.equalTo(self.view.safeAreaLayoutGuide) }

    }
    
}

extension ChartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifiers.chart_table_cell, for: indexPath) as? ChartTableViewCell else { fatalError("Unable to dequeue ReminderCell") }
        // set the text from the data model
        cell.setSampleData(rank: indexPath.row)
        return cell
    }
    
    
}


#if DEBUG
import SwiftUI
struct ViewControllerRepresentable: UIViewControllerRepresentable {
    
func updateUIViewController(_ uiView: UIViewController,context: Context) {
        // leave this empty
}
@available(iOS 13.0.0, *)
func makeUIViewController(context: Context) -> UIViewController{
    ChartViewController()
    }
}
@available(iOS 13.0, *)
struct ViewControllerRepresentable_PreviewProvider: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerRepresentable()
                .ignoresSafeArea()
                .previewDisplayName(/*@START_MENU_TOKEN@*/"Preview"/*@END_MENU_TOKEN@*/)
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
        }
        
    }
} #endif
