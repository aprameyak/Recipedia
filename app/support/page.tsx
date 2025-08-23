import Link from 'next/link';
import Image from 'next/image';

export default function Support() {
  const faqs = [
    {
      question: "How do I create an account?",
      answer: "You can create an account by clicking the 'Sign Up' button on the home page and following the registration process."
    },
    {
      question: "How do I submit a recipe?",
      answer: "After logging in, click on 'Submit Recipe' in your profile menu and fill out the recipe form with ingredients, instructions, and photos."
    },
    {
      question: "Can I edit my submitted recipes?",
      answer: "Yes, you can edit your recipes by going to your profile and selecting 'My Recipes' to find and edit your submissions."
    },
    {
      question: "How do I save recipes to my favorites?",
      answer: "Click the heart icon on any recipe card to save it to your favorites list for easy access later."
    },
    {
      question: "Is the app available on mobile devices?",
      answer: "Yes! Our mobile app is available for both iOS and Android devices. You can download it from the respective app stores."
    },
    {
      question: "How do I report inappropriate content?",
      answer: "You can report inappropriate content by clicking the three dots menu on any recipe and selecting 'Report'. Our team will review it promptly."
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
            <Link href="/" className="text-2xl font-bold text-green-700">CookingApp</Link>
          </div>
          <nav className="flex space-x-6">
            <Link href="/" className="text-gray-600 hover:text-gray-800 font-medium">
              Home
            </Link>
            <Link href="/privacy" className="text-gray-600 hover:text-gray-800 font-medium">
              Privacy
            </Link>
            <Link href="/support" className="text-green-700 hover:text-green-800 font-medium">
              Support
            </Link>
          </nav>
        </div>
      </header>

      {/* Main Content */}
      <main className="py-16">
        <div className="container mx-auto px-4 max-w-4xl">
          <h1 className="text-4xl font-bold text-center mb-12 text-gray-800">
            Support Center
          </h1>

          {/* Contact Section */}
          <section className="card mb-12">
            <h2 className="text-2xl font-semibold mb-6 text-gray-800">Get in Touch</h2>
            <div className="grid md:grid-cols-2 gap-8">
              <div>
                <h3 className="text-lg font-semibold mb-4 text-gray-800">Email Support</h3>
                <p className="text-gray-700 mb-4">
                  For general inquiries, technical support, or feedback, please email us at:
                </p>
                <a 
                  href="mailto:aprameyakannan@gmail.com" 
                  className="text-green-600 hover:text-green-800 font-semibold text-lg"
                >
                  aprameyakannan@gmail.com
                </a>
                <p className="text-gray-600 mt-2">
                  We typically respond within 24-48 hours.
                </p>
              </div>
              <div>
                <h3 className="text-lg font-semibold mb-4 text-gray-800">Response Times</h3>
                <ul className="space-y-2 text-gray-700">
                  <li>• General inquiries: 24-48 hours</li>
                  <li>• Technical issues: 12-24 hours</li>
                  <li>• Bug reports: 6-12 hours</li>
                  <li>• Urgent issues: 2-4 hours</li>
                </ul>
              </div>
            </div>
          </section>

          {/* FAQ Section */}
          <section className="card mb-12">
            <h2 className="text-2xl font-semibold mb-8 text-gray-800">Frequently Asked Questions</h2>
            <div className="space-y-6">
              {faqs.map((faq, index) => (
                <div key={index} className="border-b border-gray-200 pb-6 last:border-b-0">
                  <h3 className="text-lg font-semibold mb-3 text-gray-800">{faq.question}</h3>
                  <p className="text-gray-700">{faq.answer}</p>
                </div>
              ))}
            </div>
          </section>

          {/* Help Categories */}
          <section className="card mb-12">
            <h2 className="text-2xl font-semibold mb-8 text-gray-800">Help Categories</h2>
            <div className="grid md:grid-cols-3 gap-6">
              <div className="text-center p-6 border border-gray-200 rounded-lg">
                <div className="text-3xl mb-4">📱</div>
                <h3 className="text-lg font-semibold mb-2 text-gray-800">App Issues</h3>
                <p className="text-gray-600 text-sm">
                  Problems with app functionality, crashes, or performance issues
                </p>
              </div>
              <div className="text-center p-6 border border-gray-200 rounded-lg">
                <div className="text-3xl mb-4">👤</div>
                <h3 className="text-lg font-semibold mb-2 text-gray-800">Account Help</h3>
                <p className="text-gray-600 text-sm">
                  Login problems, password reset, profile management
                </p>
              </div>
              <div className="text-center p-6 border border-gray-200 rounded-lg">
                <div className="text-3xl mb-4">🍳</div>
                <h3 className="text-lg font-semibold mb-2 text-gray-800">Recipe Features</h3>
                <p className="text-gray-600 text-sm">
                  Questions about submitting, editing, or managing recipes
                </p>
              </div>
            </div>
          </section>

          {/* Additional Support */}
          <section className="card">
            <h2 className="text-2xl font-semibold mb-6 text-gray-800">Additional Resources</h2>
            <div className="grid md:grid-cols-2 gap-6">
              <div>
                <h3 className="text-lg font-semibold mb-3 text-gray-800">Privacy & Legal</h3>
                <ul className="space-y-2 text-gray-700">
                  <li>• <Link href="/privacy" className="text-green-600 hover:text-green-800">Privacy Policy</Link></li>
                  <li>• Terms of Service</li>
                  <li>• Cookie Policy</li>
                </ul>
              </div>
              <div>
                <h3 className="text-lg font-semibold mb-3 text-gray-800">Community</h3>
                <ul className="space-y-2 text-gray-700">
                  <li>• User Guidelines</li>
                  <li>• Community Standards</li>
                  <li>• Report Content</li>
                </ul>
              </div>
            </div>
          </section>
        </div>
      </main>

      {/* Footer */}
      <footer className="bg-gray-800 text-white py-8">
        <div className="container mx-auto px-4 text-center">
          <p>&copy; 2024 CookingApp. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}
