require 'spec_helper'

describe Post do
  it { should respond_to(:latitude) }
  it { should respond_to(:longitude) }
end