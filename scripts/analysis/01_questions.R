
library(tidyverse)
#library(readxl)
library(janitor)
library(geofacet)
library(forcats)
library(scales)

# Questions ----

# How many per year?
# What's the percent breakdown?
# What states have seen an increase?
# Target summary
# Group summary
# Weapons?

# Import data ----

# this is based on older proprietary data which can be requested from CSIS
#df2 <- read_excel("data/raw_data/CSIS_TNT_Terrorism_US_Jan1994-Aug2020.xlsx")

# this section has be reworked to be compatible with shared public data

df2 <- read_csv("data/clean_data/csis_wapo_domestic_terrorism.csv")

df2 <- clean_names(df2)

df2 <- df2 %>% 
  rename(tnt_orientation=orientation_csis,
         year=year_csis,
         state=state_csis,
         month=month_csis,
         vict_killed=vict_killed_csis,
         weapon=weapon_csis,
         target=target_csis)

group <- count(df2, tnt_orientation)

group

# overall breakdown

df_summary <- df2 %>% 
  count(year, tnt_orientation) %>% 
  group_by(year) %>% 
  mutate(percent=round(n/sum(n, na.rm=T)*100))

# How many per year?
df_summary %>% 
  filter(tnt_orientation!="Other") %>% 
  ggplot(aes(x=year, y=n)) +
  geom_bar(stat="identity") +
  facet_wrap(~tnt_orientation, ncol=4)

# What's the percent breakdown?
ggplot(df_summary, aes(x=year, y=percent, fill=tnt_orientation)) +
  geom_bar(position="stack", stat="identity")

dfs_summary <- df2 %>% 
  count(state, year, tnt_orientation) %>% 
  group_by(year, state) %>% 
  mutate(percent=round(n/sum(n, na.rm=T)*100))

# What states have seen an increase?
dfs_summary %>% 
  filter(tnt_orientation=="Violent Far-right") %>% 
  ggplot() +
  geom_col(aes(x=year, y=n)) +
  theme_bw() +
  facet_geo(~ state)

# Target summary
targets <- df2 %>% count(tnt_orientation, target) %>% 
  filter(tnt_orientation=="Violent Far-right" | tnt_orientation=="Violent Far-left") %>% 
  pivot_wider(names_from="target", values_from="n") %>% 
  pivot_longer(cols=2:13, names_to="target", values_to="attacks") %>% 
  rename(Group=tnt_orientation)


ggplot(targets) +
  geom_col(aes(x=attacks, y=fct_reorder(target, attacks, na.rm=T), 
               fill=Group, group=Group),position="dodge") +
  scale_fill_manual(values = c("lightslategray", "burlywood")) +
  #scale_color_manual(values = rev(cols))+
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()

# Target summary by year
targets_year <- df2 %>% count(tnt_orientation, year, target) %>% 
  filter(tnt_orientation=="Violent Far-right" | tnt_orientation=="Violent Far-left") %>% 
  pivot_wider(names_from="target", values_from="n") %>% 
  pivot_longer(cols=3:14, names_to="target", values_to="attacks") %>% 
  rename(Group=tnt_orientation)

ggplot(targets_year) +
  geom_col(aes(x=year, y=attacks, 
               fill=Group, group=Group),position="dodge") +
  facet_wrap(~target) +
  scale_fill_manual(values = c("lightslategray", "burlywood")) +
  #scale_color_manual(values = rev(cols))+
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()

# Group summary timeline

# sub groups from CSIS is not available in this data set
# that's a column in their raw data which can be requested from them
groups <- df2 %>% 
  filter(tnt_orientation=="Violent Far-right") %>% 
  count(year, group) 

ggplot(groups) +
  geom_col(aes(x=year, y=n)) +
  facet_wrap(~group) +
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()

# Weapons?

weapons <- df2 %>% 
  filter(tnt_orientation=="Violent Far-right") %>% 
  count(year, weapon) 

ggplot(weapons) +
  geom_col(aes(x=year, y=n)) +
  facet_wrap(~weapon) +
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()

#### DEATHS ----



