object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 477
  ClientWidth = 1110
  Color = clNone
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyUp = FormKeyUp
  OnPaint = FormPaint
  TextHeight = 15
  object LabelGameOver: TLabel
    Left = 136
    Top = 88
    Width = 250
    Height = 65
    Alignment = taCenter
    Caption = 'Game Over'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -48
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = False
    Visible = False
  end
  object BtnReintentar: TLabel
    Left = 104
    Top = 176
    Width = 169
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = 'REINTENTAR'
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    Visible = False
    OnClick = BtnReintentarClick
  end
  object BtnRendirse: TLabel
    Left = 296
    Top = 176
    Width = 145
    Height = 41
    Alignment = taCenter
    AutoSize = False
    Caption = 'RENDIRSE'
    Color = clGray
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    Visible = False
    OnClick = BtnRendirseClick
  end
  object TimerBala: TTimer
    Interval = 10
    OnTimer = TimerBalaTimer
    Left = 464
    Top = 184
  end
  object TimerNave: TTimer
    Interval = 10
    OnTimer = TimerNaveTimer
    Left = 528
    Top = 200
  end
  object TimerAsteroid: TTimer
    Interval = 10
    OnTimer = TimerAsteroidTimer
    Left = 640
    Top = 232
  end
end
