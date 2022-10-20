FROM python:3.9-slim-buster

WORKDIR /opt/app
COPY . ./
RUN pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip3 install -r src/requirements.txt \
    && pip3 install --upgrade protobuf==3.20.1 \
    && pip install -e src
#    && cp src/ankisyncd.conf src/ankisyncd/ #如果不通过环境变量，则加入此行，构建镜像时候设置好

EXPOSE 27701

CMD ["python3", "-m", "ankisyncd"]
