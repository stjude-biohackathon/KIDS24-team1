# Django API setup

## Usage

(1) Create and source python virtual environment
```
<code> python3 -m venv env && source env/bin/activate  </code>
```

(2) Create settings.ini file in hackathon24Team1 folder
```
<code>
		[Settings]
		secret_key = <secret_key>
		allowed_hosts = <ip/host name>
		static_root = <directory location for static files used by admin screens>
		debug = <boolean>
	</code>
```

(3) Run pip install -r requirements.txt to install required packages
(4) Run ./manage.py migrate
(5) Run ./manage.py collectstatic
(6) To run dev server:

```
	<code> ./manage.py runserver </code>
```	
	
## Folder content

This folder contains the Django API setup framework.


## Folder structure 

The structure of this folder is as follows:

```
├── services
|  └── api
|      └── hackathon24Team1
|          ├── hackathon24Team1
|          ├── manage.py
|          ├── omicsbackend
|          ├── README.md
|_________ └── requirements.txt
```