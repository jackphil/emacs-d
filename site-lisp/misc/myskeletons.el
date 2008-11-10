(define-skeleton rst-skeleton
  "Rst File" nil
  ".. -*- coding: utf-8 -*-\n"
  "\n"
  ""_"\n"
  "\n"
  "..\n"
  "   Local Variables:\n"
  "   mode: rst\n"
  "   indent-tabs-mode: nil\n"
  "   sentence-end-double-space: t\n"
  "   fill-column: 70\n"
  "   End:")

(define-skeleton python-skeleton
  "Python File" nil
  "#! /usr/bin/env python\n"
  "# -*- coding: utf-8 -*-\n"
  "\n"
  "import "_"\n"
  "\n\n"
  "if __name__== \"__main__\" :")