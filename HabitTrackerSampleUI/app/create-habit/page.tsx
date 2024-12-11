"use client"

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import Layout from '../components/layout'
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Textarea } from "@/components/ui/textarea"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card"
import { ArrowLeft, Clock, Award } from 'lucide-react'
import { Label } from "@/components/ui/label"
import { Checkbox } from "@/components/ui/checkbox"

export default function CreateHabitScreen() {
  const router = useRouter()
  const [formData, setFormData] = useState({
    title: '',
    description: '',
    category: '',
    targetDays: '',
    reminders: [],
  })
  const [errors, setErrors] = useState({})

  const handleInputChange = (e) => {
    const { name, value } = e.target
    setFormData(prev => ({ ...prev, [name]: value }))
    setErrors(prev => ({ ...prev, [name]: '' }))
  }

  const handleCategoryChange = (value) => {
    setFormData(prev => ({ ...prev, category: value }))
    setErrors(prev => ({ ...prev, category: '' }))
  }

  const handleReminderChange = (time, checked) => {
    setFormData(prev => ({
      ...prev,
      reminders: checked
        ? [...prev.reminders, time]
        : prev.reminders.filter(t => t !== time)
    }))
  }

  const validateForm = () => {
    let newErrors = {}
    if (!formData.title.trim()) newErrors.title = 'Title is required'
    if (!formData.category) newErrors.category = 'Category is required'
    if (!formData.targetDays) newErrors.targetDays = 'Target days is required'
    else if (parseInt(formData.targetDays) < 1 || parseInt(formData.targetDays) > 30) {
      newErrors.targetDays = 'Target days must be between 1 and 30'
    }
    setErrors(newErrors)
    return Object.keys(newErrors).length === 0
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    if (validateForm()) {
      console.log(formData)
      router.push('/home')
    }
  }

  return (
    <Layout>
      <div className="pb-20">
        <Button variant="ghost" onClick={() => router.back()} className="mb-4">
          <ArrowLeft className="mr-2 h-4 w-4" aria-hidden="true" /> Back
        </Button>
        <Card>
          <CardHeader>
            <CardTitle className="text-2xl font-bold text-center text-blue-600">Create New Habit</CardTitle>
          </CardHeader>
          <CardContent>
            <form onSubmit={handleSubmit} className="space-y-6">
              <div className="space-y-2">
                <Label htmlFor="title" className="text-sm font-medium">Habit Title</Label>
                <Input
                  id="title"
                  name="title"
                  value={formData.title}
                  onChange={handleInputChange}
                  placeholder="Enter a habit name"
                  aria-invalid={errors.title ? 'true' : 'false'}
                  aria-describedby={errors.title ? 'title-error' : undefined}
                />
                {errors.title && <p id="title-error" className="text-sm text-red-500">{errors.title}</p>}
              </div>
              <div className="space-y-2">
                <Label htmlFor="description" className="text-sm font-medium">Description</Label>
                <Textarea
                  id="description"
                  name="description"
                  value={formData.description}
                  onChange={handleInputChange}
                  placeholder="Briefly describe your habit"
                  maxLength={200}
                />
                <p className="text-xs text-gray-500">{formData.description.length}/200 characters</p>
              </div>
              <div className="space-y-2">
                <Label htmlFor="category" className="text-sm font-medium">Category</Label>
                <Select value={formData.category} onValueChange={handleCategoryChange}>
                  <SelectTrigger id="category" aria-invalid={errors.category ? 'true' : 'false'}>
                    <SelectValue placeholder="Select Category" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="health">Health</SelectItem>
                    <SelectItem value="fitness">Fitness</SelectItem>
                    <SelectItem value="productivity">Productivity</SelectItem>
                    <SelectItem value="learning">Learning</SelectItem>
                    <SelectItem value="personal">Personal Development</SelectItem>
                  </SelectContent>
                </Select>
                {errors.category && <p className="text-sm text-red-500">{errors.category}</p>}
              </div>
              <div className="space-y-2">
                <Label htmlFor="targetDays" className="text-sm font-medium">Target Days</Label>
                <Input
                  id="targetDays"
                  name="targetDays"
                  type="number"
                  min="1"
                  max="30"
                  value={formData.targetDays}
                  onChange={handleInputChange}
                  placeholder="Enter number of days"
                  aria-invalid={errors.targetDays ? 'true' : 'false'}
                  aria-describedby={errors.targetDays ? 'targetDays-error' : 'targetDays-description'}
                />
                <p id="targetDays-description" className="text-xs text-gray-500">Number of consecutive days to complete this habit</p>
                {errors.targetDays && <p id="targetDays-error" className="text-sm text-red-500">{errors.targetDays}</p>}
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Set Reminders</Label>
                <div className="flex items-center space-x-2">
                  <Clock className="h-4 w-4 text-gray-500" aria-hidden="true" />
                  <Checkbox
                    id="reminder-morning"
                    checked={formData.reminders.includes('09:00')}
                    onCheckedChange={(checked) => handleReminderChange('09:00', checked)}
                  />
                  <Label htmlFor="reminder-morning">Morning (9:00 AM)</Label>
                </div>
                <div className="flex items-center space-x-2">
                  <Clock className="h-4 w-4 text-gray-500" aria-hidden="true" />
                  <Checkbox
                    id="reminder-afternoon"
                    checked={formData.reminders.includes('15:00')}
                    onCheckedChange={(checked) => handleReminderChange('15:00', checked)}
                  />
                  <Label htmlFor="reminder-afternoon">Afternoon (3:00 PM)</Label>
                </div>
                <div className="flex items-center space-x-2">
                  <Clock className="h-4 w-4 text-gray-500" aria-hidden="true" />
                  <Checkbox
                    id="reminder-evening"
                    checked={formData.reminders.includes('20:00')}
                    onCheckedChange={(checked) => handleReminderChange('20:00', checked)}
                  />
                  <Label htmlFor="reminder-evening">Evening (8:00 PM)</Label>
                </div>
              </div>
              <div className="space-y-2">
                <Label className="text-sm font-medium">Reward Points</Label>
                <div className="flex items-center space-x-2 bg-gray-100 p-2 rounded">
                  <Award className="h-4 w-4 text-yellow-500" aria-hidden="true" />
                  <span className="text-sm">Earn 10 points per day for this habit</span>
                </div>
              </div>
            </form>
          </CardContent>
        </Card>
      </div>
      <div className="fixed bottom-0 left-0 right-0 bg-white p-4 border-t border-gray-200">
        <div className="flex justify-between max-w-md mx-auto">
          <Button variant="outline" onClick={() => router.back()}>Cancel</Button>
          <Button onClick={handleSubmit}>Save</Button>
        </div>
      </div>
    </Layout>
  )
}

