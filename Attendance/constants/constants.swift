//
//  constants.swift
//  locksmith-user
//
//  Created by Dhruv Rawat on 12/12/24.
//

import Foundation
import MobileCoreServices
import UniformTypeIdentifiers
import UIKit




struct StoryBoardConstants {
    static let kMain = "Main"
}

struct ColorConstants {
    
    static let kBlue = "Blue"                       // #5088FB
    static let kHintText = "HintText"               // #5C657D
    static let kHintBorder = "HintBorder"           // #5C657D  50%
    static let kShadow = "Shadow"                   // #D9D9D9
    static let kBlack = "Black"                     // #000000
    static let kRedDark = "RedDark"                 // #9F041B
    static let kRedLight = "RedLight"               // #FFE9EC
    static let kMint = "Mint"                       // #E9F3FF
    static let kMintLight = "MintLight"             // #6581A0  46%
    static let kWhite = "White"
    static let kYellowDark = "YellowDark"           // #E99A24
    static let kYellowLight = "YellowLight"         // #FFFBD8
    static let kRed = "Red"                         // #F5515F
    static let kGreenDark = "GreenDark"             // #049F32
    static let kGreenGradient = "GreenGradient"     // #F5FFEC
    static let kBlueGradient = "BlueGradient"       // #F0F9FF
    static let kOrange = "Orange"
    static let kBlueLight = "BlueLight"             // #DDF0FF
    static let kGreyLight = "GreyLight"             // #F7F7F7
    static let kStarFilled = "StarFilled"
    
    
    static let kRejectedDark = "RejectedDark"
    static let kRejectedLight = "RejectedLight"
    static let kVerifiedDark = "VerifiedDark"
    static let kVerifiedLight = "VerifiedLight"
    static let kPendingDark = "PendingDark"
    static let kPendingLight = "PendingLight"
}

struct AlertConstants {
    static let kAppName = "Attendance"
}

struct FontConstants {
    static let kRegular = "Inter-Regular"
    static let kMedium = "Inter-Medium"
    static let kSemiBold = "Inter-SemiBold"
    static let kBold = "Inter-Bold"
    
    static let kRegularItalic = "Inter-Italic"
}

enum MediaType: Int {
    case image = 0, video = 1, none = 2
    
    init(rawValue: Int) {
        switch rawValue {
        case 0: self = .image
        case 1: self = .video
        default: self = .none
        }
    }
    
    var CameraMediaType:[String] {
        switch rawValue {
        case 0: return [(UTType.image.identifier)]
        case 1: return [(UTType.movie.identifier)]
        default: return [UTType.image.identifier, UTType.movie.identifier]
        }
    }
}

