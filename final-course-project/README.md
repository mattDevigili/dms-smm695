# Final course project

<p align="middle">
  <img src="img/GitHub-Mark-120px-plus.png" width="100" />
</p>

For the final course project (fcp), you will handle a real-world dataset. In
particular, you are required to store, manipulate, and analyze GitHub data for
[PyTorch](https://github.com/pytorch/pytorch) and
[Tensorflow](https://github.com/tensorflow/tensorflow).  Both projects are
examples of [open source
software](https://en.wikipedia.org/wiki/Open-source_software) (OSS) development.

<p align="middle">
  <img src="https://upload.wikimedia.org/wikipedia/commons/9/96/Pytorch_logo.png" width="250" />
  <img src="https://www.gstatic.com/devrel-devsite/prod/v1a2d2d725c48303ffd65eb7122e57032dbf9bb148227658cacdfddf0dcae1e46/tensorflow/images/lockup.svg" width="250" /> 
</p>

OSS challenges common managerial assumptions on the organizing and functioning
of organizations (Gulati et al., 2012), attracting the interest of research
enthusiasts from several disciplines (e.g., information systems, management, and
sociology). But the OSS phenomenon is also extremely relevant from a business
perspective. For example, you may think of the Python project or the father of
all – Linux (powering NASA projects, Chrome OS, Android hardware, and the
largest share of worldwide servers). The OSS experience keeps offering fresh
business and research insights and may guide us in the next phase of the
organizing technologies based on remote work.

## Tasks

You are required to choose your preferred DBMS -- PostgreSQL or MongoDB -- and:

1. Clean, manipulate, and structure data. The expected result is a well-designed 
   dataset that complies with the specific approach of the chosen DBMS. 
2. Provide valuable descriptive insights. The expected result is a set of 
   descriptive statistics that depicts some interesting trends or noteworthy 
   data characteristics.
3. _[optional]_ Perform an insightful data analysis. For example, you can 
   analyse the modularity of the source code or the features of issues getting 
   the community's attention. You may want to skim through the reference list 
   provided to get some inspiration.

To perform tasks 1 and 2, you need to use either `SQL` or `MQL` (MongoDB query language). 
Alternatively, if you prefer using python, you can leverage `psycopg2` or `pymongo`.
For what concerns task 3, you should use `PySpark` (e.g., you may want to leverage on the
[MLlib](https://spark.apache.org/docs/latest/api/python/reference/pyspark.ml.html) pyspark library).

## Data

The `fcp` is based on **commit** and **issue** data for PyTorch<a href="#note1" id="note1ref"><sup>1</sup></a> and Tensorflow
projects hosted at GitHub. 

- [Commits](https://github.com/git-guides/git-commit) tell the history of a repository and how it came to be the way that it currently is
- [Issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/about-issues) help to track ideas, feedback, tasks, or bugs for work on GitHub

The data can be retrieved at this
[link](https://cityuni-my.sharepoint.com/:f:/g/personal/matteo_devigili_2_city_ac_uk/Eq8fCRrNLmJOopub6vfOy5QBasKtb2RqOnfGOkkt35HW7A?e=U35aEG).
In particular, you can find:

| data | content | time frame | size |
| --- | --- | --- | --- |
| gitData | commit history | 2021-07-01 - 2021-12-31 | 7.84 GB |
| gitIssues | issues history | 2021-01-01 - 2021-12-31 | 150 MB |

Data are stored in both `csv` and `json` formats. 

If you are interested in expanding the data collected, you can consider the 
following libraries:

- Commits: [pyDriller](https://pydriller.readthedocs.io/en/latest/)
- Issues: [pyGithub](https://pygithub.readthedocs.io/en/latest/)

### gitData

Here is a list of fields and a brief synopsis: 

- hash: hash of the commit
- msg: commit message
- author_name (Developer): commit author name
- committer_name (Developer): commit committer name
- author_date: authored date
- author_timezone: author timezone (expressed in seconds from epoch)
- committer_date: commit date
- committer_timezone: commit timezone (expressed in seconds from epoch)
- branches: List of branches that contain this commit
- in_main_branch: True if the commit is in the main branch
- merge: True if the commit is a merge commit
- parents: list of the commit parents
- project_name: project name
- deletions: number of deleted lines in the commit (as shown from –shortstat).
- insertions: number of added lines in the commit (as shown from –shortstat).
- lines: total number of added + deleted lines in the commit (as shown from –shortstat).
- files: number of files changed in the commit (as shown from –shortstat).
- old_path: old path of the file (can be _None_ if the file is added)
- new_path: new path of the file (can be _None_ if the file is deleted)
- filename: return only the filename (e.g., given a path-like-string such as “/Users/dspadini/pydriller/myfile.py” returns “myfile.py”)
- change_type: type of the change: can be Added, Deleted, Modified, or Renamed.
- diff: diff of the file as Git presents it (e.g., starting with @@ xx,xx @@).
- diff_parsed: diff parsed in a dictionary containing the added and deleted lines. The dictionary has 2 keys: “added” and “deleted”, each containing a list of Tuple (int, str) corresponding to (number of line in the file, actual line).
- added_lines: number of lines added
- deleted_lines: number of lines removed
- source_code: source code of the file (can be _None_ if the file is deleted or only renamed)
- source_code_before: source code of the file before the change (can be _None_ if the file is added or only renamed)
- nloc: Lines Of Code (LOC) of the file
- complexity: Cyclomatic Complexity of the file
- token_count: Number of Tokens of the file


### gitIssues

Here is a list of fields and a brief synopsis: 

- title: issue title
- state: state of the issue, either open or closed (all issues collected are closed)
- body: contents of the issue
- user: user name
- user_id: unique identifier for the user
- created_at: when the issue has been created
- updated_at: when the issue has been updated
- closed_at: when the issue has been closed
- assignees: users that this issue is assigned to
- labels: labels associated with this issue
- reactions: can be one of +1, -1, laugh, confused, heart, hooray, rocket, eyes
- n_comments: number of comments for the issue
- closed_by: user that closed the issue
- comment_id: unique identifier for the comment
- comment_created_at: when the comment has been created
- comment_updated_at: when the comment has been updated
- comment_user_id: user commenting -- id
- comment_user: user commenting -- name
- comment_text: contents of the comment
- project: project name

## Deliverables

By July 22nd (4:00 PM, London time), groups have to upload:

* SQL, JS, or Python scripts;
* Supporting documentation (accepted format: .md, .docx, or .pdf) containing:
  * a detailed justification of your design choices;
  * a clear and concise description of the insights coming from descriptive
      statistics obtained;
  * _[optional]_ a clear and concise description of further insights and results obtained 
      analyzing data through PySpark. 

## References

Here you can find some academic articles dealing with open source software:

- [Amrit, C., & Van Hillegersberg, J. (2010). Exploring the impact of soclo-technlcal core-periphery structures in open source software development. journal of information technology, 25(2), 216-229.](https://journals.sagepub.com/doi/pdf/10.1057/jit.2010.7)
- [Baldwin, C. Y., & Clark, K. B. (2006). The architecture of participation: Does code architecture mitigate free riding in the open source development model?. Management science, 52(7), 1116-1127.](https://pubsonline.informs.org/doi/pdf/10.1287/mnsc.1060.0546)
- [Dahlander, L., & Wallin, M. W. (2006). A man on the inside: Unlocking communities as complementary assets. Research policy, 35(8), 1243-1259.](https://www.sciencedirect.com/user/identity/landing?code=hreFr5zfHodonoFE0XSn1DUKWwk0UY4Gnyovz3NA&state=retryCounter%3D0%26csrfToken%3D6a2d8891-7717-417b-a042-43e057b847bc%26idpPolicy%3Durn%253Acom%253Aelsevier%253Aidp%253Apolicy%253Aproduct%253Ainst_assoc%26returnUrl%3D%252Fscience%252Farticle%252Fpii%252FS0048733306001387%26prompt%3Dnone%26cid%3Darp-04ef023c-0573-49cd-aab3-ec3bd486fbb5)
- [Gulati, R., Puranam, P., & Tushman, M. (2012). Meta‐organization design: Rethinking design in interorganizational and community contexts. Strategic management journal, 33(6), 571-586.](https://onlinelibrary.wiley.com/doi/pdf/10.1002/smj.1975?casa_token=GZEbOaeQ5okAAAAA:1Gi86pTax0ouNlXkyC4nVruDsbu4u2wKRUBgWgqVGmAF3-zRtbfLNkwPdPXrRGW_5kWNJpS_eruQhAA)
- [He, V. F., Puranam, P., Shrestha, Y. R., & von Krogh, G. (2020). Resolving governance disputes in communities: A study of software license decisions. Strategic Management Journal, 41(10), 1837-1868.](https://onlinelibrary.wiley.com/doi/pdf/10.1002/smj.3181)
- [O'Mahony, S., & Ferraro, F. (2007). The emergence of governance in an open source community. Academy of Management Journal, 50(5), 1079-1106.](https://www.jstor.org/stable/pdf/20159914.pdf)
- [O'Mahony, S., & Bechky, B. A. (2008). Boundary organizations: Enabling collaboration among unexpected allies. Administrative science quarterly, 53(3), 422-459.](https://journals.sagepub.com/doi/pdf/10.2189/asqu.53.3.422)
- [Von Krogh, G., Haefliger, S., Spaeth, S., & Wallin, M. W. (2012). Carrots and rainbows: Motivation and social practice in open source software development. MIS quarterly, 649-676.](https://www.jstor.org/stable/pdf/41703471.pdf)

Here you can find some further readings:

- [The cathedral and the bazaar](https://firstmonday.org/ojs/index.php/fm/article/download/1472/1387?inline=1)
- [The WIRED Guide to Open Source Software](https://www.wired.com/story/wired-guide-open-source-software/)
- [Google Just Open Sourced TensorFlow, Its Artificial Intelligence Engince](https://www.wired.com/2015/11/google-open-sources-its-artificial-intelligence-engine/)
- [Web Semantics: AI-speak](https://www.wired.com/beyond-the-beyond/2020/01/web-semantics-ai-speak/)

An amazing documentary on the early stages of open source:

[![](img/revOS.png)](https://www.youtube.com/watch?v=GsHh2wfy_-4)

------------------------------------------------------------------------------------------------------------------------
    
### Notes

<a id="note1" href="#note1ref">1</a>: For what concerns PyTorch, the commits 
data further contain information on the child repositories:

- audio
- vision
- xla
- serve
- torchrec
- text