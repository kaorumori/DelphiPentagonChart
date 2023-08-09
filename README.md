# DelphiPentagonChart

## Usage

Set parameters in url.

`/chart?data=2021,2025,2030-2022,2026,2028&exdata=2023,2026,2029-2024,2026,2028&colors=ffffff-ff7f50&bgcolor=ffffff&&start=2020&end=2030&scale=5&size=600x320`

### Parameters

| Name    | Description                    | Sample                        |
| ------- | ------------------------------ | ----------------------------- |
| data    | Data for Pentagon Chart        | 2021,2025,2030-2022,2026,2028 |
| exdata  | Data for Circle Chart          | 2023,2026,2029-2024,2026,2028 |
| colors  | Colors for Pentagon and Circle | ffffff-ff7f50                 |
| bgcolor | Background Color               | ffffff                        |
| start   | Start Year for Chart           | 2020                          |
| end     | End Year for Chart             | 2030                          |
| scale   | Space for Scale (Dash Lines)   | 5                             |
| size    | Image Size                     | 600x320                       |

## Testing Locally

```sh
ruby app.rb
```

## Deploy to Fly.io

```sh
fly deploy
```
