//
//  CharacterType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum CharacterType {
  case normal

  static let typeToAssetNameMap = [normal: ""]
  static let typeToTypeNameMap = [normal: "normal"]
  static let typeNameToTypeMap = ["normal": normal]
  static let typeToSizeMap = [normal: CGSize(width: 50, height: 50)]

  var assetName: String? {
    CharacterType.typeToAssetNameMap[self]
  }
  var width: CGFloat {
    CharacterType.typeToSizeMap[self]!.width
  }
  var height: CGFloat {
    CharacterType.typeToSizeMap[self]!.height
  }
}
