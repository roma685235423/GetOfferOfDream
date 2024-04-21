import Foundation

public final class GetOfferUI {

    /**
     Рассчитывает равную ширину для указанной ширины представления, количества элементов и промежутка между ними.

     - Parameters:
     - viewWidth: Ширина представления, где будут расположены элементы.
     - numberOfElements: Общее количество элементов.
     - spacing: Расстояние между элементами. По умолчанию равно Constansts.horizontalIndent.

     - Returns: Рассчитанная равная ширина для каждого элемента.
     */
    static public func calculateEqualWidth(forViewWidth viewWidth: CGFloat,
                                           numberOfElements: Int,
                                           withSpacing spacing: CGFloat = Constants.horizontalIndent) -> CGFloat {
        guard numberOfElements > 0 else { return 0 }

        let totalSpaceing = CGFloat(numberOfElements + 1) * spacing
        let avaliableWidth = viewWidth - totalSpaceing

        return avaliableWidth / CGFloat(numberOfElements)
    }
}
