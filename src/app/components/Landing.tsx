export default function Landing() {
    return (
        <main className="min-h-screen flex flex-col items-center justify-center px-6 bg-white text-gray-800">
            <h1 className="text-4xl md:text-6xl font-extrabold text-center mb-4">Bookish</h1>
            <p className="text-lg md:Text-xl text-center max-w-xl mb-6">
                Where book lovers unite to share, discover, and discuss their favorite reads.
            </p>
            <div className="flex gap-4 mb-10">
                <button className="bg-black text-white px-5 py-3 rounded-xl hover:bg-gray-800 transition">Start Reading</button>
                <button className="border border-black px-5 py-3 rounded-xl hover:bg-gray-100 transition">Create Your Profile</button>
            </div>

            <div className="grid gap-3 text-center">
                <p>✨ Blog-like reviews — not just star ratings</p>
                <p>✨ Follow kindred readers & explore their shelves</p>
                <p>✨ Mood tags, spoiler warnings, and personality</p>
            </div>

            <footer className="mt-10 text-sm text-gray-400">
                <p>© 2025 Bookish. Built with love.</p>
                <p>
                    <a href="https://github.com/AaronTi30/bookish" className="underline">Github</a> • Contact: aaronthakoordeen@gmail.com
                </p>
            </footer>
        </main>
    )
}