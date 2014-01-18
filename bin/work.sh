echo "convert vcf to table"
perl vcf2table.pl --vcf ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.vcf > ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.table

echo "generate flanking sequence from table"
perl SNP_flanking.pl --table ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.table

echo "blat to ancestor genome"
qsub blat.sh

echo "parse blat result to produce a vcf for ancestor state"
perl blat2state.pl --flank 100 > log 2> log2 &

echo "Sum SNP spectrum"
python SNPspectrum.py --SNP ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.vcf --ancestor ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.flanking_200.ORU.ancestor.vcf
python SNPspectrum_recentpair.py --SNP ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.vcf --ancestor ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.flanking_200.ORU.ancestor.vcf
python SNPspectrum_landracepair.py --SNP ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.vcf --ancestor ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.flanking_200.ORU.ancestor.vcf

