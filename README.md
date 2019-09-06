# DelphiPentagonChart

![Sample](https://delphi-pentagon.defrag.works/chart?start=2020&end=2030&size=600x320&bgcolor=ffffff&colors=ffffff-ff7f50&data=2021,2025,2030-2022,2026,2028&exdata=2023,2026,2029-2024,2026,2028&scale=5)

## Usage

Set parameters in url.

```
https://delphi-pentagon.defrag.works/chart?start=2020&end=2030&size=600x320&bgcolor=ffffff&colors=ffffff-ff7f50&data=2021,2025,2030-2022,2026,2028&exdata=2023,2026,2029-2024,2026,2028&scale=5
```

### Parameters

| Name   | Desctiption                    | Sample                        |
| --     | --                             | --                            |
| data   | Data for Pentagon Chart        | 2021,2025,2030-2022,2026,2028 |
| exdata | Data for Circle Chart          | 2023,2026,2029-2024,2026,2028 |
| colors | Colors for Pentagon and Circle | ffffff-ff7f50                 |
| start  | Start Year for Chart           | 2020                          |
| end    | End Year for Chart             | 2030                          |
| scale  | Space for Scale (Dash Lines)   | 5                             |
| size   | Image Size                     | 600x480                       |

## Testing Locally

```
$ bundle
$ ruby app.rb
```

## Deploy to Cloud Run

```
$ gcloud builds submit --tag gcr.io/<ProjectID>/<Name>
```

```
$ gcloud beta run deploy --image gcr.io/<ProjectID>/<Name> --platform managed
```

