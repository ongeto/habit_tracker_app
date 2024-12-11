"use client"

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import Layout from '../components/layout'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Card, CardContent, CardFooter, CardHeader, CardTitle } from "@/components/ui/card"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"

export default function LoginScreen() {
  const [activeTab, setActiveTab] = useState('login')
  const router = useRouter()

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    router.push('/home')
  }

  return (
    <Layout>
      <div className="flex justify-center items-center h-screen">
        <Card className="w-[350px]">
          <CardHeader>
            <CardTitle className="text-2xl font-bold text-center text-blue-600">HabitTracker</CardTitle>
          </CardHeader>
          <CardContent>
            <Tabs value={activeTab} onValueChange={setActiveTab}>
              <TabsList className="grid w-full grid-cols-2">
                <TabsTrigger value="login">Login</TabsTrigger>
                <TabsTrigger value="signup">Sign Up</TabsTrigger>
              </TabsList>
              <TabsContent value="login">
                <form onSubmit={handleSubmit}>
                  <div className="space-y-4">
                    <Input type="email" placeholder="Email" required />
                    <Input type="password" placeholder="Password" required />
                    <Button type="submit" className="w-full">Login</Button>
                  </div>
                </form>
              </TabsContent>
              <TabsContent value="signup">
                <form onSubmit={handleSubmit}>
                  <div className="space-y-4">
                    <Input type="text" placeholder="Name" required />
                    <Input type="email" placeholder="Email" required />
                    <Input type="password" placeholder="Password" required />
                    <Button type="submit" className="w-full">Sign Up</Button>
                  </div>
                </form>
              </TabsContent>
            </Tabs>
          </CardContent>
          <CardFooter className="flex justify-center">
            <Button variant="link" className="text-sm text-blue-600">Forgot Password?</Button>
          </CardFooter>
        </Card>
      </div>
    </Layout>
  )
}

