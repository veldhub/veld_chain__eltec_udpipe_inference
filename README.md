# veld_chain__eltec_udpipe_inference

This chain VELD repo uses [udpipe 1](https://ufal.mff.cuni.cz/udpipe/1) to infer on five ELTeC 
corpora and aggregates their linguistic features into simple overview statistics. 

There are four processing workflows encapsulated in VELD chains. They are described below, and
further details can be found within their respective veld yaml files: 

- [./veld_step1_preprocess.yaml](./veld_step1_preprocess.yaml)
- [./veld_step2_download_models.yaml](./veld_step2_download_models.yaml)
- [./veld_step3_infer.yaml](./veld_step3_infer.yaml)
- [./veld_step4_analyse.yaml](./veld_step4_analyse.yaml)

These chains are also aggregated into a single chain referencing them:
- [./veld_step_all.yaml](./veld_step_all.yaml)

# requirements

Have git and docker compose installed. **Note, that depending on the version of docker or docker
compose, you might need to replace the compose commands below, from `docker compose` to
`docker-compose`.**

# how to replicate

## clone

clone this repo, including all its submodules recursively (this also pulls the ELTeC repos)

```
git clone --recurse-submodules https://github.com/veldhub/veld_chain__eltec_udpipe_inference/
```

After cloning, the chains can be executed [individually](#individual-steps) or by running it in 
[one aggregating chain](#aggregating-chain)

## individual steps

### step 1: preprocessing

This preprocessing converts the ELTeC data from xml into txt files as defined in
[./data/xsl/transformation.xsl](./data/xsl/transformation.xsl). The output of this is saved to
[./data/data_tmp_txt_transformed/](./data/data_tmp_txt_transformed/).

```
docker compose -f veld_step1_preprocess.yaml up
```

### step 2: download udpipe models

udpipe will be used to infer on the data. The models will be downloaded from 
https://lindat.mff.cuni.cz/repository/xmlui/handle/11234/1-3131# .

```
docker compose -f veld_step2_download_models.yaml up
```

### step 3: udpipe inference

Input for inference is the data from the previous preproccesing chains, and output is saved to
[./data/data_tmp_conllu_inferenced/](./data/data_tmp_conllu_inferenced/)

```
docker compose -f veld_step3_infer.yaml up
```

### step 4: statistical analysis

Starts a jupyter notebook which can be used for deeper inspection interactively. Inputs are the
inferenced conllu files, and the output statistics are persisted into data veld repo:
https://github.com/veldhub/veld_data__eltec_conllu_stats

```
docker compose -f veld_step4_analyse.yaml up
```

## aggregating chain

All of the individual chains above can be simply run by launching the aggregating chain:

```
docker compose -f veld_step_all.yaml up
```

