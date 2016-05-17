class UserMailer < ApplicationMailer
    def notify_sale ip
        mail(to: "pedro@pedromaciel.com", subject: 'Usuário tentou comprar no PagSeguro') do |f|
            f.text {render text: "usuário com o ip #{ip} entrou no pagseguro para comprar"}
        end
    end
end
