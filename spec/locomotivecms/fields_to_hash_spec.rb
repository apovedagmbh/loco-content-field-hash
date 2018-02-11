RSpec.describe Locomotivecms::FieldsToHash::Filters do
  include Locomotivecms::FieldsToHash::Filters
  describe 'fields_to_hash' do
    # TODO: Test with instance of Locomotive::Steam::Liquid::Drops::ContentEntry
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
      filtered_fields = [
        { 'field' => 'Field 1', 'field_desc' => 'Lorem ipsum 1' },
        { 'field' => 'Field 2', 'field_desc' => 'Lorem ipsum 2' },
        { 'field' => 'Field 10', 'field_desc' => 'Lorem ipsum 10' },
      ]
      expect(fields_to_hash(content_entry, { 'first' => 'field', 'second' => 'field_desc' })).to match_array(filtered_fields)
    end

    context 'fields without value' do
      it 'only returns fields where the `first` argument is populated' do
        content_entry[:field_1] = nil
        content_entry[:field_2] = ''
        content_entry[:field_3] = 'Field 3'

        filtered_fields = [
          { 'field' => 'Field 3', 'field_desc' => nil },
          { 'field' => 'Field 10', 'field_desc' => 'Lorem ipsum 10' },
        ]

        expect(fields_to_hash(content_entry, { 'first' => 'field', 'second' => 'field_desc' })).to match_array(filtered_fields)
      end
    end

    context 'missing arguments' do
      it 'returns an empty array' do
        expect(fields_to_hash(content_entry, {})).to match_array([])
      end
    end
  end
end
