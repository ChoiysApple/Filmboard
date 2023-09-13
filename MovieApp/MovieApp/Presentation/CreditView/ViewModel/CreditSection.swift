//
//  Credit.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/03/07.
//

import Foundation
import UIKit

struct ExternalLink {
    
    static let data = [
        ExternalLink(imageName: "developer", titleText: "Developer GitHub", detailText: "Developer info", url: "https://github.com/ChoiysApple"),
        ExternalLink(imageName: "github", titleText: "GitHub Repository", detailText: "Project repository is public on GitHub", url: "https://github.com/ChoiysApple/MVVMovie"),
        ExternalLink(imageName: "figma", titleText: "Design Reference", detailText: "Design inpired by figma community", url: "https://www.figma.com/community/file/1006119758184707289/Movie-Streaming-App")
    ]
    
    let imageName: String
    let titleText: String
    let detailText: String
    let url: String
}

enum CreditSection: Int, CaseIterable {
    case Reference, TechStack, DataSource
    
    var numberOfRows: Int {
        switch self {
        case .Reference: return ExternalLink.data.count
        case .TechStack: return 1
        case .DataSource: return 1
        }
    }
    
    var data: Any {
        switch self {
        case .Reference: return ExternalLink.data
        case .TechStack: return ["Tech Stack", """
                                 - RxSwift
                                 - MVVM
                                 - UIKit(Snapkit)
                                 - RxDataSources
                                 """]
        case .DataSource: return ["Movie Data", "The Movie DB API v3"]
        }
    }
    
}
