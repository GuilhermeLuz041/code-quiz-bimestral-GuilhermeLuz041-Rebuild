# app/helpers/application_helper.rb
module ApplicationHelper
  def link_to_add_association(name, form, association, **options)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id

    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", form: builder)
    end
    
    link_class = options.delete(:class)
    final_class = "add_fields #{link_class}".strip

    data_attributes = options.delete(:data) || {}
    final_data = data_attributes.merge(id: id, fields: fields.gsub("\n", ""))

    link_to(name, '#', class: final_class, data: final_data)
  end
end