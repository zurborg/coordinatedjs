coordinatedjs
=============

coordinated.js is a coordinated time service based on moment.js - to get server-time on client-side

# How does it work?

When you are familiar with moment.js, its very easy!

```html
<script src="//coordinatedjs.com/now.js"></script>
<script>
  $moment().format();
</script>
```

coordinated.js introduces a new global variable, ```$moment```, which behaves similiar to ```moment```, but with a fixed offset calculated when your document is loaded. Only time-parsing is not supported by ```$moment(...)``` - use ```moment(...)``` instead. Bonus: ```$moment.utc()``` works as expected.

In modern browsers, ```window.performance``` can be used to obtain the load delay and coordinated.js adds it to the offset. This allowes to get a real accurate server-time synchronized in the browser.

# Available services

coordinatedjs.com provides three services free for you:

+ ```//coordinatedjs.com/now.js``` Requires moment.js.
+ ```//coordinatedjs.com/full.js``` Provides moment.min.js (latest version) and coordinated.js
+ ```//coordinatedjs.com/full-with-locales.js``` Provides moment-with-locales.min.js (latest version) and coordinated.js

# Reliability and limitations

In cases where you wont rely on the time settings in the client' browser, you are able to rely on coordinated.js. With window.performance the accuracy is about one quarter of a second. In other cases it depends on the lag caused by slow and/or instable internet connections which cannot be determined. Maybe a SNTP implementing javascript class could calculate the offset in such cases, but I want to keep the service simple and easy to use.

The SSL certificate is shipped by CAcert.

# Availability and terms of use

For now, this service is is hosted on a virtual machine. I hope the machine will never die.

Feel free to use coordinated.js in any of your projects without any fee. You don't need to - but I recommend to - provide a notice that you use the services of coordinated.js.

### License

The service is provided "as is" and the author disclaims all warranties with regard to this service including all implied warranties of merchantability and fitness. In no event shall the author be liable for any special, direct, indirect, or consequential damages or any damages whatsoever resulting from loss of use, data or profits, whether in an action of contract, negligence or other tortious action, arising out of or in connection with the use or performance of this service.
