class GraphicPrawnMailer < ApplicationMailer
  default from: ENV['mailer_from']

  def send_file(path)
    attachments['graphic.pdf'] = File.read(path)
    mail(to: ENV['mailer_to'], subject: 'grafico pelo email com prawn')
  end
end
