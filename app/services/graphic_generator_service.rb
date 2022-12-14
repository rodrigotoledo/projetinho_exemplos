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
    require 'uri'
    require 'net/http'
    # url = URI('http://export.highcharts.com/')
    # http = Net::HTTP.new(url.host, url.port)
    # request = Net::HTTP::Post.new(url)
    # request['Content-Type'] = 'application/json'
    # request.body = '{"infile":{"title": {"text": "Steep Chart"}, "xAxis": {"categories": ["Jan", "Feb", "Mar"]}, "series": [{"data": [29.9, 71.5, 106.4]}]}}'
    # response = http.request(request)
    # puts response.read_body
    # puts "response #{res.body}"

    global_options = { infile: { title: { text: 'Steep Chart' }, xAxis: { categories: %w[Jan Feb Mar] },
                                 series: [{ data: [29.9, 71.5, 106.4] }] } }
    # data = { type: 'png', width: 600, globalOptions: global_options }
    # response = Net::HTTP.post_form(url, global_options)

    uri = URI.parse('http://export.highcharts.com/')
    http = Net::HTTP.new(uri.host, uri.port)

    data = { globalOptions: global_options }
    request = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
    request.body = { infile: { title: { text: 'Steep Chart' }, xAxis: { categories: %w[Jan Feb Mar] },
                               series: [{ data: [29.9, 71.5, 106.4] }] } }.to_json

    response = http.request(request)

    file = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}.png"))
    puts response.body
    # File.write(file.to_s, response.body)

    # file_pdf = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}grafico_glicemia.pdf"))
    # Prawn::Document.generate(file_pdf.to_s, page_layout: :landscape) do
    # 10.times.each do
    #   image file.to_s, fit: [450, 450], position: :center
    #   start_new_page
    # end
    # draw_text 'Thanks =)', at: [10, 10]
    # end

    # GraphicPrawnMailer.send_file(file_pdf.to_s).deliver_now
    # File.delete(file.to_s)
    # File.delete(file_pdf.to_s)
  end

  def self.generator
    require 'net/http'
    require 'uri'

    uri = URI.parse('http://export.highcharts.com')
    request = Net::HTTP::Post.new(uri)
    request.content_type = 'application/json'

    chart_options = { infile: { title: { text: 'Roda essa treta' }, xAxis: { categories: %w[Jan Feb Mar] },
                                series: [{ data: [29.9, 71.5, 106.4] }] } }.to_json

    request.body = chart_options

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    file = Rails.root.join('tmp', File.basename("#{SecureRandom.urlsafe_base64}.png"))
    File.write(file.to_s, response.body.force_encoding('UTF-8'))
  end
end
