//
//  CommonDateCoder.swift
//  KyivPost
//
//  Created by Anton Bal’ on 15.07.2020.
//  Copyright © 2020 KyivPost. All rights reserved.
//

import Foundation

final class CommonDateCoder: DateCoder {
    override class var formatter: DateCoderFormatter? {
        return DateFormatter.commonDateFormatter
    }
}
