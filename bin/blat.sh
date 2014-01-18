#!/bin/sh
#PBS -l nodes=1:ppn=1
#PBS -l mem=2gb
#PBS -l walltime=200:00:00

cd $PBS_O_WORKDIR

FLANK=200
Prefix=ORU
Genome=/rhome/cjinfeng/BigData/00.RD/Transposon_Oryza/OGE_genomes/O.rufipogon/Oryza_rufipogon_W1943_scaffolds_v1.0.fa
#Genome=/rhome/cjinfeng/BigData/00.RD/Transposon_Oryza/OGE_genomes/O.glaberrima/O.glaberrima.v1.0.fa
#Genome=/rhome/cjinfeng/BigData/00.RD/seqlib/9311_genome.fa

/usr/local/bin/blat -noHead -minIdentity=95 $Genome ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.flanking_$FLANK.fasta ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.flanking_$FLANK.$Prefix.psl

perl /rhome/cjinfeng/software/bin/bestAlign.pl --cutoff 0.70 ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.flanking_$FLANK.$Prefix.psl > ../input/HEG4_EG4_A119_A123_NB_SNPs.noRepeats.selectedSNPs.flanking_$FLANK.$Prefix.best.psl

echo "Done!"
 
