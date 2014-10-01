/*

    LiCK  Library for ChucK.
    Copyright (c) 2007-2014 held jointly by the individual authors.

    This file is part of LiCK.

    LiCK is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    LiCK is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with LiCK.  If not, see <http://www.gnu.org/licenses/>.

*/

public class Lfo extends Chugen
{
    SawOsc _sawLfo;
    SinOsc _sinLfo;
    SqrOsc _sqrLfo;
    TriOsc _triLfo;
    0.0 => float _sawMix;
    1.0 => float _sinMix;
    0.0 => float _sqrMix;
    0.0 => float _triMix;
    1.0 => float _rate;
    1.0 => float _depth;
    1.0 => float _phase;

    {
        _sawLfo => blackhole;
        _sinLfo => blackhole;
        _sqrLfo => blackhole;
        _triLfo => blackhole;

        rate(_rate);
        depth(_depth);
        phase(_phase);
    }

    fun float rate()
    {
        return _rate;
    }

    fun float rate(float f)
    {
        f => _rate;
        _rate => _sawLfo.freq;
        _rate => _sinLfo.freq;
        _rate => _sqrLfo.freq;
        _rate => _triLfo.freq;
        return _rate;
    }

    fun float depth()
    {
        return _depth;
    }

    fun float depth(float f)
    {
        f => _depth;
        _depth => _sawLfo.gain;
        _depth => _sinLfo.gain;
        _depth => _sqrLfo.gain;
        _depth => _triLfo.gain;
        return _depth;
    }

    fun float phase()
    {
        return _phase;
    }

    fun float phase(float f)
    {
        f => _phase;
        _phase => _sawLfo.phase;
        _phase => _sinLfo.phase;
        _phase => _sqrLfo.phase;
        _phase => _triLfo.phase;
        return f;
    }

    fun void saw()
    {
        mix(1.0, 0.0, 0.0, 0.0);
    }

    fun float sawMix()
    {
        return _sawMix;
    }

    fun void sin()
    {
        mix(0.0, 1.0, 0.0, 0.0);
    }

    fun float sinMix()
    {
        return _sinMix;
    }

    fun void sqr()
    {
        mix(0.0, 0.0, 1.0, 0.0);
    }

    fun float sqrMix()
    {
        return _sqrMix;
    }

    fun void tri()
    {
        mix(0.0, 0.0, 0.0, 1.0);
    }

    fun float triMix()
    {
        return _triMix;
    }

    fun void mix(float saw, float sin, float sqr, float tri)
    {
        if (saw + sin + sqr + tri > 1.0)
        {
            <<<"mix must not exceed 1.0">>>;
        }
        else
        {
            saw => _sawMix;
            sin => _sinMix;
            sqr => _sqrMix;
            tri => _triMix;
        }
    }

    fun float tick(float in)
    {
        return _sawLfo.last() * _sawMix + _sinLfo.last() * _sinMix + _sqrLfo.last() * _sqrMix + _triLfo.last() * _triMix;
    }
}