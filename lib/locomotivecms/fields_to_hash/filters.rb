module Locomotivecms
  module FieldsToHash
    module Filters
      def fields_to_hash(fields, options)
        first = options[:first].to_sym
        second = options[:second].to_sym

        first_keys = fields.keys.grep /^#{first}_\d*$/
        second_keys = fields.keys.grep /^#{second}_\d*$/

        hash_array = []

        for i in 0..([first_keys.length, second_keys.length].max - 1)
          hash = Hash.new
          hash[first] = fields[first_keys[i]]
          hash[second] = fields[second_keys[i]]
          hash_array << hash
        end

        return hash_array;
      end
    end
  end
end
