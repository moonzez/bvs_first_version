module ApplicationHelper
  def title(text = nil)
    content_for(:title) do
      text ? 'BVS - ' + text : 'BVS'
    end
  end
end
