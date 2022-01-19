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
    
    func getPDF(role: Role, day: Day) async throws -> [Image] {
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let urlSession = URLSession(configuration: configuration)
        
        let dataTask = try await urlSession.data(from: ImageURLUtils().createPDFURL(role: role, day: day))
        
        guard dataTask.1.mimeType == "application/pdf" else { throw PDFNetworkingError.unexpectedMimeType }
        
        guard let pdfDoc = PDFDocument(data: dataTask.0) else { throw PDFNetworkingError.CGPDFError }
        
        guard let cgPDF = pdfDoc.documentRef else { throw PDFNetworkingError.CGPDFError }
        
        let uiimages = PDFImageUtils().drawPDFAsUIImage(pdfDoc: cgPDF)
        
        if uiimages == [] { throw PDFNetworkingError.pdfToImageError }
        
        var images: [Image] = []
        
        for i in 0...uiimages.count-1 {
            
            guard let uiimage = uiimages[i] else {
                
                print("Error with image: No image loaded")
                images.append(Image("error-image"))
                continue
                
            }
            
            images.append(Image(uiImage: uiimage))
            
        }
        
        return images
        
    }
    
    
    func getPDFImages(role: Role) async throws -> [[Image]] {
        
        var imagesArray: [[Image]] = []
        
        let today = try await getPDF(role: role, day: .today)
        let tomorrow = try await getPDF(role: role, day: .tomorrow)
        
        imagesArray.append(today)
        imagesArray.append(tomorrow)
        
        return imagesArray
        
    }
    
    
    
    func getVertretungen() async throws -> [Vertretung] {
        
        print("getting")
        
        let jsonDecoder = JSONDecoder()
        
        let urlSession = URLSession.shared
        
        let dataTask = try await urlSession.data(from: URL(string: "https://pgu.backslash-vr.com/api/user/get?class=q2")!)
        
        print(dataTask.0)

        var vertretungen = try jsonDecoder.decode([Vertretung].self, from: dataTask.0)
        
        if !vertretungen.isEmpty {
            
            for i in 0...vertretungen.count-1  {
                
                vertretungen[i].raum = vertretungen[i].raum.split(separator: "→").joined(separator: " → ")
                vertretungen[i].vertreter = vertretungen[i].vertreter.split(separator: "→").joined(separator: " → ")
                
            }
        
        }
        
        return vertretungen
        
    }
    
    
    
}
