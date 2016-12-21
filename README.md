# micropurchase-data

Using this image:

```
$ docker run --rm 18fgsa/micropurchase-data
```

To save the results to a file:

```
$ docker run --rm 18fgsa/micropurchase-data > skills.json
```

## Building locally

Clone this repo and `cd` into it:

```
$ docker build -t micropurchase-data .
```

## Example output

The script outputs a JSON object keys by skill name. Each skill name is the key for an object which contains an array of bidder objects. Each bidder object contains basic information about the bidder along with an array winning bids by that bidder that match the parent skill name. Example:

```json
{
  "CSS": [
    {
      "created_at": "2016-03-17T21:49:09+00:00",
      "duns_number": "012345678",
      "github_id": "1",
      "github_login": "a_githubber",
      "id": 10,
      "name": "A. GitHubber",
      "sam_status": "sam_accepted",
      "updated_at": "2016-10-19T02:21:24+00:00",
      "winning_bids": [
        {
          "amount": 400,
          "bidder_id": 10,
          "auction_url": "a_url",
          "skills": [
            "HTML",
            "JavaScript",
            "Python",
            "CSS"
          ]
        }
      ]
    }
```
