# ![veld chain](https://raw.githubusercontent.com/veldhub/.github/refs/heads/main/images/symbol_V_letter.png) veld_chain__eltec_udpipe_inference

This chain VELD repo uses [udpipe 1](https://ufal.mff.cuni.cz/udpipe/1) to infer on five ELTeC 
corpora and aggregates their linguistic features into simple overview statistics. 

These code velds are reused here:

- https://github.com/veldhub/veld_code__xml_xslt_transformer
- https://github.com/veldhub/veld_code__downloader
- https://github.com/veldhub/veld_code__udpipe
- https://github.com/veldhub/veld_code__analyse_conllu

## requirements

- git
- docker compose (note: older docker compose versions require running `docker-compose` instead of 
  `docker compose`)

Clone this repo with all its submodules
```
git clone --recurse-submodules https://github.com/veldhub/veld_chain__eltec_udpipe_inference.git
```

## how to reproduce

After cloning, the chains can be executed [individually](#individual-steps) or by running it all
together in one [aggregated chain](#aggregated-chain)

### individual steps

**[./veld_step1_preprocess.yaml](./veld_step1_preprocess.yaml)**

This preprocessing converts the ELTeC data from xml into txt files as defined in
[./data/xsl/transformation.xsl](./data/xsl/transformation.xsl). The output of this is saved to
[./data/data_tmp_txt_transformed/](./data/data_tmp_txt_transformed/).

```
docker compose -f veld_step1_preprocess.yaml up
```

**[./veld_step2_download_models.yaml](./veld_step2_download_models.yaml)**

udpipe will be used to infer on the data. The models will be downloaded from 
https://lindat.mff.cuni.cz/repository/xmlui/handle/11234/1-3131# and saved to 
[./data/data_tmp_udpipe_models/](./data/data_tmp_udpipe_models/).

```
docker compose -f veld_step2_download_models.yaml up
```

**[./veld_step3_infer.yaml](./veld_step3_infer.yaml)**

Input for inference is the data from the previous preproccesing chains, and output is saved to
[./data/data_tmp_conllu_inferenced/](./data/data_tmp_conllu_inferenced/)

```
docker compose -f veld_step3_infer.yaml up
```

**[./veld_step4_analyse.yaml](./veld_step4_analyse.yaml)**

Starts a jupyter notebook which can be used for deeper inspection interactively. Inputs are the
inferenced conllu files, and the output statistics are persisted into data veld repo:
https://github.com/veldhub/veld_data__eltec_conllu_stats

```
docker compose -f veld_step4_analyse.yaml up
```

### aggregated chain

**[./veld_step_all.yaml](./veld_step_all.yaml)**

All of the individual chains above can be simply run by launching the aggregated chain:

```
docker compose -f veld_step_all.yaml up
```

