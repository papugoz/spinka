module ApplicationHelper
# Returns the full title on a per-page basis.
def full_title(page_title)
	base_title = "SPiNKa"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end
def shallow_args(parent, child)
	params[:action] == 'new' ? [parent, child] : child
end
end