## Percent of incidents with deaths
deaths_or <- df2 %>% 
  mutate(deaths=case_when(
    vict_killed > 0 ~ T,
    TRUE ~ F
  )) %>% 
  count(year, tnt_orientation, deaths) %>% 
  group_by(year, tnt_orientation) %>% 
  mutate(percent=round(n/sum(n, na.rm=T)*100))

ggplot(deaths_or, aes(x=year, y=percent, fill=deaths)) +
  geom_bar(position="stack", stat="identity") +
  facet_wrap(~tnt_orientation) + theme_minimal()

## group deaths percent by year
deaths_percent <- df2 %>% 
  group_by(year, tnt_orientation) %>% 
  summarize(deaths=sum(vict_killed, na.rm=T)) %>% 
  group_by(year) %>% 
  mutate(percent=round(deaths/sum(deaths, na.rm=T)*100))

ggplot(deaths_percent, aes(x=year, y=percent, fill=tnt_orientation)) +
  geom_bar(position="stack", stat="identity") +
  theme_minimal()


## group deaths  by year
ggplot(deaths_percent, aes(x=year, y=deaths)) +
  geom_bar(stat="identity") +
  facet_wrap(~tnt_orientation, scales="free_y")
  theme_minimal()

# How many per year?
df_summary %>% 
  filter(tnt_orientation!="Other") %>% 
  ggplot(aes(x=year, y=n)) +
  geom_bar(stat="identity") +
  facet_wrap(~tnt_orientation, ncol=4)

# What's the percent breakdown?
ggplot(df_summary, aes(x=year, y=percent, fill=tnt_orientation)) +
  geom_bar(position="stack", stat="identity")

dfs_summary <- df2 %>% 
  count(state, year, tnt_orientation) %>% 
  group_by(year, state) %>% 
  mutate(percent=round(n/sum(n, na.rm=T)*100))

# What states have seen an increase?
dfs_summary %>% 
  filter(tnt_orientation=="Violent Far-right") %>% 
  ggplot() +
  geom_col(aes(x=year, y=n)) +
  theme_bw() +
  facet_geo(~ state)

# Target summary
targets <- df2 %>% count(tnt_orientation, target) %>% 
  filter(tnt_orientation=="Violent Far-right" | tnt_orientation=="Violent Far-left") %>% 
  pivot_wider(names_from="target", values_from="n") %>% 
  pivot_longer(cols=2:13, names_to="target", values_to="attacks") %>% 
  rename(Group=tnt_orientation)


ggplot(targets) +
  geom_col(aes(x=attacks, y=fct_reorder(target, attacks, na.rm=T), 
               fill=Group, group=Group),position="dodge") +
  scale_fill_manual(values = c("lightslategray", "burlywood")) +
  #scale_color_manual(values = rev(cols))+
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()

# Target summary by year
targets_year <- df2 %>% count(tnt_orientation, year, target) %>% 
  filter(tnt_orientation=="Violent Far-right" | tnt_orientation=="Violent Far-left") %>% 
  pivot_wider(names_from="target", values_from="n") %>% 
  pivot_longer(cols=3:14, names_to="target", values_to="attacks") %>% 
  rename(Group=tnt_orientation)

ggplot(targets_year) +
  geom_col(aes(x=year, y=attacks, 
               fill=Group, group=Group),position="dodge") +
  facet_wrap(~target) +
  scale_fill_manual(values = c("lightslategray", "burlywood")) +
  #scale_color_manual(values = rev(cols))+
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()

# Group summary timeline

groups <- df2 %>% 
  filter(tnt_orientation=="Violent Far-right") %>% 
  count(year, group) 

ggplot(groups) +
  geom_col(aes(x=year, y=n)) +
  facet_wrap(~group) +
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()

# Weapons?

weapons <- df2 %>% 
  filter(tnt_orientation=="Violent Far-right") %>% 
  count(year, weapon) 

ggplot(weapons) +
  geom_col(aes(x=year, y=n)) +
  facet_wrap(~weapon) +
  labs(y="Target", x="Incidents", title="Attacks since 1994") +
  theme_minimal()


