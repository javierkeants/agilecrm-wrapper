require 'agilecrm-wrapper/error'
require 'hashie'

module AgileCRMWrapper
  class Deal < Hashie::Mash
    # SYSTEM_PROPERTIES = %w(first_name last_name company title email address phone)
    # DEAL_FIELDS = %w(id type tags lead_score star_value)

    class << self
      def all
        response = AgileCRMWrapper.connection.get('opportunity')
        if response.status == 200
          return response.body.map { |body| new body }
        else
          return response
        end
      end

      def find(id)
        response = AgileCRMWrapper.connection.get("opportunity/#{id}")
        if response.status == 200
          new(response.body)
        elsif response.status == 204
          fail(AgileCRMWrapper::NotFound.new(response))
        end
      end

      # def search(query, type="PERSON", page_size=10)
      #   response = AgileCRMWrapper.connection.get(
      #     "search?q=#{query}&type=#{type}&page_size=#{page_size}"
      #   )
      #   if response.status == 200
      #     return response.body.map { |body| new body }
      #   else
      #     return response
      #   end
      # end

      # def create(options = {})
      #   payload = parse_contact_fields(options)
      #   response = AgileCRMWrapper.connection.post('opportunity', payload)
      #   if response && response.status == 200
      #     contact = new(response.body)
      #   end
      #   contact
      # end

      # def delete(arg)
      #   AgileCRMWrapper.connection.delete("opportunity/#{arg}")
      # end

      # def parse_contact_fields(options)
      #   payload = { 'properties' => [] }
      #   options.each do |key, value|
      #     if contact_field?(key)
      #       payload[key.to_s] = value
      #     else
      #       payload['properties'] << parse_property(key, value)
      #     end
      #   end
      #   payload
      # end

      private

      # def parse_property(key, value)
      #   type = system_propety?(key) ? 'SYSTEM' : 'CUSTOM'
      #   { 'type' => type, 'name' => key.to_s, 'value' => value }
      # end

      # def system_propety?(key)
      #   SYSTEM_PROPERTIES.include?(key.to_s)
      # end

      # def contact_field?(key)
      #   DEAL_FIELDS.include?(key.to_s)
      # end
    end

    # def destroy
    #   self.class.delete(id)
    # end

    # def delete_tags(tags)
    #   email = get_property('email')
    #   response = AgileCRMWrapper.connection.post(
    #     'opportunity/email/tags/delete', "email=#{email}&tags=#{tags}",
    #     'content-type' => 'application/x-www-form-urlencoded'
    #   )
    #   self.tags = self.tags - tags if response.status == 204
    # end

    # def update(options = {})
    #   payload = self.class.parse_contact_fields(options)
    #   payload['properties'] = merge_properties(payload['properties'])
    #   merge!(payload)
    #   response = AgileCRMWrapper.connection.put('opportunity', self)
    #   merge!(response.body)
    # end

    # def get_property(property_name)
    #   return unless respond_to?(:properties)
    #   arr = properties.select { |a| a['name'] == property_name.to_s }
    #   if arr.length > 1
    #     arr.map {|i| i['value'] }
    #   else
    #     arr.first['value'] if arr.first
    #   end
    # end

    # private

    # def merge_properties(new_properties)
    #   properties.map do |h|
    #     new_properties.delete_if do |h2|
    #       if h['name'] == h2['name']
    #         h['value'] = h2['value']
    #         true
    #       end
    #     end
    #     h
    #   end + new_properties
    # end
    
  end
end
