import UIKit

public extension UIView {

    /**
     Добавляет массив представлений в качестве подпредставлений текущего представления.

     - Parameter subviews: Массив представлений (`UIView`),
     которые необходимо добавить в качестве подпредставлений текущего представления.

     ## Использование

     ```swift
     let parentView = UIView()
     let subview1 = UIView()
     let subview2 = UIView()
     let subview3 = UIView()

     parentView.addSubviews([subview1, subview2, subview3])
     ```

     Этот метод упрощает процесс добавления нескольких подпредставлений одновременно и устанавливает свойство
     `translatesAutoresizingMaskIntoConstraints` каждого подпредставления в `false`.

     - Warning: Убедитесь, что у вас есть правильная конфигурация Auto Layout для управления расположением
     и размером подпредставлений внутри родительского представления.

     - Attention: Этот метод предполагает использование Auto Layout и устанавливает свойство
     `translatesAutoresizingMaskIntoConstraints` каждого подпредставления в `false`, чтобы избежать
     конфликтов с маской авторасширения.
     */
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }
}
