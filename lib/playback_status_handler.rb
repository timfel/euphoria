# $Id: playback_status_handler.rb,v 1.1 2005/04/24 22:33:15 tsauerbeck Exp $

class PlaybackStatusHandler
	def initialize(xmms, &block)
		@block = block

		@state = xmms.playback_status.wait.value
		@block.call(@state)

		xmms.broadcast_playback_status.notifier do |res|
			if @state != res.value
				@state = res.value
				@block.call(@state)
			end
		end
	end
end
