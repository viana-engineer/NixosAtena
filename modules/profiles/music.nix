{ config, lib, pkgs, ... }:

{
  # ============================================================
  # PERFIL: PRODUÇÃO MUSICAL
  # ============================================================
  #
  # Objetivo:
  # Ambiente para criação, produção, edição e mixagem de
  # música eletrônica utilizando prioritariamente software
  # livre e open-source.
  #
  # Principais componentes:
  #   - PipeWire: servidor de áudio
  #   - JACK: compatibilidade para aplicações profissionais
  #   - LMMS: composição e produção musical
  #   - Ardour: gravação, edição e mixagem
  #   - Carla: host/roteamento de plugins
  #   - Hydrogen: bateria/sequenciamento
  #   - ZynAddSubFX: sintetizador
  #   - LSP Plugins / Calf: efeitos e processamento
  #
  # ============================================================


  # ============================================================
  # SOM
  # ============================================================

  services.pipewire = {
    enable = true;

    # ALSA
    # ----------------------------------------------------------
    # Interface de áudio de baixo nível utilizada pelo Linux.
    # Permite que aplicações que utilizam ALSA funcionem
    # através do PipeWire.
    alsa.enable = true;

    # Compatibilidade com aplicações que ainda utilizam
    # PulseAudio.
    pulse.enable = true;

    # JACK
    # ----------------------------------------------------------
    # Ativa a interface JACK fornecida pelo PipeWire.
    #
    # Importante para DAWs e aplicações de produção musical
    # que utilizam JACK para áudio de baixa latência e
    # roteamento entre aplicações.
    jack.enable = true;
  };


  # ============================================================
  # REALTIME / BAIXA LATÊNCIA
  # ============================================================

  # Permite que o PipeWire utilize o escalonador realtime.
  #
  # Isso é importante para produção musical, principalmente
  # quando trabalhamos com buffers pequenos e instrumentos
  # virtuais em tempo real.
  #
  # Não vamos forçar ainda um quantum extremamente baixo.
  # Primeiro testamos a estabilidade do hardware.
  security.rtkit.enable = true;


  # ============================================================
  # SOFTWARE
  # ============================================================

  environment.systemPackages = with pkgs; [

    # ----------------------------------------------------------
    # DAWs
    # ----------------------------------------------------------

    # Ardour
    # Gravação, edição, mixagem e produção.
    ardour


    # ----------------------------------------------------------
    # ROTEAMENTO / PLUGIN HOST
    # ----------------------------------------------------------

    # Carla
    # Host de plugins e patchbay para conectar instrumentos,
    # efeitos e aplicações através do JACK/PipeWire.
    carla

    # qpwgraph
    # Interface gráfica para visualizar e conectar os nós
    # do PipeWire.
    qpwgraph


    # ----------------------------------------------------------
    # SINTETIZADORES
    # ----------------------------------------------------------

    # Sintetizador baseado em síntese aditiva, subtrativa,
    # pad e outros métodos.
    zynaddsubfx


    # ----------------------------------------------------------
    # BATERIA / DRUM MACHINE
    # ----------------------------------------------------------

    # Sequenciador e drum machine.
    hydrogen


    # ----------------------------------------------------------
    # EFEITOS / PLUGINS
    # ----------------------------------------------------------

    # Coleção de plugins para processamento de áudio:
    # EQ, compressor, limiter, reverb, delay, analisadores etc.
    lsp-plugins

    # Coleção de instrumentos e efeitos para produção musical.
    calf


    # ----------------------------------------------------------
    # CONTROLE DE ÁUDIO
    # ----------------------------------------------------------

    # Mixer/controle de dispositivos compatível com
    # PulseAudio/PipeWire.
    pavucontrol

    # Alternativa nativa para controle do PipeWire.
    pwvucontrol
  ];
}