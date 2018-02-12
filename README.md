# Locomotivecms::FieldsToHash

## Functionality

A gem for LocomotiveCMS. Filters indexed field pairs from a content entry and serves them as a hash.

### Example

#### The issue

A `coach` might teach a variable number of several `subjects`, and each of them has a personalized description.

Obvious solution: create a content type `subjects`, relate to it from the `coach` with a `has_many`/`belongs_to` relationship:

```yaml
# app/content_types/coaches.yml
fields:
- subjects:
    type: has_many
    target: subjects
    inverse_of: coaches
```

Looping over these subjects to display them is a breeze. However, Locomotive makes it currently quite inefficient to fill such related content types. From a backend-administrator's perspective, it might be beneficial to be able to fill all the `subjects` on the same mask, which would lead to a `coach` content type definition like this:


```yaml
# app/content_types/coaches.yml
fields:
- subject_1:
    type: string
- subject_desc_1:
    type: text
    text_formatting: markdown
- subject_2:
    type: string
- subject_desc_2:
    type: text
    text_formatting: markdown
```

Like this we have to test for a value in Liquid templates separately and can't just create a loop handling all the available subjects. What a pain!

### The solution

This gem provides the `fields_to_hash` filter. It takes a set of indexed fields as shown above and returns an array of hashes, each containing a pair of `subject`/`subject_desc` in the example above.

### Usage

**Requirement:** The content type contains an arbitrary number of pairs of fields such as `subject`/`subject_desc`. The field name is followed by an underscore and index number: `subject_1`/`subject_desc_1`, `subject_2`/`subject_desc_2`, etc.

In liquid tempaltes you can then use the `fields_to_hash` filter on a content entry, specifying the field names without the index at the end:

```liquid
app/views/pages/coaches/content_type_template.yml
{% subjects = coach | fields_to_hash: first: 'subject', second: 'subject_desc' %}
```

This will give you an array of hashes with the field names you just passed as keys:

```ruby
{ { 'subject' => 'math', 'subject_desc': 'Lorem ipsum' }, { 'subject' => 'german', 'subject_desc': 'More lorem ipsum' }}
```

Now you can handle it as you would any `has_many` relationship

```liquid
app/views/pages/coaches/content_type_template.yml
{% if subjects.size > 0 %}
  <h1>Subjects</h1>
  {% for subject in subject %}
    <h2>{{ subject.subject }}</h1>
    <p>{{ subject.subject_desc }}</p>
  {% endfor %}
{% endif %}
```

## Installation

### Wagon

Add this to the Gemfile of your site in wagon (local):

```ruby
group :misc do
  gem 'locomotivecms-fields_to_hash', require: true, git: 'git@gitlab.apoveda.org:apoveda-web-engineering/loco-content-field-hash.git'
end
```

Run `bundle install`.

### Engine

Add this to the Gemfile of your engine to use it on the server:

```ruby
gem 'locomotivecms-fields_to_hash', require: true, git: 'git@gitlab.apoveda.org:apoveda-web-engineering/loco-content-field-hash.git'
```

Run `bundle install`

## Development


Run `bundle install` before starting development.

To run tests:

```
rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/locomotivecms-fields_to_hash.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
