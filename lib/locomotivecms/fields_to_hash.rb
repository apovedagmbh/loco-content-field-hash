require "locomotivecms/fields_to_hash/version"
require "locomotivecms/fields_to_hash/filters"

Liquid::Template.register_filter(Locomotivecms::FieldsToHash::Filters)
