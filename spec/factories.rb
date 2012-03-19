FactoryGirl.define do
  factory :carga do
    sequence (:numero) { |n| "#{n}"}
    peso "505"
    data_max_desembarque {Date.today + 10.days}
    porto_origem {FactoryGirl.create :porto}
    porto_destino {FactoryGirl.create :porto}
    agente {FactoryGirl.create :agente}
  end

  factory :porto do
    sequence (:nome) { |n| "Porto #{n}"}
  end

  factory :agente do
    sequence (:nome) { |n| "agente #{n}"}
  end

  factory :viagem do
    sequence (:data_chegada) {|n| Date.today + n.days}
    porto_origem {FactoryGirl.create :porto}
    porto_destino {FactoryGirl.create :porto}
    navio {FactoryGirl.create :navio}
  end

  factory :navio do
    sequence (:nome) { |n| "Navio #{n}"}
    capacidade 1000 
  end
end