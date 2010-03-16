#!/usr/bin/env ruby
require 'rubygems'
require 'gnuplot'

def plot_info arquivo_de_dados, indice, nome
  Gnuplot::DataSet.new( "\"#{arquivo_de_dados}\"" ) do |ds|
    ds.using = "1:#{indice}"
    ds.with = 'lines'
    ds.linewidth = 3
    ds.title = nome
  end
end

def plot nome_imagem, arquivo_de_dados, colunas, tamanho = "800, 400"
  Gnuplot.open do |gp|
    Gnuplot::Plot.new( gp ) do |plot|
      plot.set "terminal png size #{tamanho} xffffff x000000 x202020 xA0A0A0 xC0C0C0 x606060"
      plot.set 'output', "#{nome_imagem}.png"
      plot.title  nome_imagem
      plot.set 'nogrid'
      plot.set 'xdata', 'time'
      plot.set 'timefmt', '"%d-%m-%Y"'
      plot.xrange "[\"03-07-2009\":\"18-02-2010\"]"
      plot.set 'xtics', "nomirror \"03-07-2009\", 2419200, \"18-02-2010\""
      plot.yrange "[0:100]"

      colunas.each_with_index do |coluna, indice|
        plot.data << plot_info(arquivo_de_dados, indice+2, coluna)
      end
    end
  end
end

grafico = ARGV[0]
nome_arquivo = ARGV[1]
colunas = ARGV[2..-1]

if File.exists? nome_arquivo
  plot grafico, nome_arquivo, colunas
else
  puts "Arquivo passado não existe"
end

