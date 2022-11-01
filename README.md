# UN-Voting-Coincidence

Voting coincidence provides the "comparison of the overall voting practices in the principle bodies of the United Nations". Because the United Nations acts on so many diverse issues, the voting record of a UN member state during the General Assembly (193 members) and Security Council (5 permanent and 10 rotating members) provides insight into a country’s orientation in world arenas: where it stands, with whom it stands (at least in a UN context), and for what purpose. Voting coincidence data in this visualization refers only to the UN context and does not take into account support for U.S. policy positions in other multilateral fora or bilateral contexts.

The scores are calculated using the following methodology:

- Coincidence = (Full Coincidence + (Semi-Coincidence * 0.5)) / Joint Votes
- Full Coincidence = Count of Yes|Yes and No|No
- Half Coincidence = Count of Yes|Abstain, No|Abstain, Abstain|Yes, and Abstain|No
- Joint Votes = Total number of votes on resolutions where both countries voted yes, no, or abstain.  It excludes non-votes.

## Data

The data was pulled from the United Nations General Assembly Voting Data in [Harvard Dataverse](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/LEJUQZ).  According to the source,  
> This is a dataset of roll-call votes in the UN General Assembly 1946-2021 (sessions 1-76), note that some votes in the 76th session take place in 2022. Note that for the four most recent years, failed votes and votes on amendments and paragraphs have not yet been added. Moreover, "important votes" are also not yet coded for these years. The dataset includes issue codes and descriptions. It also contains ideal point estimates derived from these votes as described in Bailey, Michael A., Anton Strezhnev, and Erik Voeten. "Estimating dynamic state preferences from United Nations voting data." Journal of Conflict Resolution 61.2 (2017): 430-456. Code to estimate ideal points and issue ideal points are available at: https://github.com/evoeten/United-Nations-General-Assembly-Votes-and-Ideal-Points (2020-04-19)

Our visualization utilizes data contained in the AgreementScoresAll_June2022.csv file.

## Data Citation
Erik Voeten "Data and Analyses of Voting in the UN General Assembly" Routledge Handbook of International Organization, edited by Bob Reinalda (published May 27, 2013). Available at SSRN: http://ssrn.com/abstract=2111149 When using the ideal point data, please cite: Bailey, Michael A., Anton Strezhnev, and Erik Voeten. 2017. Estimating dynamic state preferences from united nations voting data. Journal of Conflict Resolution 61 (2): 430-56.
