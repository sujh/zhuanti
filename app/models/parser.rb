class Parser

  class << self
    def parse_guests(file)
      sheet = Spreadsheet.open(file).worksheet(0)
      sheet.each_with_index.with_object([]) do |(row, idx), arr|
        next if idx.zero?
        arr << {number: row[0], name: row[1], position: row[2]}
      end
    end

    def parse_agendas(file)
      delimiter = "#@#"
      sheet = Spreadsheet.open(file).worksheet(0)
      sheet.each_with_index.with_object([]) do |(row, idx), arr|
        next if idx.zero?
        content = row[2] ? row[2].split(delimiter).map(&:strip) : []
        arr << {time: row[0], title: row[1], content: content }
      end
    end
  end

end