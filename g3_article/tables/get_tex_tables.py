from __future__ import print_function

import os
import sys
import glob
import shutil
import genomic_neuralnet.analyses.plots as plts

_this_dir = os.path.dirname(os.path.realpath(__file__))

def main():
    """ Copy tables from the genomic_neuralnet codebase to this directory. """
    figure_dir = os.path.dirname(plts.__file__)
    texs = glob.glob(os.path.join(figure_dir, '*.tex'))
    for tex in texs:
        print('copying {} to {}/'.format(os.path.basename(tex), _this_dir))
        shutil.copy(tex, _this_dir)

if __name__ == '__main__':
    main()
