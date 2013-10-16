# jre_install module
# install.pp
# Copyright Francisco Huertas, Center for Open Middleware, Universidad Politecnica de Madrid


class jre_install () {
    include jre_install::params
    include jre_install::install
}

