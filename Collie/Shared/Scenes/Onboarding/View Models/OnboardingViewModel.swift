import Foundation
import SwiftUI

final class OnboardingViewModel: ObservableObject {
    
    var onboardingType: OnboardingType
    
    init(onboardingType: OnboardingType) {
        self.onboardingType = onboardingType
        switch onboardingType {
        case .businessManager:
            self.onboardingPages = businessManagerPages
        case .employee:
            self.onboardingPages = employeePages
        }
        self.currentPage = self.onboardingPages[0]
    }
    
    var onboardingPages: [OnboardingPage] = []
    
    var employeePages: [OnboardingPage] = [
        .init(title: "Seja bem vindo ao seu novo workspace!", subtitles: ["Com a plataforma Collie, você consegue embarcar em jornadas, acompanhando seus eventos e tarefas em uma interface amigável."], imageName: "onboarding-colaborador1"),
        .init(title: "Embarque em jornadas feitas para você", subtitles: ["As jornadas são gerenciadas pela liderança da sua empresa, preparadas para que você tenha uma recepção completa!"], imageName: "onboarding-colaborador2"),
        .init(title: "Mantenha suas tarefas e eventos organizados", subtitles: ["Saiba quais são seus eventos do dia com apenas um olhar, e com um clique.", "Marque tarefas e eventos como concluídos e veja suas conquistas e crescimento durante a jornada!"], imageName: "onboarding-colaborador3")
    ]
    
    var businessManagerPages: [OnboardingPage] = [
        .init(title: "Seja bem vindo ao seu novo workspace!", subtitles: ["Com a plataforma Collie, você consegue gerar jornadas, acompanhar seus colaboradores e definir novas tarefas e eventos."], imageName: "onboarding-gestor1"),
        .init(title: "Crie jornadas customizadas para cada time", subtitles: ["Desenvolva jornadas para diferentes times de colaboradores na sua tela de jornadas.", "Crie tarefas e eventos e gerencie pessoas de forma simples e prática."], imageName: "onboarding-gestor2"),
        .init(title: "Organize rápido e fácil suas jornadas", subtitles: ["Marque e modifique eventos com facilidade, notificando o time caso seja necessário.", "Crie tarefas engajantes para seus novos colaboradores e acompanhe o progresso de cada um"], imageName: "onboarding-gestor3"),
        .init(title: "Acompanhe o progresso de cada usuário", subtitles: ["Visualize o progresso de cada colaborador, observe suas tarefas cumpridas, suas principais conquistas e dificuldades."], imageName: "onboarding-gestor4"),
        .init(title: "Gerencie seus usuários e selecione papeis", subtitles: ["Na tela configurações, adicione facilmente novos colaboradores e configure seus níveis de permissão. Acompanhe também os novos convites enviados."], imageName: "onboarding-gestor5")
    ]
    
    @Published var currentPage: OnboardingPage
    
    @Published var currentIndex = 0 {
        didSet {
            currentPage = onboardingPages[currentIndex]
        }
    }
    
    @Published var showFinishPage = false
    
    func nextPage() {
        if currentIndex < onboardingPages.count - 1 {
            currentIndex += 1
        } else {
            finishOnboarding()
        }
    }
    
    func previousPage() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    func finishOnboarding() {
        print("Onboarding finished")
        showFinishPage = true
        OnboardingStorageService.shared.markOnboardingDone(onboardingType: onboardingType)
    }
    
    func skipOnboarding() {
        OnboardingStorageService.shared.markOnboardingDone(onboardingType: onboardingType)
    }
    
    func restartOnboarding() {
        withAnimation {
            self.showFinishPage = false
            self.currentIndex = 0
        }
    }
    
    func shouldShowPreviousButton() -> Bool {
        currentIndex > 0
    }
}

enum OnboardingType: String {
    case employee = "Employee"
    case businessManager = "Manager"
}

struct OnboardingPage {
    var title: String
    var subtitles: [String]
    var imageName: String
}
