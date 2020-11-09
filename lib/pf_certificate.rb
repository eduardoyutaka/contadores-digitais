require 'pdf-reader'

class PFCertificate
  def initialize(filename)
    reader = PDF::Reader.new(filename)
    @data = reader.pages.first.text
  end

  def name
    result = (@data.scan(/Nome: \b[A-Z ]+/))[0]
    result[6, result.length].strip
  end

  def birthdate
    result = @data.scan(/Data de nascimento: [\d]+\/[\d]+\/[\d]+/)[0]
    result[20, result.length]
  end

  def cpf
    result = @data.scan(/CPF: [\d]+/)[0]
    result[5, result.length]
  end

  def voter_registration
    result = @data.scan(/Título Eleitor: [\d]+/)[0]
    result[16, result.length]
  end

  def pis_pasep
    result = @data.scan(/PIS\/PASEP: [\d]+/)[0]
    result[11, result.length]
  end

  def cei
    result = @data.scan(/CEI: [\d]+/)[0]
    result[5, result.length]
  end

  def email
    result = @data.scan(/Email: [\w\-\.]+@[\w\-\.]+/)[0]
    result[7, result.length]
  end

  def responsibility
    result = @data.scan(/4.2 Responsabilizar-se [a-zA-Z\u00C0-\u00FF,\.\n ]+/)[0]
    result = result.split(/\n/)
    result = result.map do |line|
      line.strip
    end
    result = result.join(' ')
    result[4, result.length]
  end

  def validity
    @data.scan(/validade de [\d]+ meses/)[0]
  end
end
