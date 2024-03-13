//
//  LoginViewModel.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 13/03/2024.
//
import UIKit
import Combine

final class LoginViewModel: ObservableObject {
  @Published var userEmail = ""
  @Published var userPassword = ""
  
  @Published var formIsValid = false
  
  private var publishers = Set<AnyCancellable>()
  
  init() {
    isSignupFormValidPublisher
      .receive(on: RunLoop.main)
      .assign(to: \.formIsValid, on: self)
      .store(in: &publishers)
  }
}


private extension LoginViewModel {
  var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
    $userEmail
      .map { email in
          let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
          return emailPredicate.evaluate(with: email)
      }
      .eraseToAnyPublisher()
  }
  
  var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
    $userPassword
      .map { password in
          return password.count >= 8
      }
      .eraseToAnyPublisher()
  }
  
  var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
    Publishers.CombineLatest(isUserEmailValidPublisher, isPasswordValidPublisher)
      .map { isEmailValid, isPasswordValid in
          return  isEmailValid && isPasswordValid
      }
      .eraseToAnyPublisher()
  }
}
