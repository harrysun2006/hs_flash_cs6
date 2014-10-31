package 
{
	import flash.display.MovieClip;
	import fl.events.ComponentEvent;
	import fl.events.SliderEvent;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	
	public class Main extends MovieClip
	{
		var originalMatrix:Matrix;
		
		public function Main():void
		{
			btnLine.addEventListener(ComponentEvent.BUTTON_DOWN, drawLine);
			btnCurve.addEventListener(ComponentEvent.BUTTON_DOWN, drawCurve);
			btnRectangle.addEventListener(ComponentEvent.BUTTON_DOWN, drawRectangle);
			btnCircle.addEventListener(ComponentEvent.BUTTON_DOWN, drawCircle);
			btnEllipse.addEventListener(ComponentEvent.BUTTON_DOWN, drawEllipse);
			btnLiner.addEventListener(ComponentEvent.BUTTON_DOWN, drawLinerGradient);
			btnRadial.addEventListener(ComponentEvent.BUTTON_DOWN, drawRadialGradient);
			btnClear.addEventListener(ComponentEvent.BUTTON_DOWN, clearGraphics);
			
			sliderScaleX.addEventListener(SliderEvent.THUMB_DRAG, scaleXHandler);
			sliderScaleY.addEventListener(SliderEvent.THUMB_DRAG, scaleYHandler);
			sliderRotate.addEventListener(SliderEvent.THUMB_DRAG, rotateHandler);
			btnMatrix.addEventListener(ComponentEvent.BUTTON_DOWN, matrixHandler);
			btnClearMatrix.addEventListener(ComponentEvent.BUTTON_DOWN, clearMatrixHandler);
			
			// 保存 canvas 的初始仿射矩阵转换
			originalMatrix = canvas.transform.matrix;
		}
		
		
		// 画直线
		function drawLine(e:ComponentEvent):void 
		{
			// lineStyle() - 定义画图的线条样式
			//     第一个参数：线条粗细，整数（0 - 255）
			//     第二个参数：线条的颜色值（16进制）
			//     第三个参数：不透明度（0 - 1）
			canvas.graphics.lineStyle(12, 0x000000);
			
			// moveTo() - 设置当前绘画点。在本例中就是直线的起点
			canvas.graphics.moveTo(0, 0);
			
			// lineTo() - 以当前绘画点为起点，用当前定义的线条样式，画一条直线到目标点
			canvas.graphics.lineTo(100, 100);
		}
		
		// 画曲线（二次贝塞尔曲线）
		function drawCurve(e:ComponentEvent):void 
		{
			canvas.graphics.lineStyle(1, 0x000000);
			canvas.graphics.moveTo(100, 0);
			
			// curveTo() - 指定二次贝塞尔曲线的控制点和终点，从而完成曲线的绘制
			//     前两个参数为控制点，后两个参数为终点，当前绘画点为起点
			canvas.graphics.curveTo(100, 100, 200, 200);
		}
		
		// 画矩形
		function drawRectangle(e:ComponentEvent):void 
		{
			canvas.graphics.lineStyle(5, 0xFF0000);
			
			// drawRect() - 绘制矩形
			//     第一个参数：矩形左上角的 x 坐标
			//     第二个参数：矩形左上角的 y 坐标
			//     第三个参数：矩形的宽
			//     第四个参数：矩形的高
			canvas.graphics.drawRect(200, 0, 100, 50);
		}
		
		// 画圆
		function drawCircle(e:ComponentEvent):void 
		{
			canvas.graphics.lineStyle(1, 0x000000);
			
			// beginFill() - 单色填充这之后所绘制的图形，直到调用endFill()为止
			//     两个参数分别为填充的颜色值和不透明度
			canvas.graphics.beginFill(0xFF0000, 0.5);
			
			// drawCircle() - 绘制圆形
			//     三个参数分别为圆心的 x 坐标，圆心的 y 坐标，圆形的半径
			canvas.graphics.drawCircle(300, 0, 30);
			
			// endFill() - 呈现 beginFill() 与 endFill() 之间所绘制的图形的填充效果
			canvas.graphics.endFill();
		}	
		
		// 画椭圆
		function drawEllipse(e:ComponentEvent):void 
		{
			canvas.graphics.lineStyle(1, 0x000000);
			canvas.graphics.beginFill(0xFF0000);
			
			// drawEllipse() - 绘制椭圆
			//     前两个参数：椭圆左侧顶点的 x 坐标和 y 坐标
			//     后两个参数：椭圆的宽和高
			canvas.graphics.drawEllipse(0, 200, 100, 50);
			
			canvas.graphics.endFill();
		}
		
		// 线性渐变填充
		function drawLinerGradient(e:ComponentEvent):void 
		{
			canvas.graphics.lineStyle(1, 0x000000);
			
			// 声明一个仿射矩阵 Matrix
			var gradientBoxMatrix:Matrix = new Matrix();
			
			// createGradientBox() - Matrix 的一个专门为渐变填充提供的方法
			//     三个参数分别为渐变框的宽，渐变框的高，渐变框的旋转弧度
			gradientBoxMatrix.createGradientBox(50, 20, 0);
			
			// beginGradientFill() - 做渐变填充
			//     第一个参数：渐变模式。GradientType.LINEAR为线性渐变；GradientType.RADIAL为放射性渐变
			//     第二个参数：渐变色的颜色值数组
			//     第三个参数：渐变色的不透明度数组
			//     第四个参数：渐变色的分布比例数组（0 - 255）。0为渐变框的最左侧，255为渐变框的最右侧
			//     第五个参数：用 Matrix.createGradientBox() 生成的渐变框
			//     第六个参数：伸展方式 
			//         SpreadMethod.PAD - 用线性渐变线末端的颜色值填充剩余空间
			//         SpreadMethod.REFLECT - 相邻填充区域，以 相反方向 重复渐变，直至填充满整个剩余空间
			//         SpreadMethod.REPEAT - 相邻填充区域，以 相同方向 重复渐变，直至填充满整个剩余空间
			canvas.graphics.beginGradientFill(GradientType.LINEAR, [0xFF0000, 0x0000FF], [1, 1], [0, 255], gradientBoxMatrix, SpreadMethod.REPEAT);
			
			canvas.graphics.drawRect(100, 200, 100, 20);
			canvas.graphics.endFill();
		}
		
		// 放射性渐变填充
		function drawRadialGradient(e:ComponentEvent):void
		{		
			canvas.graphics.lineStyle(1, 0x000000);
			var gradientBoxMatrix:Matrix = new Matrix();
			gradientBoxMatrix.createGradientBox(50, 20, 0);
			
			// GradientType.RADIAL - 放射性渐变
			canvas.graphics.beginGradientFill(GradientType.RADIAL, [0xFF0000, 0x0000FF], [1, 1], [0, 255], gradientBoxMatrix, SpreadMethod.REFLECT);
			
			canvas.graphics.drawCircle(200, 200, 30);
			canvas.graphics.endFill();
		}
		
		// 清除图形
		function clearGraphics(e:ComponentEvent):void
		{	
			// clear() - 清除 Graphics 上的图形，并重置线条样式和填充等设置
			canvas.graphics.clear();
		}
		
		
		// 在 x 轴方向上做缩放
		function scaleXHandler(e:SliderEvent):void
		{
			// scaleX - x轴方向上的缩放比例
			canvas.scaleX = e.value;
		}
		
		// 在 y 轴方向上做缩放
		function scaleYHandler(e:SliderEvent):void
		{
			// scaleY - y轴方向上的缩放比例
			canvas.scaleY = e.value;
		}
		
		// 旋转
		function rotateHandler(e:SliderEvent):void
		{
			// rotation - 旋转的度数
			canvas.rotation = e.value;
		}
		
		
		// 仿射矩阵在图形转换上的应用
		function matrixHandler(e:ComponentEvent):void
		{
			var matrix:Matrix = new Matrix();

			// rotate() - 旋转的角度
			matrix.rotate(10);
			
			// translate() - 平移的距离
			matrix.translate(200, 200);
			
			// scale() - 缩放的比例
			matrix.scale(1.2, 1.2);
			
			var skewMatrix:Matrix = new Matrix();
			// 调整 b 属性将矩阵垂直倾斜
			// 调整 c 属性将矩阵水平倾斜
			skewMatrix.b = Math.tan(0.78); 
			
			// concat() - 组合两个仿射矩阵
			matrix.concat(skewMatrix);

			// 在对象上应用仿射矩阵转换
			canvas.transform.matrix = matrix;
		}
		
		// 还原为初始的仿射矩阵转换
		function clearMatrixHandler(e:ComponentEvent):void
		{
			// 设置 canvas 的仿射矩阵转换为初始的仿射矩阵
			canvas.transform.matrix = originalMatrix;
		}
	}
}