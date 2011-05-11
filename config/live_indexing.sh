#!/bin/bash

indexer --config production.sphinx.conf --rotate store_delta
indexer --config production.sphinx.conf --merge store_core store_delta --merge-dst-range deleted 0 0 --rotate
