ElasticSearch On DotCloud (ALPHA)
=================================

This is an **ALPHA** (i.e., not production-ready) ElasticSearch stack
for DotCloud.


How It Works
------------

This downloads an ElasticSearch build from the official download site.
The build is not totally DotCloud-compliant for two reasons:

* it does not support scaling (yet),
* it is insecure by default - you have to explicitly enable authentication
  if you want it.

Again: **don't use this for production!**

ElasticSearch support on dotCloud is constantly improving.


How To Use It (Standalone)
--------------------------

Just use our (un)patented Clone-And-DotCloud-Push method::

  git clone git://github.com/dotcloud/elasticsearch-on-dotcloud-ALPHA.git
  dotcloud push h2g2 elasticsearch-on-dotcloud-ALPHA

At the end of the push, the URL to ElasticSearch will be shown.
Give it a few extra seconds to start up (don't panic if hitting the
URL within the first minute after the push yields an error page).


How To Use It (In Your App)
---------------------------

Add the ``dotcloud.yml`` supplied here to your own ``dotcloud.yml``,
and copy the ``elasticsearch`` directory to your repository as well.
Push as usual. Rejoice (but remember not to put any important stuff into
your ElasticSearch yet).


Authentication
--------------

If you define a login/password using ELASTICSEARCH_LOGIN
and ELASTICSEARCH_PASSWORD they will be used for authentication.

If your elasticsearch app is named ``h2g2`` like in the example above,
you can run something like::

  dotcloud var set h2g2 ELASTICSEARCH_LOGIN=marvin ELASTICSEARCH_PASSWORD=zaphod

If both variables are defined, the HTTP Basic Auth plugin will be enabled.
Otherwise, it will be left out, and your ElasticSearch service will be
usable by anyone knowing its URL.


Vertical Scaling
----------------

If you are paying for dotCloud, you can scale vertically (=add more RAM)
to your service, with the following dotCloud command::

  dotcloud scale hg2g elasticsearch:memory=1G

You must then update the ElasticSearch heap size, by setting the following
runtime variable:

  dotcloud var set hg2g ELASTICSEARCH_HEAPSIZE=800m

Depending on the size of your data set and your access pattern, it could
be wise to use between 50% and 90% of your dotCloud memory reservation for
ElasticSearch heap size.
