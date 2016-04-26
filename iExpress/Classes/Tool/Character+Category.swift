//
//  Character+Category.swift
//  iExpress
//
//  Created by Michael Qiu on 16/4/25.
//  Copyright © 2016年 MichaelQiu. All rights reserved.
//

import Foundation

extension Character
{
    func toInt() -> Int
    {
        var intFromCharacter:Int = 0
        for scalar in String(self).unicodeScalars
        {
            intFromCharacter = Int(scalar.value)
        }
        return intFromCharacter
    }
}
