# HSNN
This is the source code of our MMM paper "Effective Heterogeneous Similarity Measure with Nearest Neighbors for Cross-Media Retrieval", Please cite the following paper if you use our code.

Xiaohua Zhai, Yuxin Peng, and Jianguo Xiao, "Effective Heterogeneous Similarity Measure with Nearest Neighbors for Cross-Media Retrieval", 18th International Conference on MultiMedia Modeling (MMM), pp. 312-322, Klagenfurt, Austria, Jan. 4-6, 2012. 

# Usage
Run our script to train and test:
 
    HSNN.m

The parameters are as follows:

    I_tr: the feature matrix of image instances for training, dimension : tr_n * d_i
    T_tr: the feature matrix of text instances for training, dimension : tr_n * d_t
    I_te: the feature matrix of image instances for test, dimension : te_n * d_i
    T_te: the feature matrix of text instances for test, dimension : te_n * d_t
    trainCat: the category list of data for training, dimension : tr_n * 1
    testCat: the category list of data for test, dimension : te_n * 1
    k: kNN parameter, default: 30

XMedia dataset can be downloaded from [XMedia Dataset](http://www.icst.pku.edu.cn/mipl/xmedia)

For more information, please refer to our [paper](http://www.icst.pku.edu.cn/mipl/tiki-download_file.php?fileId=289)

# Related work
If you are interested in cross-media retrieval, check our paper:

Yuxin Peng, Xin Huang, and Yunzhen Zhao, "An Overview of Cross-media Retrieval: Concepts, Methodologies, Benchmarks and Challenges", IEEE Transactions on Circuits and Systems for Video Technology (TCSVT), 2017.

Visit our [benchmark website](www.icst.pku.edu.cn/mipl/xmedia) and [laboratory homepage](www.icst.pku.edu.cn/mipl) for more information.
