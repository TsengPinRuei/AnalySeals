//
//  ModifyTextField.swift
//  Topic10914
//
//  Created by Topic10914 on 2023/2/28.
//

import SwiftUI

struct ModifyField: View
{
    @Binding var text: String
    
    //呼叫結構時 會修改預設變數的話 要使用var
    var fieldType: FieldType
    var placeholder: String=""
    var background: Color=Color(.field)
    var keyboard: UIKeyboardType = .default
    var submit: SubmitLabel = .return
    
    enum FieldType
    {
        case text
        case secure
    }
    
    var body: some View
    {
        //MARK: TextField
        if(self.fieldType == .text)
        {
            TextField("", text: self.$text)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .keyboardType(self.keyboard)
                .placeholder(when: self.text.isEmpty)
                {
                    Text(self.placeholder)
                        .foregroundStyle(.gray)
                        .colorMultiply(.gray)
                }
                .foregroundStyle(Color(.fieldText))
                .padding(.vertical)
                .padding(.horizontal, 10)
                .background(self.background)
                .clipShape(.rect(cornerRadius: 10))
                .submitLabel(self.submit)
        }
        //MARK: SecureField
        else
        {
            SecureField("", text: self.$text)
                .autocorrectionDisabled(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .placeholder(when: self.text.isEmpty)
                {
                    Text(self.placeholder)
                        .foregroundStyle(.gray)
                        .colorMultiply(.gray)
                }
                .foregroundStyle(Color(.fieldText))
                .padding(.vertical)
                .padding(.horizontal, 10)
                .background(self.background)
                .clipShape(.rect(cornerRadius: 10))
                .submitLabel(self.submit)
        }
    }
}
