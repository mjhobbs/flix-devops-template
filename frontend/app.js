const API = "http://localhost:8080";

async function loadVideos() {
  console.log("Loading videos...");
  const res = await fetch(`${API}/videos`);
  const data = await res.json();

  const list = document.getElementById("videos");
  list.innerHTML = "";

  data.forEach(v => {
    const li = document.createElement("li");
    li.innerText = v.title;
    li.onclick = () => watchVideo(v.id);
    list.appendChild(li);
  });
}

async function watchVideo(id) {
  await fetch(`${API}/history`, {
    method: "POST",
    headers: {"Content-Type":"application/json"},
    body: JSON.stringify({ videoId: id })
  });

  alert("Watched video " + id);
}
