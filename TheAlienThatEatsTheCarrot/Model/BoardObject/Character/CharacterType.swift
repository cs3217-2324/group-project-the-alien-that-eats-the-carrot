//
//  CharacterType.swift
//  TheAlienThatEatsTheCarrot
//
//  Created by Sun Xinyu on 23/3/24.
//

import Foundation

public enum CharacterType {
  case normal

  static let characterTypeToAssetNameMap = [normal: ""]
  static let characterTypeToTypeNameMap = [normal: "normal"]
  static let characterTypeNameToTypeMap = ["normal": normal]
  static let characterTypeToSizeMap = [normal: CGSize(width: 50, height: 50)]

  var assetName: String? {
    CharacterType.characterTypeToAssetNameMap[self]
  }
  var width: CGFloat {
    CharacterType.characterTypeToSizeMap[self]!.width
  }
  var height: CGFloat {
    CharacterType.characterTypeToSizeMap[self]!.height
  }
}
