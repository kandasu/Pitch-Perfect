//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Kan Matsuura on 9/28/15.
//  Copyright (c) 2015 Kan Matsuura. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL
    var title: String
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
