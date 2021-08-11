//
// Created by kojiba on 11.08.2021.
//

import SwiftUI
import StreamChat
import StreamChatUI

struct SDKChannelsView: View {

    var channelListController: ChatChannelListController

    var body: some View {
        ChatChannelList(controller: channelListController)
    }
}
