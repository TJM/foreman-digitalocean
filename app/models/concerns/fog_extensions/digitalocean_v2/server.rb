module FogExtensions
  module DigitalOceanV2
    module Server
      extend ActiveSupport::Concern

      def state
        :status
      end

      def identity_to_s
        identity.to_s
      end

      def vm_description
	self.size_slug
      end

      #def flavor
      #  requires :flavor_id
      #  @flavor ||= service.flavors.get(flavor_id.to_i)
      #end

      def flavor
        self.size
      end

      def flavor_name
	self.size_slug
      end

      #def image
      #  requires :image_id
      #  @image ||= service.images.get(image_id.to_i)
      #end

      def image_name
	# NOTE this is duplicated in images.rb for now
        @image_name ||= "#{image['distribution']} #{self.image['name']}"
      end

      #def region
      #  requires :region_id
      #  @region ||= service.regions.get(region_id.to_i)
      #end

      def region_name
        self.region['name']
      end

      def ip_addresses
        [public_ip_address, private_ip_address].flatten.select(&:present?)
      end

    end
  end
end
