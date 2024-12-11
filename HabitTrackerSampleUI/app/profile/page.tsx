import Layout from '../components/layout'
import { Button } from "@/components/ui/button"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar"
import { Trophy, Award, Zap } from 'lucide-react'

export default function ProfileScreen() {
  return (
    <Layout>
      <div className="max-w-md mx-auto">
        <Card>
          <CardHeader>
            <div className="flex items-center space-x-4">
              <Avatar className="w-20 h-20">
                <AvatarImage src="/placeholder-avatar.jpg" alt="User" />
                <AvatarFallback>JD</AvatarFallback>
              </Avatar>
              <div>
                <CardTitle className="text-2xl font-bold">John Doe</CardTitle>
                <p className="text-gray-600">john.doe@example.com</p>
              </div>
            </div>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-3 gap-4 mb-6">
              <div className="text-center">
                <Trophy className="h-8 w-8 mx-auto text-yellow-500" />
                <p className="mt-1 font-semibold">10</p>
                <p className="text-xs text-gray-600">Habits</p>
              </div>
              <div className="text-center">
                <Award className="h-8 w-8 mx-auto text-blue-500" />
                <p className="mt-1 font-semibold">30</p>
                <p className="text-xs text-gray-600">Days</p>
              </div>
              <div className="text-center">
                <Zap className="h-8 w-8 mx-auto text-green-500" />
                <p className="mt-1 font-semibold">5</p>
                <p className="text-xs text-gray-600">Streaks</p>
              </div>
            </div>
            <Button className="w-full" variant="outline">Edit Profile</Button>
            <Button className="w-full mt-2" variant="destructive">Log Out</Button>
          </CardContent>
        </Card>
      </div>
    </Layout>
  )
}

