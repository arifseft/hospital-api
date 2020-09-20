## Prequisities

- Ruby 2.7.1
- Rails 6.0.3

## Getting started

```bash
rails db:create db:migrate db:seed
```

## How to test suite

```bash
rspec
```

## Endpoint

### Register

You can register as a user with this endpoint: `http://localhost:3000/api/v1/register`.

Available params:
| params | type |required/optional|
|---------|------|-----------------|
|full_name|string|required |
|email |string|required |
|password |string|required |
|gender |string|optional |
|birthday |string|optional |
|is_doctor|string|optional |

Example request:

```bash
curl --request POST \
  --url http://localhost:3000/api/v1/register \
  --form 'full_name=M. Arif Sefrianto' \
  --form email=arifsefrianto@gmail.com \
  --form password=12345678 \
  --form gender=male \
  --form birthday=1992-09-06 \
  --form is_doctor=false
```

Example response:

```json
{
  "user": {
    "id": 6,
    "email": "arifsefrianto@gmail.com",
    "birthday": "1992-09-06",
    "age": 28,
    "gender": "male",
    "is_doctor": false,
    "full_name": "M. Arif Sefrianto",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6bnVsbCwiZXhwIjoxNjAzMTgzMjYwfQ.CKM-9xcIUkE88eRk9OSwdKulvwjlW3u2oPLrlY2Ds4Y"
  }
}
```

### Login

Endpoint: `http://localhost:3000/api/v1/login`.

Params:
|params |type |required/optional|
|---------|------|-----------------|
|email |string|required |
|password |string|required |

Example request:

```bash
curl --request POST \
  --url http://localhost:3000/api/v1/login \
  --form 'email=arifsefrianto@gmail.com' \
  --form password=12345678
```

Example response:

```json
{
  "user": {
    "id": 6,
    "email": "arifsefrianto@gmail.com",
    "birthday": "1992-09-06",
    "age": 28,
    "gender": "male",
    "is_doctor": false,
    "full_name": "M. Arif Sefrianto",
    "token": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6bnVsbCwiZXhwIjoxNjAzMTgzNDk2fQ.B9E8na62H9o9ZgAfAKmuXOTxlMfuWIxP0h75L-6e70s"
  }
}
```

Register and Login endpoint have same response. And you will see `token` there. Some endpoint is restricted, you can access it if you login first. You will need this `token` to access restricted endpoint.

### Logout

Endpoint: `http://localhost:3000/api/v1/logout`
You don't need params, but you need to put `token` at the headers.
|headers |type |
|-----------------|------|
|User-Access-Token|string|

Example request:

```bash
curl --request POST \
  --url http://localhost:3000/api/v1/logout \
  --header 'user-access-token: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6bnVsbCwiZXhwIjoxNjAzMTgzNDk2fQ.B9E8na62H9o9ZgAfAKmuXOTxlMfuWIxP0h75L-6e70s'
```

Example response:

```json
{
  "message": "You have successfully logged out."
}
```

### Get Hospital List

Endpoint: `http://localhost:3000/api/v1/hospitals`
You don't need params and headers (token), because all user can access this page (even you're not log in).
Example request:

```bash
curl --request GET \
  --url http://localhost:3000/api/v1/hospitals
```

Example response:

```json
{
  "hospitals": [
    {
      "id": 1,
      "name": "Youth Beauty Clinic",
      "district": "Mampang Prapatan, Jakarta Selatan",
      "open_hours": "Senin - Sabtu 10:00 - 17:00",
      "support_emergency": false,
      "hospital_type": "Klinik Kulit & Kecantikan"
    },
    {
      "id": 2,
      "name": "RS Yadika Kebayoran Lama",
      "district": "Kebayoran Lama, Jakarta Selatan",
      "open_hours": "Senin - Minggu 00:00 - 23:59",
      "support_emergency": true,
      "hospital_type": "Rumah Sakit"
    }
  ]
}
```

### Get Doctor List

Endpoint: `http://localhost:3000/api/v1/doctors`
You don't need params and headers (token), because all user can access this page (even you're not log in).
Example request:

```bash
curl --request GET \
  --url http://localhost:3000/api/v1/doctors
```

Example response:

```json
{
  "doctors": [
    {
      "id": 2,
      "name": "drg. Andrian Nova Fitri, Sp.PM",
      "speciality": "Dokter Gigi",
      "district": "Kebayoran Baru, Jakarta Selatan",
      "hospitals": [
        {
          "id": 8,
          "name": "RS Pusat Pertamina",
          "district": "Kebayoran Baru, Jakarta Selatan",
          "open_hours": "Senin - Minggu 00:00 - 23:59",
          "support_emergency": true,
          "hospital_type": "Rumah Sakit"
        }
      ]
    },
    {
      "id": 3,
      "name": "dr. Tri Wahyu Setyaningsih, Sp.M",
      "speciality": "Dokter Spesialis Mata",
      "district": "Tebet, Jakarta Selatan",
      "hospitals": [
        {
          "id": 4,
          "name": "RS Tebet",
          "district": "Tebet, Jakarta Selatan",
          "open_hours": "Senin - Minggu 00:00 - 23:59",
          "support_emergency": true,
          "hospital_type": "Rumah Sakit"
        }
      ]
    }
  ]
}
```

### Get Doctor Schedules

Endpoint: `http://localhost:3000/api/v1/doctors/{doctor_id}/schedules`
You don't need params and headers (token), because all user can access this page (even you're not log in). You need `doctor_id`. This endpoint is showing a doctor's schedules.
Example request:

