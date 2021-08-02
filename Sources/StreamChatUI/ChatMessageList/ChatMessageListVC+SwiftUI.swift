//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import StreamChat
import SwiftUI

@available(iOSApplicationExtension, unavailable)
extension _ChatMessageListVC: SwiftUIRepresentable {
    public var content: _ChatChannelController<ExtraData> {
        get {
            channelController
        }
        set {
            channelController = newValue
        }
    }
}
