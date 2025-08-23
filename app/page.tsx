<<<<<<< HEAD
import Link from 'next/link';
import Image from 'next/image';

export default function Home() {
  const featuredRecipes = [
    {
      id: 1,
      title: "Spaghetti Carbonara",
      description: "Classic Italian pasta with eggs, cheese, and pancetta",
      image: "https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5?w=400&h=300&fit=crop",
      time: "20 min",
      difficulty: "Easy"
    },
    {
      id: 2,
      title: "Chicken Tikka Masala",
      description: "Creamy and flavorful Indian curry with tender chicken",
      image: "https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=400&h=300&fit=crop",
      time: "45 min",
      difficulty: "Medium"
    },
    {
      id: 3,
      title: "Caesar Salad",
      description: "Fresh romaine lettuce with classic Caesar dressing",
      image: "https://images.unsplash.com/photo-1546793665-c74683f339c1?w=400&h=300&fit=crop",
      time: "15 min",
      difficulty: "Easy"
    }
  ];

  return (
    <div className="min-h-screen">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="container mx-auto px-4 py-4 flex justify-between items-center">
          <div className="flex items-center space-x-3">
            <Image 
              src="/cooking-icon.svg" 
              alt="CookingApp" 
              width={40} 
              height={40}
            />
            <h1 className="text-2xl font-bold text-green-700">CookingApp</h1>
          </div>
          <nav className="flex space-x-6">
            <Link href="/" className="text-green-700 hover:text-green-800 font-medium">
              Home
            </Link>
            <Link href="/privacy" className="text-gray-600 hover:text-gray-800 font-medium">
              Privacy
            </Link>
            <Link href="/support" className="text-gray-600 hover:text-gray-800 font-medium">
              Support
            </Link>
          </nav>
        </div>
      </header>

      {/* Hero Section */}
      <section className="bg-gradient-to-r from-green-600 to-green-800 text-white py-20">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-5xl font-bold mb-6">Discover Amazing Recipes</h2>
          <p className="text-xl mb-8 max-w-2xl mx-auto">
            Explore thousands of delicious recipes from around the world. 
            From quick weeknight dinners to impressive weekend feasts.
          </p>
          <button className="btn-primary bg-orange-500 hover:bg-orange-600 text-lg px-8 py-4">
            Start Cooking Today
          </button>
        </div>
      </section>

      {/* Featured Recipes */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <h3 className="text-3xl font-bold text-center mb-12 text-gray-800">
            Featured Recipes
          </h3>
          <div className="grid md:grid-cols-3 gap-8">
            {featuredRecipes.map((recipe) => (
              <div key={recipe.id} className="card hover:shadow-lg transition-shadow duration-300">
                <div className="relative h-48 mb-4 rounded-lg overflow-hidden">
                  <Image
                    src={recipe.image}
                    alt={recipe.title}
                    fill
                    className="object-cover"
                  />
                </div>
                <h4 className="text-xl font-semibold mb-2 text-gray-800">{recipe.title}</h4>
                <p className="text-gray-600 mb-4">{recipe.description}</p>
                <div className="flex justify-between items-center">
                  <span className="text-sm text-gray-500">⏱ {recipe.time}</span>
                  <span className="text-sm text-gray-500">📊 {recipe.difficulty}</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Categories Section */}
      <section className="py-16 bg-gray-50">
        <div className="container mx-auto px-4">
          <h3 className="text-3xl font-bold text-center mb-12 text-gray-800">
            Recipe Categories
          </h3>
          <div className="grid md:grid-cols-4 gap-6">
            {[
              { name: "Breakfast", icon: "🍳", count: "150+" },
              { name: "Lunch", icon: "🥪", count: "200+" },
              { name: "Dinner", icon: "🍽️", count: "300+" },
              { name: "Desserts", icon: "🍰", count: "100+" }
            ].map((category, index) => (
              <div key={index} className="card text-center hover:shadow-lg transition-shadow duration-300">
                <div className="text-4xl mb-3">{category.icon}</div>
                <h4 className="text-lg font-semibold mb-2">{category.name}</h4>
                <p className="text-gray-600">{category.count} recipes</p>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-800 text-white py-12">
        <div className="container mx-auto px-4">
          <div className="grid md:grid-cols-4 gap-8">
            <div>
              <div className="flex items-center space-x-3 mb-4">
                <Image 
                  src="/cooking-icon.svg" 
                  alt="CookingApp" 
                  width={32} 
                  height={32}
                />
                <h4 className="text-xl font-bold">CookingApp</h4>
              </div>
              <p className="text-gray-300">
                Your go-to destination for delicious recipes and cooking inspiration.
              </p>
            </div>
            <div>
              <h5 className="font-semibold mb-4">Quick Links</h5>
              <ul className="space-y-2">
                <li><Link href="/" className="text-gray-300 hover:text-white">Home</Link></li>
                <li><Link href="/privacy" className="text-gray-300 hover:text-white">Privacy Policy</Link></li>
                <li><Link href="/support" className="text-gray-300 hover:text-white">Support</Link></li>
              </ul>
            </div>
            <div>
              <h5 className="font-semibold mb-4">Contact</h5>
              <p className="text-gray-300">
                Email: <a href="mailto:aprameyakannan@gmail.com" className="hover:text-white">aprameyakannan@gmail.com</a>
              </p>
            </div>
            <div>
              <h5 className="font-semibold mb-4">Follow Us</h5>
              <div className="flex space-x-4">
                <span className="text-2xl">📱</span>
                <span className="text-2xl">📷</span>
                <span className="text-2xl">🐦</span>
              </div>
            </div>
          </div>
          <div className="border-t border-gray-700 mt-8 pt-8 text-center text-gray-300">
            <p>&copy; 2024 CookingApp. All rights reserved.</p>
          </div>
        </div>
=======
import Image from "next/image";

export default function Home() {
  return (
    <div className="font-sans grid grid-rows-[20px_1fr_20px] items-center justify-items-center min-h-screen p-8 pb-20 gap-16 sm:p-20">
      <main className="flex flex-col gap-[32px] row-start-2 items-center sm:items-start">
        <Image
          className="dark:invert"
          src="/next.svg"
          alt="Next.js logo"
          width={180}
          height={38}
          priority
        />
        <ol className="font-mono list-inside list-decimal text-sm/6 text-center sm:text-left">
          <li className="mb-2 tracking-[-.01em]">
            Get started by editing{" "}
            <code className="bg-black/[.05] dark:bg-white/[.06] font-mono font-semibold px-1 py-0.5 rounded">
              app/page.tsx
            </code>
            .
          </li>
          <li className="tracking-[-.01em]">
            Save and see your changes instantly.
          </li>
        </ol>

        <div className="flex gap-4 items-center flex-col sm:flex-row">
          <a
            className="rounded-full border border-solid border-transparent transition-colors flex items-center justify-center bg-foreground text-background gap-2 hover:bg-[#383838] dark:hover:bg-[#ccc] font-medium text-sm sm:text-base h-10 sm:h-12 px-4 sm:px-5 sm:w-auto"
            href="https://vercel.com/new?utm_source=create-next-app&utm_medium=appdir-template-tw&utm_campaign=create-next-app"
            target="_blank"
            rel="noopener noreferrer"
          >
            <Image
              className="dark:invert"
              src="/vercel.svg"
              alt="Vercel logomark"
              width={20}
              height={20}
            />
            Deploy now
          </a>
          <a
            className="rounded-full border border-solid border-black/[.08] dark:border-white/[.145] transition-colors flex items-center justify-center hover:bg-[#f2f2f2] dark:hover:bg-[#1a1a1a] hover:border-transparent font-medium text-sm sm:text-base h-10 sm:h-12 px-4 sm:px-5 w-full sm:w-auto md:w-[158px]"
            href="https://nextjs.org/docs?utm_source=create-next-app&utm_medium=appdir-template-tw&utm_campaign=create-next-app"
            target="_blank"
            rel="noopener noreferrer"
          >
            Read our docs
          </a>
        </div>
      </main>
      <footer className="row-start-3 flex gap-[24px] flex-wrap items-center justify-center">
        <a
          className="flex items-center gap-2 hover:underline hover:underline-offset-4"
          href="https://nextjs.org/learn?utm_source=create-next-app&utm_medium=appdir-template-tw&utm_campaign=create-next-app"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Image
            aria-hidden
            src="/file.svg"
            alt="File icon"
            width={16}
            height={16}
          />
          Learn
        </a>
        <a
          className="flex items-center gap-2 hover:underline hover:underline-offset-4"
          href="https://vercel.com/templates?framework=next.js&utm_source=create-next-app&utm_medium=appdir-template-tw&utm_campaign=create-next-app"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Image
            aria-hidden
            src="/window.svg"
            alt="Window icon"
            width={16}
            height={16}
          />
          Examples
        </a>
        <a
          className="flex items-center gap-2 hover:underline hover:underline-offset-4"
          href="https://nextjs.org?utm_source=create-next-app&utm_medium=appdir-template-tw&utm_campaign=create-next-app"
          target="_blank"
          rel="noopener noreferrer"
        >
          <Image
            aria-hidden
            src="/globe.svg"
            alt="Globe icon"
            width={16}
            height={16}
          />
          Go to nextjs.org →
        </a>
>>>>>>> e51c991b98296fe6652f02a617786e56506b319b
      </footer>
    </div>
  );
}
