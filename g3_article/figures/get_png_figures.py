from __future__ import print_function

import os
import sys
import glob
import shutil
import genomic_neuralnet.analyses.plots as plts

_this_dir = os.path.dirname(os.path.realpath(__file__))

def main():
    """ Copy figures from the genomic_neuralnet codebase to this directory. """
    figure_dir = os.path.dirname(plts.__file__)
    pngs = glob.glob(os.path.join(figure_dir, '*.png'))
    for png in pngs:
        print('copying {} to {}/'.format(os.path.basename(png), _this_dir))
        shutil.copy(png, _this_dir)

if __name__ == '__main__':
    main()
