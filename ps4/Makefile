all:
	make genpush
	(cd src; make all)

check:
	(cd src; make check)

tags:
	(cd src; make tags)

clean:
	rm -f *~
	(cd src; make clean)

test:
	(cd src; make test)

doc:
	(cd src; make doc)

push:
	push.sh

forcepush:
	push.sh -f

force: forcepush

pull:
	pull.sh

forcepull:
	pull.sh -f

genpush:
	gen-svn-push.sh

genpull:
	gen-svn-pull.sh

svnstatus:
	(cd svn; svn status)

svncommit:
	make svnstatus
	(cd svn; svn commit)
