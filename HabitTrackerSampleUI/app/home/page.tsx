import Layout from '../components/layout'
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { CheckCircle2 } from 'lucide-react'

const habits = [
  { id: 1, title: 'Morning Meditation', streak: 5 },
  { id: 2, title: 'Read for 30 minutes', streak: 3 },
  { id: 3, title: 'Exercise', streak: 7 },
]

export default function HomeScreen() {
  return (
    <Layout>
      <div className="max-w-2xl mx-auto">
        <h1 className="text-3xl font-bold text-blue-600 mb-6">Welcome back, User!</h1>
        <Card className="mb-6">
          <CardHeader>
            <CardTitle>Motivational Quote</CardTitle>
          </CardHeader>
          <CardContent>
            <p className="text-gray-600 italic">"The secret of getting ahead is getting started." - Mark Twain</p>
          </CardContent>
        </Card>
        <h2 className="text-2xl font-semibold mb-4">Your Habits</h2>
        <div className="space-y-4">
          {habits.map((habit) => (
            <Card key={habit.id}>
              <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
                <CardTitle className="text-sm font-medium">
                  {habit.title}
                </CardTitle>
                <CheckCircle2 className="h-4 w-4 text-green-500" aria-hidden="true" />
              </CardHeader>
              <CardContent>
                <p className="text-xs text-muted-foreground">
                  {habit.streak} day streak
                </p>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </Layout>
  )
}

