var myHeaders = new Headers();
myHeaders.append("apikey", "bOKR76idZwBIcHKxPBm8IBjFfks3OYYq");

var requestOptions = {
  method: 'GET',
  redirect: 'follow',
  headers: myHeaders
};

fetch("https://api.apilayer.com/exchangerates_data/latest&base=USD", requestOptions)
  .then(response => response.text())
  .then(result => console.log(result))