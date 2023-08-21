//
//  NetworkingUtils.swift
//  NetworkingUtils
//
//  Created by Wolf Jonas Friederichs on 9/10/21.
//

import Foundation
import SwiftUI
import PDFKit

struct NetworkingUtils {
    
    static let shared = NetworkingUtils()
    
    private func fetchPDF(role: Role, day: Day) async -> Result<Data, PDFNetworkingError> {
        
        do {
            
            let (data, response) = try await urlSessionDataTask(url: Constants.createPDFURL(role: role, day: day))
            
            guard response.mimeType == "application/pdf" else { return .failure(.unexpectedMimeType) }
            
            return .success(data)
        } catch {
            return .failure(.networkError(error))
        }
    }
    
    private func urlSessionDataTask(url: URL) async throws -> (Data, URLResponse) {
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let urlSession = URLSession(configuration: configuration)
        
        let result: (Data, URLResponse) = try await urlSession.data(from: url)
        
        return result
        
    }
 
    
    private func createImageFromPDFData(data: Data) -> Result<[Image], PDFNetworkingError> {
        
        guard let pdfDocument = PDFDocument(data: data) else { return .failure(.CGPDFError) }
        
        guard let cgpdf = pdfDocument.documentRef else { return .failure(.CGPDFError)}
        
        let uiimages = PDFImageUtils.drawPDFAsUIImage(pdfDoc: cgpdf)
        
        guard !uiimages.isEmpty else { return .failure(.pdfToImageError) }
        
        let images = uiimages.map { image in
            if image != nil { return Image(uiImage: image!) } else { return Image("error-image") }
        }
        
        return .success(images)
        
    }
    
    
    func getPDFImages(role: Role) async -> Result<[[Image]], PDFNetworkingError> {
        
        var imagesArray: [[Image]] = []
        
        for day in [Day.today, Day.tomorrow] {
            
            let fetchResult = await fetchPDF(role: role, day: day)
            
            switch fetchResult {
            case .success(let data):
                
                let imageResult = createImageFromPDFData(data: data)
                
                switch imageResult {
                case .success(let images):
                    imagesArray.append(images)
                case .failure(let error):
                    return .failure(error)
                }
                
            case .failure(let error):
                return .failure(error)
            }
            
        }
        
        return .success(imagesArray)
        
    }
    
    
}
