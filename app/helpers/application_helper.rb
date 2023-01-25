module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - Tag Match"
    else
      "Tag Match"
    end
  end

  def menu_link_to(text, external_coach_path, options = {})
    content_tag :li do
      link_to_unless_current(text, external_coach_path, options) do
        content_tag(:span, text)
      end
    end
  end
end
