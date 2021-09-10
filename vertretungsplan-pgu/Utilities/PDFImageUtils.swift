//
//  PDFImageUtils.swift
//  PDFImageUtils
//
//  Created by Wolf Jonas Friederichs on 9/10/21.
//

import Foundation
import UIKit

struct PDFImageUtils {
    
    func drawPDFAsUIImage(pdfDoc: CGPDFDocument) -> [UIImage?] {
        
        var images: [UIImage]  = []
        
        for i in 1...pdfDoc.numberOfPages {
            
            guard let page = pdfDoc.page(at: i) else { continue }
            
            let pageRect = page.getBoxRect(.mediaBox)
            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            let img = renderer.image { ctx in
                UIColor.white.set()
                ctx.fill(pageRect)
                
                ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
                
                ctx.cgContext.drawPDFPage(page)
            }
            
            images.append(img)
            
        }
        
        return images
        
    }
    
}
