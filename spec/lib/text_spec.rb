# frozen_string_literal: true

RSpec.describe TableInspector::Text do
  let(:text) { 'text' }

  describe "#bold" do
    it "return the bold text" do
      expect(described_class.bold(text)).to eq("\033[1m#{text}\033[0m")
    end
  end

  describe "#break_line" do
    it 'output the "\n"' do
      expect do
        described_class.break_line
      end.to output("\n").to_stdout
    end
  end

  colors_map = {
    red: "\e[31m",
    green: "\e[32m",
    yellow: "\e[33m",
    blue: "\e[34m",
    cyan: "\e[36m",
  }
  colors_map.each do |color, code|
    describe "##{color}" do
      it "return the text with #{color} color" do
        expect(described_class.send(color, text)).to eq("#{code}#{text}\e[0m")
      end
    end
  end
end