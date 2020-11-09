require 'pf_certificate'
require 'csv'

class CustomersController < ApplicationController
  def new
  end

  def create
  end

  def upload
    uploaded_files = params[:certificates]
    uploaded_files.each do |uploaded_file|
      File.open(Rails.root.join('public', 'uploads', uploaded_file.original_filename), 'w+b') do |file|
        file.write(uploaded_file.read)

        CSV.open(Rails.root.join('public', 'csv', 'result.csv'), 'a+b') do |csv|
          certificate = PFCertificate.new(file)
          csv << [certificate.name, certificate.birthdate, certificate.cpf, certificate.voter_registration, certificate.pis_pasep, certificate.cei, certificate.email, certificate.responsibility, certificate.validity]
        end
      end
    end
    redirect_to '/csv/result.csv'
  end
end
