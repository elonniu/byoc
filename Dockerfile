# Use your base docker image
#FROM public.ecr.aws/aws-gcr-solutions/stable-diffusion-aws-extension/aigc-webui-inference:v1.2.1-98fd22d-dev
FROM public.ecr.aws/aws-gcr-solutions/stable-diffusion-aws-extension/aigc-webui-inference:v1.2.1-98fd22d

# Download the roop extension
RUN cd /opt/ml/code/extensions/ && \
    git clone https://github.com/s0md3v/sd-webui-roop.git && \
    git clone https://github.com/adieyal/sd-dynamic-prompts.git && \
    cd sd-dynamic-prompts && \
    git checkout tags/v2.17.0 && \
    cd ../ && \
    git clone https://github.com/Bing-su/adetailer.git && \
    cd adetailer && \
    git checkout tags/v23.10.1 && \
    cd ../ && \
    mkdir -p /opt/ml/code/models/ESRGAN/ && \
    cd /opt/ml/code/models/ESRGAN/ && \
    wget https://huggingface.co/gemasai/4x_NMKD-Siax_200k/resolve/main/4x_NMKD-Siax_200k.pth?download=true -O 4x_NMKD-Siax_200k.pth

ADD api.py /opt/ml/code/extensions/stable-diffusion-aws-extension/scripts/
ADD mme_utils.py /opt/ml/code/extensions/stable-diffusion-aws-extension/aws_extension/
ADD models.py /opt/ml/code/extensions/stable-diffusion-aws-extension/aws_extension/

ADD sync_file.sh /opt/ml/code/

ENTRYPOINT ["/bin/bash", "-c", "/opt/ml/code/sync_file.sh & exec python /opt/ml/code/serve"]
