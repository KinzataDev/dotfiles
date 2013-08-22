au BufNewFile,BufRead *.tt2 setf tt2html
au BufNewFile,BufRead *.tt setf tt2html


"   define START_TAG, END_TAG
       "ASP"
"       :let b:tt2_syn_tags = '<% %>'
       "PHP"
"       :let b:tt2_syn_tags = '<? ?>'
      "TT2 and HTML"
       let b:tt2_syn_tags = '\[% %] <!-- -->'
"
