#!/usr/bin/env ruby

require 'bio'

if ARGV.length != 1
  puts 'FATAL ERROR: Invalid amount of arguments!'
  puts 'Example: ruby Ex1.rb input_file.gb'
  exit
end

genebank_content = Bio::GenBank.open(ARGV[0])

string_sequence = ''

genebank_content.each_entry do |gc|
	string_sequence << gc.to_biosequence
end

6.times do |frame|
	File.open("fasta_frame_#{frame + 1}.fa", 'w') do |f|
		f.write(Bio::Sequence::NA.new(string_sequence).translate(
				frame + 1,
				1,
				'_'
			).to_fasta
		)
	end
end