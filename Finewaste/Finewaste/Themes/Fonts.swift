//
//  Fonts.swift
//  Finewaste
//
//  Created by Andrean Lay on 01/11/21.
//

import SwiftUI

struct Fonts {
    static func poppinsLargeTitle() -> Font {
        return .custom("Poppins-Regular", size: 34, relativeTo: .largeTitle)
    }
    
    static func poppinsTitle() -> Font {
        return .custom("Poppins-SemiBold", size: 28, relativeTo: .title)
    }
    
    static func poppinsTitle2() -> Font {
        return .custom("Poppins-Regular", size: 22, relativeTo: .title2)
    }
    
    static func poppinsTitle3() -> Font {
        return .custom("Poppins-Regular", size: 20, relativeTo: .title3)
    }
    
    static func poppinsHeadline() -> Font {
        return .custom("Poppins-SemiBold", size: 17, relativeTo: .headline)
    }
    
    static func poppinsBody() -> Font {
        return .custom("Poppins-Regular", size: 17, relativeTo: .body)
    }
    
    static func poppinsCallout() -> Font {
        return .custom("Poppins-SemiBold", size: 16, relativeTo: .callout)
    }
    
    static func poppinsSubheadline() -> Font {
        return .custom("Poppins-Regular", size: 15, relativeTo: .subheadline)
    }
    
    static func poppinsFootnote() -> Font {
        return .custom("Poppins-Regular", size: 13, relativeTo: .footnote)
    }
    
    static func poppinsCaption() -> Font {
        return .custom("Poppins-Regular", size: 12, relativeTo: .caption)
    }
    
    static func poppinsCaption2() -> Font {
        return .custom("Poppins-Regular", size: 11, relativeTo: .caption2)
    }
    
    static func poppinsCaptionBold() -> Font {
        return .custom("Poppins-Bold", size: 12, relativeTo: .caption)
    }
    
    static func poppinsSubheadlineBold() -> Font {
        return .custom("Poppins-Bold", size: 15, relativeTo: .subheadline)
    }
}
