package kha.unity;

import kha.graphics4.BlendingOperation;
import kha.graphics4.CompareMode;
import kha.graphics4.ConstantLocation;
import kha.graphics4.CubeMap;
import kha.graphics4.CullMode;
import kha.graphics4.IndexBuffer;
import kha.graphics4.MipMapFilter;
import kha.graphics4.Program;
import kha.graphics4.StencilAction;
import kha.graphics4.TextureAddressing;
import kha.graphics4.TextureFilter;
import kha.graphics4.TextureFormat;
import kha.graphics4.TextureUnit;
import kha.graphics4.Usage;
import kha.graphics4.VertexBuffer;
import kha.math.Matrix4;
import kha.math.Vector2;
import kha.math.Vector3;
import kha.math.Vector4;
import unityEngine.Matrix4x4;

class Graphics implements kha.graphics4.Graphics {
	private var vertexBuffer: VertexBuffer;
	private var indexBuffer: IndexBuffer;
	private var program: Program;
	
	public function new() {
		
	}
	
	public function begin(): Void {
		
	}
	
	public function end(): Void {
		
	}
	
	public function vsynced(): Bool {
		return true;
	}
	
	public function refreshRate(): Int {
		return 60;
	}
	
	public function clear(?color: Color, ?depth: Float, ?stencil: Int): Void {
		
	}
	
	public function setCullMode(mode: CullMode): Void {
		
	}
	
	public function setDepthMode(write: Bool, mode: CompareMode): Void {
		
	}
	
	public function setBlendingMode(source: BlendingOperation, destination: BlendingOperation): Void {
		
	}
	
	public function setStencilParameters(compareMode: CompareMode, bothPass: StencilAction, depthFail: StencilAction, stencilFail: StencilAction, referenceValue: Int, readMask: Int = 0xff, writeMask: Int = 0xff): Void {
		
	}
	
	public function setScissor(rect: Rectangle): Void {
		
	}
	
	public function setVertexBuffer(vertexBuffer: VertexBuffer): Void {
		this.vertexBuffer = vertexBuffer;
	}
	
	public function setIndexBuffer(indexBuffer: IndexBuffer): Void {
		this.indexBuffer = indexBuffer;
	}
	
	public function setTexture(unit: TextureUnit, texture: Image): Void {
		if (texture == null) return;
		program.fragmentShader.material.SetTexture("_" + cast(unit, kha.unity.TextureUnit).name, texture.texture);
	}
	
	public function setTextureParameters(texunit: TextureUnit, uAddressing: TextureAddressing, vAddressing: TextureAddressing, minificationFilter: TextureFilter, magnificationFilter: TextureFilter, mipmapFilter: MipMapFilter): Void {
		
	}
	
	public function createCubeMap(size: Int, format: TextureFormat, usage: Usage, canRead: Bool = false): CubeMap {
		return null;
	}
	
	public function renderTargetsInvertedY(): Bool {
		return false;
	}
	
	public function setProgram(program: Program): Void {
		this.program = program;
	}
	
	public function setBool(location: ConstantLocation, value: Bool): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetInt(loc.name, value ? 1 : 0);
	}
	
	public function setInt(location: ConstantLocation, value: Int): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetInt(loc.name, value);
	}
	
	public function setFloat(location: ConstantLocation, value: Float): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetFloat(loc.name, value);
	}
	
	public function setFloat2(location: ConstantLocation, value1: Float, value2: Float): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetVector(loc.name, new unityEngine.Vector4(value1, value2, 0.0, 1.0));
	}
	
	public function setFloat3(location: ConstantLocation, value1: Float, value2: Float, value3: Float): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetVector(loc.name, new unityEngine.Vector4(value1, value2, value3, 1.0));
	}
	
	public function setFloat4(location: ConstantLocation, value1: Float, value2: Float, value3: Float, value4: Float): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetVector(loc.name, new unityEngine.Vector4(value1, value2, value3, value4));
	}
	
	public function setFloats(location: ConstantLocation, floats: Array<Float>): Void {
		
	}
	
	public function setVector2(location: ConstantLocation, value: Vector2): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetVector(loc.name, new unityEngine.Vector4(value.x, value.y, 0.0, 1.0));
	}
	
	public function setVector3(location: ConstantLocation, value: Vector3): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetVector(loc.name, new unityEngine.Vector4(value.x, value.y, value.z, 1.0));
	}
	
	public function setVector4(location: ConstantLocation, value: Vector4): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		program.fragmentShader.material.SetVector(loc.name, new unityEngine.Vector4(value.x, value.y, value.z, value.w));
	}
	
	public function setMatrix(location: ConstantLocation, value: Matrix4): Void {
		var loc = cast(location, kha.unity.ConstantLocation);
		var m = unityEngine.Matrix4x4.zero;
		//value = value.transpose();
		for (i in 0...4) {
			m.SetRow(i, new unityEngine.Vector4(value.get(0, i), value.get(1, i), value.get(2, i), value.get(3, i)));
		}
		program.fragmentShader.material.SetMatrix("_" + loc.name, m);
	}
	
	public function drawIndexedVertices(start: Int = 0, count: Int = -1): Void {
		vertexBuffer.mesh.triangles = indexBuffer.nativeIndices;
		for (i in 0...program.fragmentShader.material.passCount) {
			program.fragmentShader.material.SetPass(i);
			unityEngine.Graphics.DrawMeshNow(vertexBuffer.mesh, Matrix4x4.identity);
		}
	}
}
