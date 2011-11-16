Tumblelog, the roar demo

I wanted an app to showcase some of Roar's capabilities, so I put up a "tumblelog":http://roardemo.nanoware.com.

<a href="http://roardemo.nanoware.com"><img src="https://github.com/wvl/roar/raw/master/web/posts/img/tumblelog_frontend_500.png" /></a>

One of the things it highlights is the ability to break out of the admin backend and easily edit resources in place.  If there's interest, I might go into a more detailed walkthrough of building this app.  In the meantime, grab the source, check it out, and let me know if there are any questions.

<img src="https://github.com/wvl/roar/raw/master/web/posts/img/tumblelog_backend.png" />

Getting started:

"Download from rubyforge":http://rubyforge.org/frs/?group_id=2958

Create a database (<code>mysqladmin create tumblelog_development</code>), or edit database.yml to suit, run <code>rake db:migrate</code>, and start the application with <code>ruby ./script/server</code>.


*Update*: I find it rather amusing that the day I put up a tumblelog as a technology demo, I find "tumblr":http://tumblr.com, a pretty nifty (and free!) tumblelog provider.  If anyone is actually expecting that this tumblelog software will do anything useful... don't!  If you want a tumblelog, go to "tumblr":http://tumblr.com.  
