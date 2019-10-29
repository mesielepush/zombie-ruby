def load_audiovisual
    xs = []
    xs << Gosu::Image.new("4.png")
    xs << Gosu::Image.new("5.png")
    xs << Gosu::Image.new("6.png")
    os = []
    os << Gosu::Image.new("1.png")
    os << Gosu::Image.new("2.png")
    os << Gosu::Image.new("3.png")
    img = {
        background: Gosu::Image.new("back.png"),
        title: Gosu::Image.new("title.png"),
        bestes: Gosu::Image.new("bestes.png"),
        back_board: Gosu::Image.new('back_game.png'),
        cursor: Gosu::Image.new('cursor.png'),
        cursor_down: Gosu::Image.new('cursor_down.png')
    }    
    return xs, os, img
end

def load_metadata
    key =  {kb_left: Gosu::KbLeft,
            kb_right: Gosu::KbRight,
            gp_left: Gosu::GpLeft,
            gp_right: Gosu::GpRight,
            enter: Gosu::KB_RETURN,
            space: Gosu::KB_SPACE,
            m_left: Gosu::MS_LEFT,
            m_right: Gosu::MS_RIGHT
            }
    board = {
                a1: [false, nil, nil],
                a2: [false, nil, nil],
                a3: [false, nil, nil],
                b1: [false, nil, nil],
                b2: [false, nil, nil],
                b3: [false, nil, nil],
                c1: [false, nil, nil],
                c2: [false, nil, nil],
                c3: [false, nil, nil],
            }
    return key, board
    end
    