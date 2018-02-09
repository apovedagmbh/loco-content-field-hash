RSpec.describe Locomotivecms::FieldsToHash::Filters do
   include Locomotivecms::FieldsToHash::Filters
  describe 'fields_to_hash' do
    content_entry = {
      field_1: 'Field 1',
      field_desc_1: 'Lorem ipsum 1',
      field_2: 'Field 2',
      field_desc_2: 'Lorem ipsum 2',
      field_10: 'Field 10',
      field_desc_10: 'Lorem ipsum 10',
      other_field_1: 'Other Field',
      other_field_desc_1: 'Why am I here?',
      field_1_other: 'Shouldn\'t match',
      field_desc_1_other: 'Yea, you messed up'
    }

    it "creates a hash from a content entry's field" do
      hash_array = [
        { field: 'Field 1', field_desc: 'Lorem ipsum 1' },
        { field: 'Field 2', field_desc: 'Lorem ipsum 2' },
        { field: 'Field 10', field_desc: 'Lorem ipsum 10' },
      ]

      expect(fields_to_hash(content_entry, { first: 'field', second: 'field_desc' })).to match_array(hash_array)
    end
  end
end
