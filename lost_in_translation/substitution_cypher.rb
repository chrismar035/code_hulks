require 'logger'

class SubstitutionCypher

  @@logger = Logger.new(STDOUT)

  def initialize(encoded_path, decoded_path)
    encoded = File.open(encoded_path, 'r')
    decoded = File.open(decoded_path, 'r')

    @mapping = Hash.new

    while (e = encoded.getc) && (d = decoded.getc)
      e = e.chr
      d = d.chr
      @@logger.info("e: '#{e}")
      @@logger.info("d: '#{d}")
      unless @mapping.has_key?(e.chr) && @mapping[e.chr] != d.chr
        @mapping[e.chr] = d.chr
      else
        @@logger.error([ "Substitution Key '#{e.chr}' already in use. ",
                         "Trying to overwrite '#{@mapping[e.chr]}' with ",
                         "'#{d.chr}'"].join)
      end
    end

    encoded.close
    decoded.close
  end

  def decode_char(e)
      if @mapping.has_key?(e)
        @mapping[e]
      else
        @@logger.error("Substitution Key '#{e}' not mapped.")
      end
  end

  def decode_message(message_path)
    file_names = message_path.split('.')
    file_names[0] << '_decoded'
    decoded_path = file_names.join('.')

    encoded = File.open(message_path, 'r')
    decoded = File.open(decoded_path, 'w')

    while e = encoded.getc
      decoded.write(decode_char(e.chr))
    end

    encoded.close
    decoded.close

    @@logger.info("Wrote decoded message to #{decoded_path}")
  end
end
