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
        arr << {time: row[0], title: row[1], content: row[2].split(delimiter)}
      end
    end
  end

end