@ECHO OFF

CMD /C cpan App::cpanminus
CMD /C cpanm --notest Test::TCP
CMD /C cpanm --notest POE
CMD /C cpanm --installdeps .
