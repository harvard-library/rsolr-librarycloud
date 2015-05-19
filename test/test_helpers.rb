module TestHelpers
  def self.included(base)
    puts "Included"
    base.extend(ClassMethods)
  end

  # Instance method
  def r_symbolize_keys hsh
    case hsh
    when Hash
      hsh.reduce({}) do |r,(k,v)|
        r[k.to_sym] = r_symbolize_keys(v)
        r
      end
    when Array
      hsh.map {|el| r_symbolize_keys el}
    else
      hsh
    end
  end

  module ClassMethods
    def r_symbolize_keys hsh
      case hsh
      when Hash
        hsh.reduce({}) do |r,(k,v)|
          r[k.to_sym] = r_symbolize_keys(v)
          r
        end
      when Array
        hsh.map {|el| r_symbolize_keys el}
      else
        hsh
      end
    end
  end
end
