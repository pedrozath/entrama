class UserMailer < ApplicationMailer
    def notify_sale
        mail(to: "pedro@pedromaciel.com", subject: 'Usuário tentou comprar no PagSeguro') do |f|
            f.text {render text: "usuário com o ip ### entrou no pagseguro para comprar"}
        end
    end
end
