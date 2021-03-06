"""Extract text content from files using a specific extractor."""

import os, sys
from optparse import OptionParser

from content_extraction.cleanup import PageCleaner


parser = OptionParser("usage: %prog [options] extractor input_files_or_dirs...",
                      description="""Extract text content from files using a specific extractor.
                                     Parameter 'extractor' can be either 'cleanup' or the path to a python module
                                     providing a specific extractor implementation (see examples/*.py).""")

parser.add_option("-e", "--encoding", dest="encoding", 
                  help="character encoding of the input files (by default, encoding will be guessed automatically)",
                  metavar="ENC",
                  default=None)

parser.add_option("-o", "--output_dir", dest="output_dir", 
                  help="output directory where the output will be stored (default: write output to STDOUT)", 
                  metavar="DIR",
                  default=None)

parser.add_option("-f", "--flat", dest="flatten_files", action="store_true",
                  help="""flatten directory structure and assign simple numerical filenames to output files
                          (default: keep filenames as they were in the input);
                          this option only makes sense if --output_dir is used""", 
                  default=False)

parser.add_option("-w", "--overwrite", dest="overwrite", action="store_true",
                  help="overwrite existing files in the output directory (default: only extract content for files absent in the output directory)", 
                  default=False)

parser.add_option("-O", "--output_format", dest="output_format", 
                  help="output format: 'xml', 'html' or 'txt' (default: xml)", 
                  default='xml')

parser.add_option("-m", "--cleanup_model", dest="cleanup_model", 
                  help="""file containing a website-specific cleanup model, generated by learn_cleanup_model.py
                          (default: don't perform site-specific cleanup)""", 
                  metavar="FILE",   
                  default=None)

parser.add_option("-t", "--cleanup_threshold", dest="cleanup_threshold", 
                  help="""threshold for controling site-specific cleanup: a number between 0 and 1; higher value = more conservative cleanup
                          (default: 0.1)""", 
                  type='float',        
                  metavar="NUM",   
                  default=0.1)
                  
                  
(options, params) = parser.parse_args()
   
if len(params) < 2:
    parser.print_help()
    exit(1)
    
extractor_name = params[0]
input_files = params[1:]

# Initialize extractor
if extractor_name == 'cleanup':
    extractor_class = PageCleaner
else:    
    extractor_path, extractor_module = os.path.split(extractor_name)
    if extractor_path:
        sys.path.insert(0, extractor_path)
    extractor_module = extractor_module.replace(".py", "")    
    imported = __import__(extractor_module, globals(), locals(), ['extractor'], -1)
    extractor_class = imported.extractor
    if extractor_path:
        sys.path.pop(0)

extractor = extractor_class(**options.__dict__)

# Call extractor for all input files/dirs
extractor.extract(files=input_files, output=sys.stdout)

