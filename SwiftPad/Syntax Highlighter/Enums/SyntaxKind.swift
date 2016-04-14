//
//  SyntaxKind.swift
//  SwiftPad
//
//  Created by Sameh Mabrouk on 4/12/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Cocoa

public enum SyntaxKind: String {
    case Argument = "source.lang.swift.syntaxtype.argument"
    case AttributeBuiltin = "source.lang.swift.syntaxtype.attribute.builtin"
    case AttributeID = "source.lang.swift.syntaxtype.attribute.id"
    case BuildconfigID = "source.lang.swift.syntaxtype.buildconfig.id"
    case BuildconfigKeyword = "source.lang.swift.syntaxtype.buildconfig.keyword"
    case Comment = "source.lang.swift.syntaxtype.comment"
    case CommentMark = "source.lang.swift.syntaxtype.comment.mark"
    case CommentURL = "source.lang.swift.syntaxtype.comment.url"
    case DocComment = "source.lang.swift.syntaxtype.doccomment"
    case DocCommentField = "source.lang.swift.syntaxtype.doccomment.field"
    case Identifier = "source.lang.swift.syntaxtype.identifier"
    case Keyword = "source.lang.swift.syntaxtype.keyword"
    case Number = "source.lang.swift.syntaxtype.number"
    case Objectliteral = "source.lang.swift.syntaxtype.objectliteral"
    /// `parameter`.
    case Parameter = "source.lang.swift.syntaxtype.parameter"
    /// `placeholder`.
    case Placeholder = "source.lang.swift.syntaxtype.placeholder"
    /// `string`.
    case String = "source.lang.swift.syntaxtype.string"
    /// `string_interpolation_anchor`.
    case StringInterpolationAnchor = "source.lang.swift.syntaxtype.string_interpolation_anchor"
    /// `typeidentifier`.
    case Typeidentifier = "source.lang.swift.syntaxtype.typeidentifier"

    var colorValue: NSColor {
        switch self {
        case .Keyword:
            return NSColor(red: 0.796, green: 0.208, blue: 0.624, alpha: 1)
        case .Identifier:
            return NSColor.blackColor()
        case .Typeidentifier:
            return NSColor(red: 0.478, green: 0.251, blue: 0.651, alpha: 1)
        case .String:
            return NSColor(red: 0.918, green: 0.216, blue: 0.071, alpha: 1)
        case .Number:
            return NSColor(red: 0.22, green: 0.18, blue: 0.827, alpha: 1)
        case .Comment, .CommentMark, .CommentURL, .DocComment, .DocCommentField:
            return NSColor(red: 0, green: 0.514, blue: 0.122, alpha: 1)
        case .AttributeBuiltin:
            return NSColor(red: 0.796, green: 0.208, blue: 0.624, alpha: 1)
        default:
            return NSColor.greenColor()
        }
    }
}
