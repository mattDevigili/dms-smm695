# Webinar 3 --- Structure

Webinar recording:

![webinar-3](img/webinar3.png)

Here you can find the structure for the third webinar.

| **Week (date)** | **Agenda**                                                                                |
| --------------- | ----------------------------------------------------------------------------------------- |
| 3 (09-06)       | Recap -- week 3                                                                           |
|                 | Introduction to Design Theory (part two)                                                  |
|                 | _Q&A_                                                                                     |
|                 | [Artworks - Tate](https://github.com/tategallery/collection/blob/master/artwork_data.csv) |
|                 | --- FDs and Anomalies                                                                     |
|                 | --- Decomposition                                                                         |
|                 | --- Indexes and Views                                                                     |
|                 | [Psycopg2](https://www.psycopg.org/docs/)                                                 |
|                 | - Basic usage                                                                             |
|                 | - Homework solutions                                                                      |

**Please review the pre-recorded material before attending this webinar.**

## Material

Webinar materials:

* [whm_3.sql](https://github.com/mattDevigili/dms-smm695/blob/master/week-3/webinar-3/whm_3.sql): solutions for the [hw_3.md](https://mattdevigili.github.io/dms-smm695/week-3/hw_3.html);
* [ws_3.pdf](https://github.com/mattDevigili/dms-smm695/blob/master/week-3/webinar-3/ws_3.pdf): introduction to design theory slide;
* [wsc_3.sql](https://github.com/mattDevigili/dms-smm695/blob/master/week-3/webinar-3/wsc_3.sql): webinar 3 sql script.

## Tate Data

<p align="center">
<img src="https://www.tate.org.uk/sites/default/files/styles/width-600/public/tanks_staircase_tate_modern_3_1.jpg" width="400">
</p>

[Tate Gallery](https://www.tate.org.uk) shared data on [artists](https://github.com/tategallery/collection/tree/master/artists) and [artworks](https://github.com/tategallery/collection/tree/master/artworks) up to Oct 2014. For this webinar, we are going to work with [artwork_data.csv](https://github.com/tategallery/collection/blob/master/artwork_data.csv).

You can obtain data via `wget`, type on your terminal:

```bash
wget "https://raw.githubusercontent.com/tategallery/collection/master/artwork_data.csv"
```

_n.b._: wget needs to be installed on your laptop.
