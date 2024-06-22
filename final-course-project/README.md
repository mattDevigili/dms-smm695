# Final course project -- 2024

<p align="middle">
  <img src="https://quantifiedself.com/wp-content/uploads/2015/07/Graph4_red_black.png" width="250" />
</p>

For the final course project (fcp), you will handle a real-world dataset. In
particular, you are required to store, manipulate, and analyze
naturally-occurring data emerging from a sample of 15 [Decentralized Autonomous
Organizations](https://en.wikipedia.org/wiki/Decentralized_autonomous_organization)
(DAOs). The stream of data centers on the Temperature Check (Snapshot Poll) step of the communities'
[Governance
Process](https://gov.uniswap.org/t/community-governance-process-update-jan-2023/19976).

DAOs are digital-first entities that operate without a central authority, using
smart contracts to automatically enforce rules. Members, who hold the DAO's
native tokens, make decisions collectively. This decentralized structure sharply
contrasts with traditional companies, challenging conventional managerial
assumptions about organizational operation (Hsieh and Vergne, 2023). This
innovative model has attracted interest from researchers across various
disciplines, including information systems, management, and sociology.

Yet, the relevance of DAOs extends beyond academic curiosity; they also hold
significant business implications. For instance, DAOs can streamline operations
by reducing administrative overhead, enhancing transparency and trust among
stakeholders, and facilitating global collaboration without the need for physical
offices. Additionally, DAOs offer unique compensation structures, allowing
contributors to earn tokens to complete specific tasks. Ultimately, DAOs may guide the next phase of
organizational technologies, fostering more democratic, flexible, and fulfilling
work environments based on remote collaboration.

> A prime example is Uniswap, a decentralized exchange that operates as a DAO.
> Uniswap allows users to trade cryptocurrencies directly without intermediaries,
> using automated smart contracts. The DAO structure enables token holders to vote
> on important decisions, such as protocol upgrades and fee structures, ensuring
> that the community has a direct say in the platform's development. This model
> has proven successful, with Uniswap becoming one of the largest and most trusted
> decentralized exchanges in the world.  Uniswap's experience demonstrates how
> DAOs can efficiently manage and grow complex projects, providing fresh business
> and research insights.

<p align="middle">
  <img src="https://github.com/mattDevigili/dms-smm695/tree/master/final-course-project/img/snap.png" width="100" />
</p>

The first chunk of data comes from [Snapshot](https://docs.snapshot.org/introduction). Snapshot is a decentralized voting
system used by DAOs to make collective decisions. It allows token holders to
propose and vote on various issues, such as protocol upgrades, project funding,
and governance changes:

_``Users can then create proposals for the space and vote on them. Space admins can
define the rules for proposal creation and casting a vote by setting up voting
and validation strategies. For example only users holding a minimum of 10K of
specified token can create a new proposal and the voting power of users is
proportional to the balance of the specified token in their wallet''_ (Snapshot
docs).

Snapshot's key feature is its off-chain voting mechanism, which ensures that
votes are transparent and easily verifiable. This platform is widely adopted
within the Web3 community.

<p align="middle">
  <img src="https://github.com/mattDevigili/dms-smm695/tree/master/final-course-project/polygon.png" width="100" />
  <img src="https://github.com/mattDevigili/dms-smm695/tree/master/final-course-project/ether.png" width="100" />
</p>

The second chunk of data contains address-level information collected from
[Polygonscan](https://info.polygonscan.com/what-is-polygonscan/) and
[Ethscan](https://etherscan.io/aboutus). The former is a blockchain explorer
specifically designed for the Polygon network. It allows users to search and
view detailed information about transactions, addresses, tokens, smart
contracts, and blocks on the Polygon blockchain. Polygonscan provides
transparency and accessibility, enabling users to track and verify on-chain
activity. Ethscan is a similar blockchain explorer for the Ethereum network.

## Tasks

You are required to choose your preferred DBMS -- PostgreSQL or MongoDB -- and:

1. Clean, manipulate, and structure data. The expected result is a well-designed
   dataset that complies with the specific approach of the chosen DBMS.
2. Provide valuable descriptive insights. The expected result is a set of
   descriptive statistics that depicts some interesting trends or noteworthy
   data characteristics.
3. _[optional]_ Perform insightful data analysis. For example, you can
   try to uncover how leadership emerges in such digital settings (Banks et al., 2022). If this topic does not
   fit your interests, you may want to skim through the reference list
   provided to get some inspiration.

To perform tasks 1 and 2, you need to use either `SQL` or `MQL` (MongoDB query
language).  Alternatively, if you prefer using Python, you can leverage
`psycopg2` or `pymongo`.  For what concerns task 3, you should use `PySpark`
(e.g., you may want to leverage the
[MLlib](https://spark.apache.org/docs/latest/api/python/reference/pyspark.ml.html)
pyspark library).

## Data

The `fcp` is based on naturally-occurring data emerging from Snapshot,
Polygonscan, and Etherscan. The data can be retrieved at this
[link](https://cityuni-my.sharepoint.com/:u:/r/personal/matteo_devigili_2_city_ac_uk/Documents/dao-data-smm695.zip?csf=1&web=1&e=eenaIU).
In particular, you can find:

| PATH                                            | content   | source      | content             | size  | #    |
| ----------------------------------------------- | --------- | ----------- | ------------------- | ----- | ---- |
| snap-data-collection/.data/snap_dao_info.pickle | Spaces    | Snapshot    | DAO-level info      | 30kB  | 15   |
| snap-data-collection/.data/proposals/*.pickle   | Proposals | Snapshot    | Proposal-level info | 14MB  | 6K   |
| snap-data-collection/.data/votes/*.pickle       | Votes     | Snapshot    | Vote-level info     | 1.91G | 5.1M |
| snap-data-collection/.data/follow/*.pickle      | Follows   | Snapshot    | Follow-level info   | 126MB | 444K |
| polygonscan-data-collection/.data/*.pickle      | Scan      | Polygonscan | Wallet-level info   | 2.7G  | 218K |
| etherscan-data-collection/.data/*.pickle        | Scan      | Etherscan   | Wallet-level info   | 1.2G  | 118K |

Data are stored in `pickle` format. Please, check
[load_data.py](https://github.com/mattDevigili/dms-smm695/blob/master/final-course-project/load_data.py)
for an example of loading pickle files.

To get a sense of the data structure, I suggest you explore the available data
either in MongoDB or Python. Also, check the APIs of
[Snapshot](https://docs.snapshot.org/tools/api),
[Polygonscan](https://docs.polygonscan.com), and
[Etherscan](https://docs.etherscan.io) to get further info.

## Deliverables

By July 19th (4:00 PM, London time), groups have to upload:

- SQL, JS, or Python scripts;
- Supporting documentation (accepted format: .md, .docx, or .pdf) containing:
  - a detailed justification of your design choices;
  - a clear and concise description of the insights coming from descriptive
      statistics obtained;
  - _[optional]_ a clear and concise description of further insights and results obtained
      analyzing data through PySpark.

Please keep the supporting document within 3,000 words excluding tables and
figures.

## References

Here you can find some practitioner-oriented pieces on DAOs:

- [Jonathan Ruane and Andrew McAfee (2022). What a DAO Can — and Can’t — Do, Harvard Business Review.](https://hbr.org/2022/05/what-a-dao-can-and-cant-do)
- [Steve Glaveski (2022). How DAOs Could Change the Way We Work, Harvard Business Review.](https://hbr.org/2022/04/how-daos-could-change-the-way-we-work)

Here you can find some academic articles dealing with similar online software
communities:

- [Amrit, C., & Van Hillegersberg, J. (2010). Exploring the impact of soclo-technlcal core-periphery structures in open source software development. Journal of Information Technology, 25(2), 216-229.](https://journals.sagepub.com/doi/pdf/10.1057/jit.2010.7)
- [Baldwin, C. Y., & Clark, K. B. (2006). The architecture of participation: Does code architecture mitigate free riding in the open source development model?. Management Science, 52(7), 1116-1127.](https://pubsonline.informs.org/doi/pdf/10.1287/mnsc.1060.0546)
- [Banks, G. C., Dionne, S. D., Mast, M. S., & Sayama, H. (2022). Leadership in the digital era: A review of who, what, when, where, and why. The Leadership Quarterly, 33(5), 101634.](https://www.sciencedirect.com/science/article/pii/S1048984322000376)
- [Dahlander, L., & Wallin, M. W. (2006). A man on the inside: Unlocking communities as complementary assets. Research Policy, 35(8), 1243-1259.](https://www.sciencedirect.com/user/identity/landing?code=hreFr5zfHodonoFE0XSn1DUKWwk0UY4Gnyovz3NA&state=retryCounter%3D0%26csrfToken%3D6a2d8891-7717-417b-a042-43e057b847bc%26idpPolicy%3Durn%253Acom%253Aelsevier%253Aidp%253Apolicy%253Aproduct%253Ainst_assoc%26returnUrl%3D%252Fscience%252Farticle%252Fpii%252FS0048733306001387%26prompt%3Dnone%26cid%3Darp-04ef023c-0573-49cd-aab3-ec3bd486fbb5)
- [Gulati, R., Puranam, P., & Tushman, M. (2012). Meta‐organization design: Rethinking design in interorganizational and community contexts. Strategic Management Journal, 33(6), 571-586.](https://onlinelibrary.wiley.com/doi/pdf/10.1002/smj.1975?casa_token=GZEbOaeQ5okAAAAA:1Gi86pTax0ouNlXkyC4nVruDsbu4u2wKRUBgWgqVGmAF3-zRtbfLNkwPdPXrRGW_5kWNJpS_eruQhAA)
- [He, V. F., Puranam, P., Shrestha, Y. R., & von Krogh, G. (2020). Resolving governance disputes in communities: A study of software license decisions. Strategic Management Journal, 41(10), 1837-1868.](https://onlinelibrary.wiley.com/doi/pdf/10.1002/smj.3181)
- [Hsieh, Y. Y., & Vergne, J. P. (2023). The future of the web? The coordination and early‐stage growth of decentralized platforms. Strategic Management Journal, 44(3), 829-857.](https://onlinelibrary.wiley.com/doi/pdf/10.1002/smj.3455)
- [O'Mahony, S., & Ferraro, F. (2007). The emergence of governance in an open source community. Academy of Management Journal, 50(5), 1079-1106.](https://www.jstor.org/stable/pdf/20159914.pdf)
- [O'Mahony, S., & Bechky, B. A. (2008). Boundary organizations: Enabling collaboration among unexpected allies. Administrative Science Quarterly, 53(3), 422-459.](https://journals.sagepub.com/doi/pdf/10.2189/asqu.53.3.422)
- [Von Krogh, G., Haefliger, S., Spaeth, S., & Wallin, M. W. (2012). Carrots and rainbows: Motivation and social practice in open source software development. MIS Quarterly, 649-676.](https://www.jstor.org/stable/pdf/41703471.pdf)