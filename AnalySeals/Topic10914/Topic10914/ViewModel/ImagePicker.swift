//
//  ImagePicker.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/28.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable
{
    @Binding var selectedImage: UIImage?
    
    @Environment(\.dismiss) private var dismiss
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    func makeCoordinator() -> Coordinator
    {
        Coordinator(self)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController
    {
        let imagePicker=UIImagePickerController()
        imagePicker.allowsEditing=false
        imagePicker.sourceType=self.sourceType
        imagePicker.delegate=context.coordinator
        
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>)
    {
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate
    {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker)
        {
            self.parent=parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
        {
            if let image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            {
                self.parent.selectedImage=image
            }
            
            self.parent.dismiss()
        }
    }
}
