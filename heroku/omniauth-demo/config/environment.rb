# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application

OmniauthDemo::Application.initialize!
ENV['sfdc_api_version'] = '21.0'
ENV['sfdc_instance_url'] = 'https://na12.salesforce.com'