//
//  Credit.swift
//  MovieApp
//
//  Created by Daegeon Choi on 2022/03/07.
//

import Foundation

struct Credit {
    
    static let data = [
        Credit(imageName: "github", titleText: "Repository", detailText: "Project repository is public on GitHub"),
        Credit(imageName: "figma", titleText: "Design Reference", detailText: "Design inpired by figma community")
    ]
    
    let imageName: String
    let titleText: String
    let detailText: String
}
