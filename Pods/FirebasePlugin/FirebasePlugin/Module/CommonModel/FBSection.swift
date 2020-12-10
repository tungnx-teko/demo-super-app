//
//  Section.swift
//  BLUE
//
//  Created by linhvt on 4/27/20.
//  Copyright © 2020 Teko. All rights reserved.
//

import Foundation

extension Firebase {
    
    public struct HomeSection {
        
        public var visible: Bool
        public var key: String
        public var header: String?
        public var showTab: Bool? = nil
        
    }
    
    public struct AccountSection {
        
        public var enabled: Bool
        public var key: String
        public var editable: Bool

    }
    
}
