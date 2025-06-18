export default async function getRandomImage() {
  const UNSPLASH_API_KEY = "b1HAmSBpsCm3DuS-goEABWmsyl5eFc_QcKTXm-DvMqo";
  const url =
    "https://api.unsplash.com/photos/random?orientation=landscape&collections=wallpapers";
  const request = await fetch(url, {
    headers: { Authorization: "Client-ID " + UNSPLASH_API_KEY },
  });
  const data = await request.json();
  console.log(data);
  console.log("test");
}
