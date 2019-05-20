build:
	cd ./blog_content/; \
	mkdocs build -d ../blog/ ; \

serve:
	cd ./blog_content/; \
	mkdocs serve -a 0.0.0.0:1112;\
