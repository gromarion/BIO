#!/usr/bin/env ruby

require 'bio'

if ARGV.length != 1
  puts 'FATAL ERROR: Invalid amount of arguments!'
  puts 'Example: ruby Ex2.rb input_file.fa [output_file.bl]'
  exit
end

blast = Bio::Blast.remote('blastp', 'swissprot', '-e 0.0001', 'genomenet')

entries = Bio::FlatFile.open(Bio::FastaFormat, ARGV[0])
puts("entries = #{entries}")

File.open('out.blast', 'w') do |f|
  entries.each_entry do |entry|
    report = blast.query(entry.seq)
    report.hits.each_with_index do |hit, hit_index|
      f.puts '------------------------------------------------'
      f.puts "Hit #{hit_index}"
      f.puts hit.accession  
      f.puts hit.definition
      f.puts " - Query length: #{hit.len}"
      f.puts " - Number of identities: #{hit.identity}"
      f.puts " - Length of Overlapping region: #{hit.overlap}"
      f.puts " - % Overlapping: #{hit.percent_identity}"
      f.puts " - Query sequence: #{hit.query_seq}"
      f.puts " - Subject sequence: #{hit.target_seq}"
      hit.hsps.each_with_index do |hsps, hsps_index|
        f.puts " - Bit score: #{hsps.bit_score}"
        f.puts " - Gaps: #{hsps.gaps}"
      end
    end
  end
end