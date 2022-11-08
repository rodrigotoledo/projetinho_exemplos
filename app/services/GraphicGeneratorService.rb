class GraphicGeneratorService
  def self.generate
    Highcharts::Export::Image.configure do |config|
        config.default_options = { :type => :svg }
        config.phantomjs = Phantomjs.path
        # if Rails.env.development?
        # else
        #   config.phantomjs = '/app/vendor/phantomjs/bin/phantomjs'
        # end
    end

    options_js = <<-eos
      {
          chart: {
        type: 'spline',
        width: 1000,
        height: 600
            },
              title: {
        text: 'Monthly Average Temperature'
            },
              subtitle: {
        text: 'Source: WorldClimate.com'
            },
              xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
               'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
            },
              yAxis: {
        title: {
            text: 'Temperature'
          },
                  labels: {
            formatter: function () {
          return this.value + '°';
            }
        }
          },
              tooltip: {
        crosshairs: true,
                  shared: true
            },
              plotOptions: {
        spline: {
            marker: {
          radius: 4,
                          lineColor: '#666666',
                          lineWidth: 1
              }
        }
          },
              series: [{
                  name: 'Tokyo',
          marker: {
                      symbol: 'square'
              },
          data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, {
              y: 26.5,
            marker: {
            symbol: 'url(http://www.highcharts.com/demo/gfx/sun.png)'
                }
          }, 23.3, 18.3, 13.9, 9.6]

          }, {
                  name: 'London',
          marker: {
                      symbol: 'diamond'
              },
          data: [{
              y: 3.9,
            marker: {
            symbol: 'url(http://www.highcharts.com/demo/gfx/snow.png)'
                }
          }, 4.2, 5.7, 8.5, 11.9, 15.2, 17.0, 16.6, 14.2, 10.3, 6.6, 4.8]
          }]
      }
    eos
    files = []
    10.times.each do
      file = Rails.root.join('tmp',File.basename("#{SecureRandom.urlsafe_base64}grafico_glicemia.svg"))
      Highcharts::Export::Image.chart_to_img(options_js, file.to_s)
      files << file.to_s
    end

    file_pdf = Rails.root.join('tmp',File.basename("#{SecureRandom.urlsafe_base64}grafico_glicemia.pdf"))
    Prawn::Document.generate(file_pdf.to_s, :page_layout => :landscape) do
      files.each do |file|
        # image file.to_s, :at => [50,450], :width => 450
        draw_text 'teste', :at => [50,450]
        start_new_page
      end
    end

    GraphicPrawnMailer.send_file(file_pdf.to_s).deliver_now
    files.each do |file|
      # File.delete(file.to_s)
    end
    File.delete(file_pdf.to_s)
  end
end