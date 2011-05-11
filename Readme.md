K3cms Contact Form
==================

Easily add a contact form to your K3cms app with this gem.

Getting started
===============

Go to <http://localhost:3000/contact_forms>, turn on edit mode, and click "New contact form".

It will ask you for a recipient_email address. All form submissions from this contact form will be e-mailed to the address given here.

Customizing
===========

You can customize what appears above the form by simply clicking in the "header" editable area and start editing.

If you want to customize the form itself, you can't do it via the UI, but you can still do it:

Since the form is in its own template file, you can override it and replace it with a custom version of your own simply by creating a file with this path in your app: 

    app/cells/k3cms/contact_form/contact_forms/_form.html.haml

Design background
=================

It might seem a bit redundant to have a ContactsController and ContactFormsController and ContactFormsCell but here is why we have all of them:

* ContactFormsCell: lets us use it on a widget on any page -- ContactFormsCell is responsible for rendering a ContactForm and is used anywhere the form needs to be displayed
* ContactFormsController: lets admins create, modify, and delete contact forms; also, this lets us have a unique RESTful route/URL for each contact form resource, the 'show' route will be used to display the form to normal users (until we change it to allow the form to be placed on the page, and then it should use the custom URL for that page...)
* ContactsController: provides a RESTful route for the end user to submit the form too, creating a new "contact" (this is different than creating a new contact *form*, which is why it needs a different controller)

Also note the difference between app/views/k3cms/contact_form/contact_forms/show.html.haml and app/cells/k3cms/contact_form/contact_forms/show.html.haml:

* app/views/k3cms/contact_form/contact_forms/show.html.haml:
  * renders the contact form on a page by itself (and sets title of the document)
  * accessible to outside world via a route to ContactFormsController
  * does little more than render app/cells/k3cms/contact_form/contact_forms/show.html.haml 
* app/cells/k3cms/contact_form/contact_forms/show.html.haml:
  * renders the contact form itslef
  * not accessible directly to the outside world via any controller/route

By having these views in the cell instead of the controller, we can make it a widget on any page: it doesn't have to be the only thing on the page and have the entire page to itself.
To demonstrate this (since K3cms doesn't actually let you place widgets yet), you can go to /contact_forms and see multiple working contact forms on a single page.

Contributing
============

Please submit a pull request at: http://github.com/k3integrations/k3cms_contact_form

Bugs can be reported at: http://github.com/k3integrations/k3cms_contact_form/issues

License
=======

Copyright 2011 [K3 Integrations, LLC](http://www.k3integrations.com/)

k3cms_contact_form is free software, distributed under the terms of the [GNU Lesser General Public License](http://www.gnu.org/copyleft/lesser.html), Version 3 (see License.txt).
