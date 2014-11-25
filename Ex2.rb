#!/usr/bin/env ruby

require 'bio'

if ARGV.length != 1
  puts 'FATAL ERROR: Invalid amount of arguments!'
  puts 'Example: ruby Ex2.rb input_file.fa'
  exit
end

blast = Bio::Blast.remote('blastp', 'swissprot', '-e 0.0001', 'genomenet')

fasta_content = Bio::FlatFile.open(Bio::FastaFormat, ARGV[0])

File.open('out.blast', 'w') do |f|
  fasta_content.each_entry do |fc|
    report = blast.query(fc.seq)
    report.hits.each_with_index do |hit, hit_index|
      f.puts '________________________________________________'
      f.puts "Hit number: #{hit_index}"
      f.puts hit.accession  
      f.puts hit.definition
      f.puts " * Query length: #{hit.len}"
      f.puts " * Identities number: #{hit.identity}"
      f.puts " * Overlapping: #{hit.overlap}"
      f.puts " * % Overlapping: #{hit.percent_identity}"
      f.puts " * Query sequence: #{hit.query_seq}"
      f.puts " * Target sequence: #{hit.target_seq}"
      hit.hsps.each_with_index do |hsps, hsps_index|
        f.puts " * Bit score: #{hsps.bit_score}"
        f.puts " * Gaps: #{hsps.gaps}"
      end
    end
  end
end