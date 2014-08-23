package UILogic
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	import MoGui.display.CMoveSprite;
	import MoGui.display.CRoundRect;
	
	public class PokerPai extends CMoveSprite
	{
		public static var s_FanPaiparam:Number                 = 0.2;
		public static var TablePai:int                         = 10;
		
		private var m_nPai:int;
		private var m_desPai:int;
		private var m_spPai:Sprite;
		private var m_spMask:CRoundRect;
		private var m_bMask:Boolean;
		
		private var m_Width:int;
		private var m_Height:int;
		
		private var m_TotalFanPaiFrame:int;
		private var m_CurFanPaiFrame:int;
		private var m_OrgMatrix:Matrix;                      //变换前的MATRIX
		
		public var m_SitID:int;                              //牌的位置，0-8是玩家的牌 10是桌面上的牌
		public var m_Idx:int;                                //牌的序号从1开始
		
		public function PokerPai(w:int,h:int)
		{
			super();
			
			m_nPai = 0;
			m_desPai = 0;
			m_spPai = null;
			
			m_Width = w;
			m_Height = h;
			
			m_spMask = new CRoundRect();
			m_spMask.Draw(0xffff00,m_Width,m_Height,3,3);
			addChild(m_spMask);
			m_bMask = false;
			m_spMask.visible = false;
			m_spMask.alpha = 0.3;
			m_spMask.x = -m_Width/2;
			m_spMask.y = -m_Height/2;			
			
			m_funcEnterFrame = OnEnterPaiFrame;
			
			m_TotalFanPaiFrame = 0;
			m_CurFanPaiFrame = 0;
			m_OrgMatrix = new Matrix();
		}
		public function SetMask(bMask:Boolean):void
		{
			m_bMask = bMask;
			m_spMask.visible = bMask;
		}
		
		public function SetPai(nPai:int):void
		{
			if( nPai == 0 )
			{
				this.visible = false;
			}
			else if( nPai>0 && nPai<=55 && nPai!=53 && nPai!=54 )
			{
				if(nPai == m_nPai)
				{
					return ;
				}
				
				m_nPai = nPai;
				
				if( m_spPai != null )
				{
					this.removeChild(m_spPai);
					m_spPai = null;
				}
				
				var TempClass:Class = GlobleData.S_MapPaiClass.get(nPai);
				m_spPai = new TempClass();
				addChildAt(m_spPai,0);				
				m_spPai.width = m_Width;
				m_spPai.height = m_Height;
				
				m_OrgMatrix = m_spPai.transform.matrix;
				this.visible = true;
			}
			else
			{
				GlobleFunc.LogError("PokerPai SetPai nPai="+nPai);
			}
		}
		
		public function FanPaiByTime(desPai:int,nTime:Number):void
		{
			if( desPai>0 && desPai<=55 )
			{
				SetMask(false);
				m_desPai = desPai;
				
				m_TotalFanPaiFrame = this.stage.frameRate * nTime;
				m_TotalFanPaiFrame = int(m_TotalFanPaiFrame / 2) * 2;
				if ( m_TotalFanPaiFrame < 10 )
				{
					m_TotalFanPaiFrame = 10;
				}
				
				m_CurFanPaiFrame = m_TotalFanPaiFrame - 1;
			}
		}
		public function EndFanPai():void
		{
			if( m_TotalFanPaiFrame > 0 )
			{
				m_TotalFanPaiFrame = 0;
				m_CurFanPaiFrame = 0;
				
				SetPai(m_desPai);
				
				OnEndFanPai(false);
			}
		}		
		public function OnEndFanPai(bAuto:Boolean):void
		{
			if( bAuto )
			{
				if( stage != null )
				{
//					var evtS2C:StageToClient = new StageToClient();
//					var msgFP:S2C_FanPai = new S2C_FanPai();
//					msgFP.m_SitID    = m_SitID;
//					msgFP.m_Idx      = m_Idx;
//					msgFP.Write(evtS2C.m_msgData);
//					evtS2C.m_msgData.ResetDataPosition();
//					stage.dispatchEvent(evtS2C);
				}
			}
		}
		
		public function OnFanPaiFrame():void
		{
			if( m_TotalFanPaiFrame > 0 )
			{
				var oldMatrix:Matrix = m_OrgMatrix.clone();	
				var a:Number, b:Number, c:Number, d:Number;
				var jiaodu:Number;
				var tempMatrix:Matrix;
				
				if ( m_CurFanPaiFrame >= 0 &&  m_CurFanPaiFrame < m_TotalFanPaiFrame)
				{
					if ( m_CurFanPaiFrame == m_TotalFanPaiFrame / 2 )
					{
						SetPai(m_desPai);
					}
					
					jiaodu = Math.acos(((m_CurFanPaiFrame - m_TotalFanPaiFrame / 2) / (1.0 * m_TotalFanPaiFrame / 2)));
					
					a = Math.abs(Math.cos(jiaodu));
					b = -Math.sin(jiaodu)*s_FanPaiparam;
					if ( m_CurFanPaiFrame <= m_TotalFanPaiFrame / 2 )
					{
						b = Math.sin(jiaodu) * s_FanPaiparam;
					}
					c = 0;
					d = 1;
					
					tempMatrix = new Matrix(a, b, c, d);
					tempMatrix.concat(oldMatrix);
					
					m_spPai.transform.matrix = tempMatrix;
					
					//m_spPai.x = (1 - a) * m_Width / 2;
					if ( m_CurFanPaiFrame <= m_TotalFanPaiFrame / 2 )
					{
						m_spPai.y = -b * m_Height/2;
					}
				}
				
				m_CurFanPaiFrame--;
				if ( m_CurFanPaiFrame < 0 )
				{
					m_TotalFanPaiFrame = 0;
					OnEndFanPai(true);
				}
			}
		}
		
		public function OnEnterPaiFrame():void
		{
			OnMoveFrame();
			OnFanPaiFrame();
		}
	}
}