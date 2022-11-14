class GraphicGeneratorService
  def self.generate
    category_data = Category.all
    category_data = category_data.group_by { |t| "#{t.created_at.year}-#{t.created_at.month}-#{t.created_at.day}" }
    categories = category_data.values.flatten
    category_labels = {}
    category_data.keys.each_with_index { |date, index| category_labels[index] = date }
    category_dates = category_data.keys.map.with_index { |date, index| { index => date } }.map { |t| t.values }.flatten

    vehicle_data = Vehicle.all
    vehicle_data = vehicle_data.group_by { |t| "#{t.created_at.year}-#{t.created_at.month}-#{t.created_at.day}" }
    vehicles = vehicle_data.values.flatten
    vehicle_labels = {}
    vehicle_data.keys.each_with_index { |date, index| vehicle_labels[index] = date }
    vehicle_dates = vehicle_data.keys.map.with_index { |date, index| { index => date } }.map { |t| t.values }.flatten

    files = []
    g = Gruff::Line.new(500)
    g.title = 'Categories - Number of Views'
    g.labels = category_labels
    categories.pluck(:name).uniq.each do |category_name|
      g.data category_name, category_dates.map { |t|
        Category.where(name: category_name).where('created_at BETWEEN ? AND ?', t.to_time.beginning_of_day, t.to_time.end_of_day).sum(:qty_of_views)
      }
    end

    file = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}.png"))
    g.write(file.to_s)
    files << file.to_s

    g = Gruff::Line.new(500)
    g.title = 'Vehicles - Number of Views'
    g.labels = vehicle_labels
    vehicles.pluck(:name).uniq.each do |vehicle_name|
      g.data vehicle_name, vehicle_dates.map { |t|
        Vehicle.where(name: vehicle_name).where('created_at BETWEEN ? AND ?', t.to_time.beginning_of_day, t.to_time.end_of_day).sum(:qty_of_views)
      }
    end

    file = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}.png"))
    g.write(file.to_s)
    files << file.to_s

    file_pdf = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}grafico_glicemia.pdf"))
    Prawn::Document.generate(file_pdf.to_s, page_layout: :landscape) do
      files.each do |file|
        image file.to_s, fit: [450, 450], position: :center
        start_new_page
      end
      draw_text 'Thanks =)', at: [10, 10]
    end

    GraphicPrawnMailer.send_file(file_pdf.to_s).deliver_now
    files.each do |file|
      File.delete(file.to_s)
    end
    File.delete(file_pdf.to_s)
  end

  def self.sample
    require 'json'
    options = {
      lang: {
        months: %w[Janvier Fevrier Mars Avril Mai Juin Juillet Aout Septembre Octobre
                   Novembre Decembre],
        weekdays: %w[Dimanche Lundi Mardi Mercredi Jeudi Vendredi Samedi]
      }
    }
    options = JSON.generate(options)

    data = {
      xAxis: {
        type: 'datetime',
        maxZoom: '14 * 24 * 3600000',
        dateTimeLabelFormats: {
          millisecond: '%H:%M:%S.%L',
          second: '%H:%M:%S',
          minute: '%H:%M',
          hour: '%H:%M',
          day: '%e. %b',
          week: '%e. %b',
          month: '%B \\ %y',
          year: '%Y'
        }
      },
      yAxis: {
        min: 0.75
      },
      series: [
        {
          type: 'area',
          name: 'USD to EUR',
          pointInterval: '24 * 3600 * 1000',
          pointStart: 'Date.UTC(2006, 0, 01)',
          data: JSON.generate[
            0.8446,
            0.8445,
            0.8444,
            0.8451,
            0.8418,
            0.8264,
            0.8258,
            0.8232,
            0.8233,
            0.8258,
            0.8283,
            0.8278,
            0.8256,
            0.8292,
            0.8239,
            0.8239,
            0.8245,
            0.8265,
            0.8261,
            0.8269,
            0.8273,
            0.8244,
            0.8244,
            0.8172,
            0.8139,
            0.8146,
            0.8164,
            0.82,
            0.8269,
            0.8269,
            0.8269,
            0.8258,
            0.8247,
            0.8286,
            0.8289,
            0.8316,
            0.832,
            0.8333,
            0.8352,
            0.8357,
            0.8355,
            0.8354,
            0.8403,
            0.8403,
            0.8406,
            0.8403,
            0.8396,
            0.8418,
            0.8409,
            0.8384,
            0.8386,
            0.8372,
            0.839,
            0.84,
            0.8389,
            0.84,
            0.8423,
            0.8423,
            0.8435,
            0.8422,
            0.838,
            0.8373,
            0.8316,
            0.8303,
            0.8303,
            0.8302,
            0.8369,
            0.84,
            0.8385,
            0.84,
            0.8401,
            0.8402,
            0.8381,
            0.8351,
            0.8314,
            0.8273,
            0.8213,
            0.8207,
            0.8207,
            0.8215,
            0.8242,
            0.8273,
            0.8301,
            0.8346,
            0.8312,
            0.8312,
            0.8312,
            0.8306,
            0.8327,
            0.8282,
            0.824,
            0.8255,
            0.8256,
            0.8273,
            0.8209,
            0.8151,
            0.8149,
            0.8213,
            0.8273,
            0.8273,
            0.8261,
            0.8252,
            0.824,
            0.8262,
            0.8258,
            0.8261,
            0.826,
            0.8199,
            0.8153,
            0.8097,
            0.8101,
            0.8119,
            0.8107,
            0.8105,
            0.8084,
            0.8069,
            0.8047,
            0.8023,
            0.7965,
            0.7919,
            0.7921,
            0.7922,
            0.7934,
            0.7918,
            0.7915,
            0.787,
            0.7861,
            0.7861,
            0.7853,
            0.7867,
            0.7827,
            0.7834,
            0.7766,
            0.7751,
            0.7739,
            0.7767,
            0.7802,
            0.7788,
            0.7828,
            0.7816,
            0.7829,
            0.783,
            0.7829,
            0.7781,
            0.7811,
            0.7831,
            0.7826,
            0.7855,
            0.7855,
            0.7845,
            0.7798,
            0.7777,
            0.7822,
            0.7785,
            0.7744,
            0.7743,
            0.7726,
            0.7766,
            0.7806,
            0.785,
            0.7907,
            0.7912,
            0.7913,
            0.7931,
            0.7952,
            0.7951,
            0.7928,
            0.791,
            0.7913,
            0.7912,
            0.7941,
            0.7953,
            0.7921,
            0.7919,
            0.7968,
            0.7999,
            0.7999,
            0.7974,
            0.7942,
            0.796,
            0.7969,
            0.7862,
            0.7821,
            0.7821,
            0.7821,
            0.7811,
            0.7833,
            0.7849,
            0.7819,
            0.7809,
            0.7809,
            0.7827,
            0.7848,
            0.785,
            0.7873,
            0.7894,
            0.7907,
            0.7909,
            0.7947,
            0.7987,
            0.799,
            0.7927,
            0.79,
            0.7878,
            0.7878,
            0.7907,
            0.7922,
            0.7937,
            0.786,
            0.787,
            0.7838,
            0.7838,
            0.7837,
            0.7836,
            0.7806,
            0.7825,
            0.7798,
            0.777,
            0.777,
            0.7772,
            0.7793,
            0.7788,
            0.7785,
            0.7832,
            0.7865,
            0.7865,
            0.7853,
            0.7847,
            0.7809,
            0.778,
            0.7799,
            0.78,
            0.7801,
            0.7765,
            0.7785,
            0.7811,
            0.782,
            0.7835,
            0.7845,
            0.7844,
            0.782,
            0.7811,
            0.7795,
            0.7794,
            0.7806,
            0.7794,
            0.7794,
            0.7778,
            0.7793,
            0.7808,
            0.7824,
            0.787,
            0.7894,
            0.7893,
            0.7882,
            0.7871,
            0.7882,
            0.7871,
            0.7878,
            0.79,
            0.7901,
            0.7898,
            0.7879,
            0.7886,
            0.7858,
            0.7814,
            0.7825,
            0.7826,
            0.7826
          ]
        }
      ]
    }

    data = JSON.generate(data)

    uri = URI('http://export.highcharts.com')
    res = Net::HTTP.post_form(uri,
                              'type' => 'png',
                              'width' => 600,
                              'options' => options,
                              'globaloptions' => data)

    file = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}.png"))
    puts res.read_body
    # File.write(file.to_s, res.body)

    file_pdf = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}grafico_glicemia.pdf"))
    Prawn::Document.generate(file_pdf.to_s, page_layout: :landscape) do
      # 10.times.each do
      #   image file.to_s, fit: [450, 450], position: :center
      #   start_new_page
      # end
      draw_text 'Thanks =)', at: [10, 10]
    end

    GraphicPrawnMailer.send_file(file_pdf.to_s).deliver_now
    # File.delete(file.to_s)
    File.delete(file_pdf.to_s)
  end
end
