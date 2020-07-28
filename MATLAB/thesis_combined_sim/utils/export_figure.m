function export_figure(filename)

s=hgexport('readstyle','MSWord');
s.Format = 'eps'; %I needed this to make it work but maybe you wont.
hgexport(gcf,filename,s);

end