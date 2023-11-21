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
    case reference, techStack, dataSource
    
    var numberOfRows: Int {
        switch self {
        case .reference: return ExternalLink.data.count
        case .techStack: return 1
        case .dataSource: return 1
        }
    }
    
    var data: Any {
        switch self {
        case .reference: return ExternalLink.data
        case .techStack: return ["Tech Stack", """
                                 - RxSwift
                                 - MVVM
                                 - UIKit(Snapkit)
                                 - RxDataSources
                                 """]
        case .dataSource: return ["Movie Data", "The Movie DB API v3"]
        }
    }
    
}
