# put this code in your module's "conf/routes" file

GET     /<<$tablename>>                 controllers.<<$tablename|capitalize|replace:'_':''>>.list
GET     /<<$tablename>>/add             controllers.<<$tablename|capitalize|replace:'_':''>>.add
POST    /<<$tablename>>/add             controllers.<<$tablename|capitalize|replace:'_':''>>.submit
GET     /<<$tablename>>/:id/edit        controllers.<<$tablename|capitalize|replace:'_':''>>.edit(id: Long)
GET     /<<$tablename>>/:id/delete      controllers.<<$tablename|capitalize|replace:'_':''>>.delete(id: Long)
