export default async function getRandomImage() {
  const UNSPLASH_API_KEY = "";
  const url =
    "https://api.unsplash.com/photos/random?orientation=landscape&collections=11649432";
  const request = await fetch(url, {
    headers: { Authorization: "Client-ID " + UNSPLASH_API_KEY },
  });
  const data = await request.json();
  console.log(data);
}
getRandomImage();
