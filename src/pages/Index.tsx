import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Code, Server, Terminal, GitBranch, Shield, Zap, Monitor, Cloud } from "lucide-react";

const Index = () => {
  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-secondary/20 to-primary/5">
      {/* Header */}
      <header className="border-b bg-background/80 backdrop-blur-md sticky top-0 z-50">
        <div className="container mx-auto px-6 py-4">
          <div className="flex items-center space-x-3">
            <div className="p-2 rounded-lg bg-primary/10">
              <Code className="h-6 w-6 text-primary" />
            </div>
            <div>
              <h1 className="text-xl font-bold">CloudCode Server</h1>
              <p className="text-sm text-muted-foreground">Professional Cloud-Based Development Environment</p>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="py-20 px-6">
        <div className="container mx-auto text-center">
          <div className="max-w-3xl mx-auto">
            <Badge variant="secondary" className="mb-6 px-4 py-2">
              <Cloud className="h-4 w-4 mr-2" />
              Production Ready
            </Badge>
            <h1 className="text-5xl font-bold mb-6 bg-gradient-to-r from-primary to-accent bg-clip-text text-transparent">
              Your Personal Cloud IDE
            </h1>
            <p className="text-xl text-muted-foreground mb-8 leading-relaxed">
              Access VS Code from anywhere with full Linux terminal, multi-language support, 
              and seamless GitHub integration. Deploy in minutes with Docker.
            </p>
            <div className="flex flex-col sm:flex-row gap-4 justify-center">
              <Button size="lg" className="bg-gradient-to-r from-primary to-primary-glow hover:shadow-lg transition-all">
                <Server className="h-5 w-5 mr-2" />
                Quick Deploy
              </Button>
              <Button variant="outline" size="lg">
                <GitBranch className="h-5 w-5 mr-2" />
                View on GitHub
              </Button>
            </div>
          </div>
        </div>
      </section>

      {/* Features Grid */}
      <section className="py-16 px-6">
        <div className="container mx-auto">
          <div className="text-center mb-16">
            <h2 className="text-3xl font-bold mb-4">Enterprise-Grade Features</h2>
            <p className="text-muted-foreground max-w-2xl mx-auto">
              Everything you need for professional development in the cloud
            </p>
          </div>
          
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            {features.map((feature, index) => (
              <Card key={index} className="border-0 shadow-lg hover:shadow-xl transition-all duration-300 bg-card/50 backdrop-blur-sm">
                <CardHeader>
                  <div className={`p-3 rounded-lg w-fit ${feature.color}`}>
                    <feature.icon className="h-6 w-6 text-white" />
                  </div>
                  <CardTitle className="text-xl">{feature.title}</CardTitle>
                  <CardDescription className="text-base">{feature.description}</CardDescription>
                </CardHeader>
                <CardContent>
                  <ul className="space-y-2">
                    {feature.items.map((item, i) => (
                      <li key={i} className="flex items-center text-sm text-muted-foreground">
                        <div className="h-1.5 w-1.5 rounded-full bg-primary mr-3" />
                        {item}
                      </li>
                    ))}
                  </ul>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Tech Stack */}
      <section className="py-16 px-6 bg-card/30">
        <div className="container mx-auto">
          <div className="text-center mb-12">
            <h2 className="text-3xl font-bold mb-4">Built with Modern Tech</h2>
            <p className="text-muted-foreground">Powered by industry-standard tools and frameworks</p>
          </div>
          
          <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-8">
            {techStack.map((tech, index) => (
              <div key={index} className="text-center">
                <div className="p-4 rounded-xl bg-background border shadow-sm hover:shadow-md transition-all">
                  <div className="text-2xl mb-2">{tech.icon}</div>
                  <div className="text-sm font-medium">{tech.name}</div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>

      {/* Quick Start */}
      <section className="py-16 px-6">
        <div className="container mx-auto">
          <div className="max-w-4xl mx-auto">
            <div className="text-center mb-12">
              <h2 className="text-3xl font-bold mb-4">Deploy in 3 Steps</h2>
              <p className="text-muted-foreground">Get your cloud IDE running in under 5 minutes</p>
            </div>
            
            <div className="grid md:grid-cols-3 gap-8">
              {deploySteps.map((step, index) => (
                <div key={index} className="text-center">
                  <div className="h-12 w-12 rounded-full bg-primary text-primary-foreground font-bold text-lg flex items-center justify-center mx-auto mb-4">
                    {index + 1}
                  </div>
                  <h3 className="text-lg font-semibold mb-2">{step.title}</h3>
                  <p className="text-muted-foreground text-sm mb-4">{step.description}</p>
                  <code className="text-xs bg-secondary px-3 py-2 rounded font-mono">
                    {step.command}
                  </code>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t bg-card/50 py-8 px-6">
        <div className="container mx-auto text-center">
          <p className="text-muted-foreground">
            Built for developers, by developers. Deploy your cloud IDE today.
          </p>
        </div>
      </footer>
    </div>
  );
};

const features = [
  {
    icon: Code,
    title: "VS Code Experience",
    description: "Full VS Code editor with extensions and themes",
    color: "bg-accent",
    items: [
      "Native VS Code interface",
      "Extension marketplace",
      "Custom themes & settings",
      "IntelliSense & debugging"
    ]
  },
  {
    icon: Terminal,
    title: "Full Linux Terminal",
    description: "Complete shell access with all development tools",
    color: "bg-success",
    items: [
      "Bash/Zsh terminal",
      "Package managers (apt, pip, npm)",
      "System administration",
      "Custom shell configuration"
    ]
  },
  {
    icon: GitBranch,
    title: "Git Integration",
    description: "Seamless GitHub workflow with auto-sync",
    color: "bg-warning",
    items: [
      "GitHub repository sync",
      "Built-in Git commands",
      "SSH key management",
      "Auto-pull on startup"
    ]
  },
  {
    icon: Shield,
    title: "Security First",
    description: "Enterprise-grade security and authentication",
    color: "bg-destructive",
    items: [
      "Password protection",
      "HTTPS/SSL support",
      "Isolated containers",
      "Secure file access"
    ]
  },
  {
    icon: Zap,
    title: "Multi-Language",
    description: "Support for all major programming languages",
    color: "bg-primary",
    items: [
      "Python, Node.js, C++",
      "HTML, CSS, JavaScript",
      "Package installation",
      "Language servers"
    ]
  },
  {
    icon: Monitor,
    title: "Cloud Ready",
    description: "Deploy anywhere with Docker containers",
    color: "bg-primary-glow",
    items: [
      "Docker containerized",
      "Auto-restart support",
      "Persistent storage",
      "Easy cloud deployment"
    ]
  }
];

const techStack = [
  { name: "Docker", icon: "🐳" },
  { name: "VS Code", icon: "💻" },
  { name: "Node.js", icon: "🟢" },
  { name: "Python", icon: "🐍" },
  { name: "Git", icon: "📚" },
  { name: "Linux", icon: "🐧" }
];

const deploySteps = [
  {
    title: "Clone Repository",
    description: "Download the CloudCode server configuration",
    command: "git clone <repo-url> && cd cloudcode-server"
  },
  {
    title: "Configure Environment",
    description: "Set your password and preferences",
    command: "cp .env.example .env && nano .env"
  },
  {
    title: "Launch Server",
    description: "Deploy with Docker Compose",
    command: "docker-compose up -d"
  }
];

export default Index;