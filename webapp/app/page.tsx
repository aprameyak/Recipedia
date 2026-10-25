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
      <header className="bg-white shadow-sm">
        <div className="container mx-auto px-4 py-4 flex justify-between items-center">
          <div className="flex items-center space-x-3">
            <Image 
              src="/cooking-icon.svg" 
              alt="ChefSocial" 
              width={40} 
              height={40}
            />
            <h1 className="text-2xl font-bold text-green-700">ChefSocial</h1>
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

      <section className="bg-gradient-to-r from-green-600 to-green-800 text-white py-20">
        <div className="container mx-auto px-4 text-center">
          <h2 className="text-5xl font-bold mb-6">Connect, Share & Cook Amazing Recipes</h2>
          <p className="text-xl mb-8 max-w-2xl mx-auto">
            Join the ChefSocial community and discover thousands of delicious recipes from around the world. 
            Share your culinary creations and connect with fellow food enthusiasts.
          </p>
          <button className="btn-primary bg-orange-500 hover:bg-orange-600 text-lg px-8 py-4">
            Join ChefSocial Today
          </button>
        </div>
      </section>

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

      <section className="py-16">
        <div className="container mx-auto px-4 text-center">
          <h3 className="text-3xl font-bold mb-8 text-gray-800">
            Join Our Growing Community
          </h3>
          <div className="grid md:grid-cols-3 gap-8">
            <div className="text-center">
              <div className="text-4xl mb-4">👨‍🍳</div>
              <h4 className="text-xl font-semibold mb-2">Share Your Recipes</h4>
              <p className="text-gray-600">Upload and share your favorite recipes with the community</p>
            </div>
            <div className="text-center">
              <div className="text-4xl mb-4">🤝</div>
              <h4 className="text-xl font-semibold mb-2">Connect with Chefs</h4>
              <p className="text-gray-600">Follow other food enthusiasts and discover new cooking styles</p>
            </div>
            <div className="text-center">
              <div className="text-4xl mb-4">⭐</div>
              <h4 className="text-xl font-semibold mb-2">Rate & Review</h4>
              <p className="text-gray-600">Rate recipes and leave helpful reviews for the community</p>
            </div>
          </div>
        </div>
      </section>

      <footer className="bg-gray-800 text-white py-12">
        <div className="container mx-auto px-4">
          <div className="grid md:grid-cols-4 gap-8">
            <div>
              <div className="flex items-center space-x-3 mb-4">
                <Image 
                  src="/cooking-icon.svg" 
                  alt="ChefSocial" 
                  width={32} 
                  height={32}
                />
                <h4 className="text-xl font-bold">ChefSocial</h4>
              </div>
              <p className="text-gray-300">
                Your go-to destination for connecting with fellow food enthusiasts and discovering amazing recipes.
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
            <p>&copy; 2024 ChefSocial. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}

