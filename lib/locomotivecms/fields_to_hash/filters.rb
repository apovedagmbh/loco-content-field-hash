module Locomotivecms
  module FieldsToHash
    module Filters
      def fields_to_hash(content_entry, options)
        filtered_fields = []

        unless options['first'].respond_to? :to_sym and options['second'].respond_to? :to_sym and content_entry.respond_to? :to_hash
          return filtered_fields
        end

        begin
          first_name_prefix = options['first'].to_sym
          second_name_prefix = options['second'].to_sym

          fields_hash = content_entry.to_hash
          first_keys = fields_hash.keys.grep /^#{first_name_prefix}_\d*$/
          second_keys = fields_hash.keys.grep /^#{second_name_prefix}_\d*$/

          filtered_fields = []

          for i in 0..([first_keys.length, second_keys.length].max - 1)
            # TODO: Make sure the index of the fields field_i match for `first` and `second`
            first_entry = content_entry[first_keys[i]]
            second_entry = content_entry[second_keys[i]]

            if first_entry.is_a? String and !first_entry.empty?
              # Only return fields where the `first` value is set
              hash = Hash.new
              hash[first_name_prefix.to_s] = content_entry[first_keys[i]]
              hash[second_name_prefix.to_s] = content_entry[second_keys[i]]
              filtered_fields << hash
            end
          end
        rescue
          # catch crashes, for example for content types with invalid links
        end

        return filtered_fields;
      end
    end
  end
end
