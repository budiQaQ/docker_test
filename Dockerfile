FROM python
RUN pip install numpy -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN mkdir -p /workfolder
COPY ./main.py /workfolder/
CMD ["python", "/workfolder/main.py"]