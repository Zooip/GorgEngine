module UserHelper
  def display_attribute(item, attribute)
    render partial:'shared/attribute_value', :locals => {
       attribute: attribute,
       item: item
    }
  end
end
