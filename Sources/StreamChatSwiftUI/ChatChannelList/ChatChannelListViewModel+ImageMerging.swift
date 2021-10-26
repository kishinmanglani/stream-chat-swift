//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit

extension ChatChannelListViewModel {
    /// Creates a merged avatar from the given images
    /// - Parameter avatars: The individual avatars
    /// - Returns: The merged avatar
    internal func createMergedAvatar(from avatars: [UIImage]) -> UIImage? {
        guard !avatars.isEmpty else {
            return nil
        }
        
        var combinedImage: UIImage?
                
        let avatarImages = avatars.map {
            imageProcessor.scale(image: $0, to: .avatarThumbnailSize)
        }
        
        // The half of the width of the avatar
        let halfContainerSize = CGSize(width: CGSize.avatarThumbnailSize.width / 2, height: CGSize.avatarThumbnailSize.height)
        
        if avatarImages.count == 1 {
            combinedImage = avatarImages[0]
        } else if avatarImages.count == 2 {
            let leftImage = imageProcessor.crop(image: avatarImages[0], to: halfContainerSize)
                ?? placeholder1
            let rightImage = imageProcessor.crop(image: avatarImages[1], to: halfContainerSize)
                ?? placeholder1
            combinedImage = imageMerger.merge(
                images: [
                    leftImage,
                    rightImage
                ],
                orientation: .horizontal
            )
        } else if avatarImages.count == 3 {
            let leftImage = imageProcessor.crop(image: avatarImages[0], to: halfContainerSize)

            let rightCollage = imageMerger.merge(
                images: [
                    avatarImages[1],
                    avatarImages[2]
                ],
                orientation: .vertical
            )
            
            let rightImage = imageProcessor.crop(
                image: imageProcessor
                    .scale(image: rightCollage ?? placeholder3, to: .avatarThumbnailSize),
                to: halfContainerSize
            )
            
            combinedImage = imageMerger.merge(
                images:
                [
                    leftImage ?? placeholder1,
                    rightImage ?? placeholder2
                ],
                orientation: .horizontal
            )
        } else if avatarImages.count == 4 {
            let leftCollage = imageMerger.merge(
                images: [
                    avatarImages[0],
                    avatarImages[2]
                ],
                orientation: .vertical
            )
            
            let leftImage = imageProcessor.crop(
                image: imageProcessor
                    .scale(image: leftCollage ?? placeholder1, to: .avatarThumbnailSize),
                to: halfContainerSize
            )
            
            let rightCollage = imageMerger.merge(
                images: [
                    avatarImages[1],
                    avatarImages[3]
                ],
                orientation: .vertical
            )
            
            let rightImage = imageProcessor.crop(
                image: imageProcessor
                    .scale(image: rightCollage ?? placeholder2, to: .avatarThumbnailSize),
                to: halfContainerSize
            )
         
            combinedImage = imageMerger.merge(
                images: [
                    leftImage ?? placeholder1,
                    rightImage ?? placeholder2
                ],
                orientation: .horizontal
            )
        }
        
        return combinedImage
    }
}