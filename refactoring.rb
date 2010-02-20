#!/usr/bin/env ruby
require 'rubygems'
require 'gnuplot'

def plot nome_imagem, arquivo_de_dados, tamanho = "800, 400"
  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.set "terminal png size #{tamanho}"
      plot.set 'output', "#{nome_imagem}.png"
      plot.title  "Refactoring time per iteration"
      plot.set 'nogrid'
      plot.xrange "[1:20]"
      plot.yrange "[0:40]"

      plot.data << Gnuplot::DataSet.new( "\"#{arquivo_de_dados}\"" ) do |ds|
        ds.using = '1:2'
        ds.with = 'lines'
        ds.linewidth = 3
        ds.title = 'Refactoring spent time'
      end
    end
  end
end

grafico = "refactoring"
nome_arquivo = "#{grafico}.txt"
plot(grafico, nome_arquivo) if(File.exists? nome_arquivo)

