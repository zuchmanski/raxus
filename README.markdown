Raxus
=====

Raxus is a gem that helps to easily transfer files or folders from one computer to another on a network. It's a small Ruby script that facilitates transfer of data across networks and only requires the recipient of the files have a Web browser.

When you run command

    raxus ~/some_data/ ~/image.jpg

your folder "some_data" and "image.jpg" will be compressed with *zip*, application will start a mini webserver ([thin](http://code.macournoyer.com/thin/)). Your files are available for download on adress YOUR_IP:5000.

Usage
-----

    Usage: raxus [options] file1 folder1 file2 ...
        -p, --port PORT
        -a, --address ADDRESS
        -l, --limit LIMIT                Set download limit.
        -h, --help                       Show this message

Install
-------

    $ gem install raxus

Licence
-------

[Attribution-Noncommercial-Share Alike 3.0 Unported](http://creativecommons.org/licenses/by-nc-sa/3.0/)
