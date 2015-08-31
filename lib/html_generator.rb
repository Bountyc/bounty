module HtmlGenerator
	include ActionView::Helpers::TagHelper
	include ActionView::Helpers::TextHelper
	include ActionView::Helpers::DateHelper

	include ActionView::Context

	include Rails.application.routes.url_helpers

	def notification_html(id, message, created_at, clicked)
		content_tag :li, class: "strong" do
			content_tag :a, href: Rails.application.routes.url_helpers.notification_path(id) do
				if clicked
					concat content_tag :span, message
				else
					concat content_tag :span, message, class: "unclicked-notification"
				end
				concat content_tag :h5, "- " + time_ago_in_words(created_at) + " ago"
	 		end
		end
	end
end