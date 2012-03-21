#encoding: utf-8
require './spec/spec_helper'

describe Agente do
  it { should_not have_valid(:nome).when(nil) }
  it { should_not have_valid(:porto).when(nil) }
end