RSpec.describe Locomotivecms::FieldsToHash::Filters do
   include Locomotivecms::FieldsToHash::Filters
  describe 'fields_to_hash' do
    content_entry = {
      field_1: 'Field 1',
      field_desc_1: 'Lorem ipsum 1',
      field_2: 'Field 2',
      field_desc_2: 'Lorem ipsum 2',
      field_3: 'Field 3',
      field_desc_3: 'Lorem ipsum 3',
      field_4: 'Field 4',
      field_desc_4: 'Lorem ipsum 4',
      field_5: 'Field 5',
      field_desc_5: 'Lorem ipsum 5',
    }

    it "creates a hash from a content entry's field" do
      hash_array = [
        { field: 'Field 1', field_desc: 'Lorem ipsum 1' },
        { field: 'Field 2', field_desc: 'Lorem ipsum 2' },
        { field: 'Field 3', field_desc: 'Lorem ipsum 3' },
        { field: 'Field 4', field_desc: 'Lorem ipsum 4' },
        { field: 'Field 5', field_desc: 'Lorem ipsum 5' },
      ]

      fields_to_hash(content_entry, { first: 'field', second: 'field_desc' }).should eq(hash_array)
    end
  end
end