```bash
curl --request GET \
  --url http://localhost:3000/api/v1/doctors/2/schedules
```

Example response:

```json
{
  "id": 2,
  "name": "drg. Andrian Nova Fitri, Sp.PM",
  "speciality": "Dokter Gigi",
  "district": "Kebayoran Baru, Jakarta Selatan",
  "hospitals": [
    {
      "id": 8,
      "name": "RS Pusat Pertamina",
      "district": "Kebayoran Baru, Jakarta Selatan",
      "open_hours": "Senin - Minggu 00:00 - 23:59",
      "support_emergency": true,
      "hospital_type": "Rumah Sakit",
      "schedules": [
        {
          "id": 1,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "09:00 - 09:20",
          "booked": true
        },
        {
          "id": 2,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "09:30 - 09:50",
          "booked": false
        },
        {
          "id": 3,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "10:00 - 10:20",
          "booked": false
        },
        {
          "id": 4,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "10:30 - 10:50",
          "booked": false
        },
        {
          "id": 5,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "11:00 - 11:20",
          "booked": false
        },
        {
          "id": 6,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "11:30 - 11:50",
          "booked": false
        },
        {
          "id": 7,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "13:00 - 13:20",
          "booked": false
        },
        {
          "id": 8,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "13:30 - 13:50",
          "booked": false
        },
        {
          "id": 9,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "14:00 - 14:20",
          "booked": false
        },
        {
          "id": 10,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "14:30 - 14:50",
          "booked": false
        },
        {
          "id": 11,
          "session_date": "Sunday, 23 August 2020",
          "session_hour": "15:00 - 15:20",
          "booked": false
        }
      ]
    }
  ]
}
```

### Create an Order

Endpoint: `http://localhost:3000/api/v1/orders`
You must login if you want to make an order.
Header:
|headers |type |
|-----------------|------|
|User-Access-Token|string|

Params:
|params |type |required/optional|
|------------|--------|-----------------|
|user_id |integer |required |
|doctor_id |integer |required |
|schedule_id |integer |required |
|payment_type|string |optional |
|notes |string |optional |

You can get `doctor_id` and `schedule_id` from `http://localhost:3000/api/v1/doctors/{doctor_id}/schedules`.
Example request:

```bash
curl --request POST \
  --url http://localhost:3000/api/v1/orders \
  --header 'user-access-token: eyJhbGciOiJIUzI1NiJ9.eyJpZCI6bnVsbCwiZXhwIjoxNjAzMTg0MzU0fQ.ByMm-tW1EA_yU-e20R-4RTwLljZAwr24IDc-en_-lmQ' \
  --form user_id=6 \
  --form doctor_id=2 \
  --form schedule_id=12 \
  --form payment_type=personal \
  --form notes=pusing
```

Example response:

```json
{
  "id": 1,
  "code": "V0DFU1",
  "status": "pending",
  "payment_type": "personal",
  "notes": "pusing",
  "district": "Tebet, Jakarta Selatan",
  "schedule_date": "Sunday, 27 September 2020",
  "schedule_hour": "09:00 - 09:20",
  "hospital": {
    "id": 4,
    "name": "RS Tebet",
    "support_emergency": true,
    "hospital_type": "Rumah Sakit"
  },
  "doctor": {
    "id": 2,
    "name": "dr. Tri Wahyu Setyaningsih, Sp.M",
    "speciality": "Dokter Spesialis Mata"
  }
}
```

### Make your order status to paid

By default, when you make order, your order status is `pending`. This order status will change to `paid` if you proccess your order to payment. But I don't have payment gateway yet, so I make an endpoint to change order status. Endpoint: `http://localhost:3000/api/v1/orders/{order_id}/checkout`. You need to define `order_id`, you can get it after create an order.

Example request:

```bash
curl --request POST \
  --url http://localhost:3000/api/v1/orders/1/checkout \
  --header 'user-access-token:eyJhbGciOiJIUzI1NiJ9.eyJpZCI6bnVsbCwiZXhwIjoxNjAzMTg0MzU0fQ.ByMm-tW1EA_yU-e20R-4RTwLljZAwr24IDc-en_-lmQ'
```

Example response:

```json
{
  "id": 1,
  "code": "V0DFU1",
  "status": "paid",
  "payment_type": "personal",
  "notes": "pusing",
  "district": "Tebet, Jakarta Selatan",
  "schedule_date": "Sunday, 27 September 2020",
  "schedule_hour": "09:00 - 09:20",
  "hospital": {
    "id": 4,
    "name": "RS Tebet",
    "support_emergency": true,
    "hospital_type": "Rumah Sakit"
  },
  "doctor": {
    "id": 2,
    "name": "dr. Tri Wahyu Setyaningsih, Sp.M",
    "speciality": "Dokter Spesialis Mata"
  }
}
```

### List Appointments (for doctor)

Doctor can see appointments with his patient through this endpoint. Endpoint: `http://localhost:3000/api/v1/doctors/{doctor_id}/appointments`.

Params:
|params |type |required/optional|
|------------|--------|-----------------|
|date |string |required |

Example request:

```bash
curl --request GET \
  --url http://localhost:3000/api/v1/doctors/2/appointments \
  --form date=2020-09-27
```

Example response:

```json
{
  "appointments": [
    {
      "hospital": "RS Tebet",
      "district": "Tebet, Jakarta Selatan",
      "date": "Sunday, 27 September 2020",
      "time": "09:00 - 09:20",
      "patient": "M. Arif Sefrianto",
      "gender": "male",
      "age": 28
    }
  ]
}
```
