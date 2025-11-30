//
//  HeartRateDto.swift
//  SwiftUiProjectWithComponent
//
//  Created by Gaurav Bhatt on 18/11/25.
//

import Foundation

struct HeartRateDto: Identifiable {
    var id = UUID()
    
    let dataUuid: String
    let deviceUuid: String
    let comment: String
    let startTime: Int64
    let endTime: Int64
    let updateTime: Int64
    let timeOffset: Int64
    let min: Int
    let max: Int
    let heartRate: Int
    let average: Int
    let binningData: Data
    let alertHeartRate: Bool
}
