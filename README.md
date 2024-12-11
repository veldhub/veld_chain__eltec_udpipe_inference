# veld_chain_14_eltec_udpipe_inference

(work in progress and meant to be more of experimental nature, fleshing out the VELD design)

This repo uses [udpipe 1](https://ufal.mff.cuni.cz/udpipe/1) to infer on five ELTeC corpora and
aggregates their linguistic features into simple overview statistics. 

There are three processing workflows encapsulated in VELD chains (docker compose services + VELD
metadata): [veld_preprocess.yaml](./veld_preprocess.yaml), [veld_infer.yaml](./veld_infer.yaml),
[veld_analyse.yaml](./veld_analyse.yaml). Details on each can be found below and within the
respective yaml files.

## requirements

Have git and docker compose installed. **Note, that depending on the version of docker or docker
compose, you might need to replace the compose commands below, from `docker compose` to
`docker-compose`.**

## how to replicate

### clone

clone this repo, including all its submodules recursively (this also pulls the ELTeC repos)

```
git clone --recurse-submodules https://github.com/veldhub/veld_chain__eltec_udpipe_inference/
```

### preprocessing

This preprocessing converts the ELTeC data from xml into txt files as defined in
[./xsl/transformation.xml](./xsl/transformation.xsl). The output of this is saved to
[./data_tmp_txt_transformed/](./data_tmp_txt_transformed/).

```
docker compose -f veld_preprocess.yaml up
```

### udpipe inference

Inference is done with udpipe models downloaded from
https://lindat.mff.cuni.cz/repository/xmlui/handle/11234/1-3131#. Input is the data from the
previous preproccesing chain, and output is saved to
[./data_tmp_conllu_inferenced/](./data_tmp_conllu_inferenced/)

```
docker compose -f veld_infer.yaml up
```

### statistical analysis

Start a jupyter notebook which can be used for deeper inspection interactively. Inputs are the
inferenced conllu files, and the output statistics are persisted into data veld repo:
https://github.com/veldhub/veld_data__eltec_conllu_stats

```
docker compose -f veld_analyse.yaml up
```

