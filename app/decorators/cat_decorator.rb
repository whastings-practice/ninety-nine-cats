class CatDecorator < Draper::Decorator
  delegate_all

  def sex_options
    object.class.const_get(:SEXES)
  end

  def color_options
    {}.tap do |color_options|
      object.class.const_get(:ALLOWED_COLORS).each do |color|
        color_options[color] = color.capitalize
      end
    end
  end

  def sex_checked(sex)
    if object.sex == sex
      ' checked="checked"'
    else
      ""
    end
  end

  def color_selected(color)
    if object.color == color
      ' selected="selected"'
    else
      ""
    end
  end
end
