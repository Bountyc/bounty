module HtmlGenerator
	include ActionView::Helpers::TagHelper
	include ActionView::Helpers::TextHelper
	include ActionView::Helpers::DateHelper

	include ActionView::Context

	def notification_html(message, created_at, seen)
		content_tag :li, class: "strong" do
			content_tag :a, href: "#" do
				if seen
					concat content_tag :span, message
				else
					concat content_tag :span, message, class: "unseen-notification"
				end
				concat content_tag :h5, "- " + time_ago_in_words(created_at) + " ago"
	 		end
		end
	end
end