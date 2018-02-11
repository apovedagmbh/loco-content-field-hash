module Locomotivecms
  module FieldsToHash
    module Filters
      def fields_to_hash(fields, options)
        filtered_fields = []

        if options['first'].is_a? String and options['second'].is_a? String
          first = options['first'].to_sym
          second = options['second'].to_sym

          fields_hash = fields.to_hash
          first_keys = fields_hash.keys.grep /^#{first}_\d*$/
          second_keys = fields_hash.keys.grep /^#{second}_\d*$/

          filtered_fields = []

          for i in 0..([first_keys.length, second_keys.length].max - 1)
            hash = Hash.new
            hash[first] = fields[first_keys[i]]
            hash[second] = fields[second_keys[i]]
            filtered_fields << hash
          end
        end

        return filtered_fields;
      end
    end
  end
end
