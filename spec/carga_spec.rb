require './spec/spec_helper'

describe Carga do
  it { should_not have_valid(:numero).when(nil) }
  it { should_not have_valid(:peso).when(nil) }
  it { should_not have_valid(:data_max_desembarque).when(nil) }
  it { should_not have_valid(:porto_origem).when(nil) }
  it { should_not have_valid(:porto_destino).when(nil) }
  it { should_not have_valid(:agente).when(nil) }

end