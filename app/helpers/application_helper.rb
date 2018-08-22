module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : "asc"
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    query = params[:q] || ""
    link_to title, { sort: column, direction: direction, q: query}, class: css_class
  end
end
