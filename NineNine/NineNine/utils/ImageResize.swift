//
//  ImageResize.swift
//  NineNine
//
//  Created by Jinyoung Yoo on 2023/05/22.
//

import UIKit

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let customImage = image
    let newImageRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
    
    UIGraphicsBeginImageContext(CGSize(width: targetSize.width, height: targetSize.height))
    customImage.draw(in: newImageRect)

//    let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}
