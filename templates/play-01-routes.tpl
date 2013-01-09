# put this code in your module's "conf/routes" file

GET     /<<$tablename>>                 controllers.<<$tablename|capitalize>>.list
GET     /<<$tablename>>/add             controllers.<<$tablename|capitalize>>.add
POST    /<<$tablename>>/add             controllers.<<$tablename|capitalize>>.submit
GET     /<<$tablename>>/:id/edit        controllers.<<$tablename|capitalize>>.edit(id: Long)
GET     /<<$tablename>>/:id/delete      controllers.<<$tablename|capitalize>>.delete(id: Long)
