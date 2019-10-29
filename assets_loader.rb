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
    sounds = {
        intro_cover: Gosu::Song.new('intro_1.mp3'),
        intro: Gosu::Song.new('intro.mp3'),
        enter: Gosu::Sample.new('game.mp3'),
        empty_choose: Gosu::Sample.new('choose.mp3'),
        choose: Gosu::Sample.new('coin.mp3'),
        comp_choose: Gosu::Sample.new('comp_choose.mp3'),
    }
    
    return xs, os, img, sounds
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
    square_coord = {
            a1: [208..350, 117..275],
            a2: [378..540, 117..275],
            a3: [561..699, 117..275],
            b1: [208..350, 280..421],
            b2: [378..540, 280..421],
            b3: [561..699, 280..421],
            c1: [208..350, 431..575],
            c2: [378..540, 431..575],
            c3: [561..699, 431..575]
            }
    
    return key, board, square_coord
end

def winning_combo(dic)
    return [true,1] if dic[:a1][0] == true and dic[:a2][0] == true and dic[:a3][0] == true
    return [true,2] if dic[:b1][0] == true and dic[:b2][0] == true and dic[:b3][0] == true
    return [true,3] if dic[:c1][0] == true and dic[:c2][0] == true and dic[:c3][0] == true
    return [true,4] if dic[:a1][0] == true and dic[:b2][0] == true and dic[:c3][0] == true
    return [true,5] if dic[:c1][0] == true and dic[:b2][0] == true and dic[:a3][0] == true
    return ['o',6]  if dic[:a1][0] == 'o' and dic[:a2][0] == 'o' and dic[:a3][0] == 'o'
    return ['o',7]  if dic[:b1][0] == 'o' and dic[:b2][0] == 'o' and dic[:b3][0] == 'o'
    return ['o',8]  if dic[:c1][0] == 'o' and dic[:c2][0] == 'o' and dic[:c3][0] == 'o'
    return ['o',9]  if dic[:a1][0] == 'o' and dic[:b2][0] == 'o' and dic[:c3][0] == 'o'
    return ['o',10] if dic[:c1][0] == 'o' and dic[:b2][0] == 'o' and dic[:a3][0] == 'o'
    false
end