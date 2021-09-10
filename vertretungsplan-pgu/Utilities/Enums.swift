//
//  Enums.swift
//  Enums
//
//  Created by Wolf Jonas Friederichs on 9/10/21.
//

import Foundation

enum Role { case student, teacher }


enum Day { case today, tomorrow }




enum PDFNetworkingError: Error { case unexpectedMimeType, CGPDFError, pdfToImageError, uiImageToImageError }
