//
//  ErrorHandler.swift
//  ErrorHandler
//
//  Created by Wolf Jonas Friederichs on 9/12/21.
//

import Foundation

enum PDFNetworkingError: LocalizedError {
    case unexpectedMimeType
    case CGPDFError
    case pdfToImageError
    case uiImageToImageError
}

enum LoginError: LocalizedError {
    case wrongCredentials
    
    public var errorDescription: String? {
        switch self {
        case .wrongCredentials: return "These login credentials are wrong"
        }
    }
}

