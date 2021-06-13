class Debug
  def self.loop
    Pathname.glob("/Users/jinx/Desktop/throne/*mp3").each do |file|
      `fpcalc "#{file.to_s}" > "#{file.to_s.gsub('mp3','txt')}"`
    end
  end
end
