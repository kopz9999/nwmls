require 'savon'
class Evernet::Connection

  DEFAULT_SCHEMA_NAME = 'StandardXML1_2'
  MLS = 'NWMLS'
  DEFAULT_PTYP = 'RESI'
  IMAGE_SCHEMA = 'NWMLS:EverNet:ImageData:1.0'

  cattr_accessor :user, :pass, :schema_name, :client_options,
                 :image_client_options

  attr_accessor :client, :image_client

  def self.retrieve_amenity_data(property_type)
    response = instance.client.call :retrieve_amenity_data, message: { v_strXmlQuery: build_query(:property_type => property_type) }
    raw = response.body[:retrieve_amenity_data_response][:retrieve_amenity_data_result]
    load_data_result_with_nokogiri(raw)
  end

  def self.retrieve_area_community_data
    response = instance.client.call :retrieve_area_community_data, message: { v_strXmlQuery: build_query }
    raw = response.body[:retrieve_area_community_data_response][:retrieve_area_community_data_result]
    load_data_result_with_nokogiri(raw)
  end

  def self.retrieve_image_data(conditions = {})
    response = instance.client.call :retrieve_image_data, message: { v_strXmlQuery: build_query(conditions) }
    raw = response.body[:retrieve_image_data_response][:retrieve_image_data_result]
    load_data_result_with_nokogiri(raw)
  end

  def self.retrieve_image_binary(conditions = {})
    response = instance.image_client.call :retrieve_images, message: { query: build_image_query(conditions) }
    raw = response.body[:retrieve_images_response][:retrieve_images_result]
    load_img_data_with_nokogiri(raw)
  end

  def self.retrieve_listing_data(conditions = {}, filters = [])
    response = instance.client.call :retrieve_listing_data, message: { v_strXmlQuery: build_query(conditions, filters) }
    raw = response.body[:retrieve_listing_data_response][:retrieve_listing_data_result]
    load_data_result_with_nokogiri(raw)
  end

  def self.retrieve_listing_history_data(conditions = {})
    response = instance.client.call :retrieve_listing_history_data, message: { v_strXmlQuery: build_query(conditions) }
    raw = response.body[:retrieve_listing_history_data_response][:retrieve_listing_history_data_result]
    load_data_result_with_nokogiri(raw)
  end

  def self.retrieve_member_data(conditions = {})
    response = instance.client.call :retrieve_member_data, message: { v_strXmlQuery: build_query(conditions) }
    raw = response.body[:retrieve_member_data_response][:retrieve_member_data_result]
    load_data_result_with_nokogiri(raw)
  end

  def self.retrieve_office_data(conditions = {})
    response = instance.client.call :retrieve_office_data, message: { v_strXmlQuery: build_query(conditions) }
    raw = response.body[:retrieve_office_data_response][:retrieve_office_data_result]
    load_data_result_with_nokogiri(raw)
  end

  def self.retrieve_school_data
    response = instance.client.call :retrieve_school_data, message: { v_strXmlQuery: build_query }
    raw = response.body[:retrieve_school_data_response][:retrieve_school_data_result]
    load_data_result_with_nokogiri(raw)
  end

  private

  def self.instance
    @__instance__ ||= new
  end

  def initialize
    self.client = Savon.client process_client_options
    self.image_client = Savon.client process_image_client_options
  end

  def process_client_options
    default_opts = {
      wsdl: "http://evernet.nwmls.com/evernetqueryservice/evernetquery.asmx?WSDL",
      convert_request_keys_to: :none,
    }
    default_opts.merge!(client_options) unless client_options.blank?
    default_opts
  end

  def process_image_client_options
    default_opts = {
      wsdl: "http://images.idx.nwmls.com/imageservice/imagequery.asmx?WSDL",
      convert_request_keys_to: :none,
    }
    default_opts.merge!(image_client_options) unless image_client_options.blank?
    default_opts
  end


  def self.build_query(conditions = {}, filters = [])
    conditions = self.sanitize_conditions(conditions)

    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.EverNetQuerySpecification(:xmlns => "urn:www.nwmls.com/Schemas/General/EverNetQueryXML.xsd") do
      xml.Message do
        xml.Head do
          xml.UserId user
          xml.Password pass
          xml.SchemaName (schema_name || DEFAULT_SCHEMA_NAME )
        end
        xml.Body do
          xml.Query do
            xml.MLS MLS
            if conditions[:listing_number]
              xml.ListingNumber conditions[:listing_number] if conditions[:listing_number]
              xml.PropertyType (conditions[:property_type] || DEFAULT_PTYP)
            else
              xml.PropertyType conditions[:property_type] if conditions[:property_type]
              xml.Status conditions[:status] if conditions[:status]
              xml.County conditions[:county] if conditions[:county]
              xml.Area conditions[:area] if conditions[:area]
              xml.City conditions[:city]if conditions[:city]
              xml.BeginDate (conditions[:begin_date] or 10.years.ago).strftime('%FT%T')
              xml.EndDate (conditions[:end_date] or Time.now + 1.day).strftime('%FT%T')
              xml.OfficeId conditions[:office_mls_id] if conditions[:office_mls_id]
              xml.AgentId conditions[:agent_mls_id] if conditions[:agent_mls_id]
              xml.Bedrooms conditions[:bedrooms] if conditions[:bedrooms]
              xml.Bathrooms conditions[:bathrooms] if conditions[:bathrooms]
            end
          end
          xml.Filter filters.join(',')
        end
      end
    end
  end

  def self.build_image_query(conditions = {}, filters = [])
    conditions = self.sanitize_conditions(conditions)

    xml = Builder::XmlMarkup.new
    xml.instruct! :xml, :version=>"1.0"
    xml.ImageQuery(:xmlns => "NWMLS:EverNet:ImageQuery:1.0") do
      xml.Auth do
        xml.UserId user
        xml.Password pass
      end
      xml.Query do
        xml.ByListingNumber conditions[:listing_number] if conditions[:listing_number]
        xml.ById conditions[:id] if conditions[:id]
      end
      xml.Results do
        xml.Schema IMAGE_SCHEMA
      end
    end
  end

  def self.load_data_result_with_nokogiri(raw)
    xml = Nokogiri::XML(raw)
    if error_element = xml.at("ResponseMessages")
      raise error_element.text
    end
    xml
  end

  def self.load_img_data_with_nokogiri(raw)
    xml = Nokogiri::XML(raw)
    if error_element = xml.at("Message")
      raise error_element.text
    end
    xml
  end

  def self.sanitize_conditions(conditions)
    conditions.each do |key,value|
      if [:begin_date, :end_date].include?(key.to_sym) and value.is_a?(String)
        conditions[key] = Time.parse(value)
      end
    end
    conditions
  end

end
