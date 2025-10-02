#include <DRingBuf.hh>

namespace dkdsp {
    class Delay {
    public:
        Delay() {}
        void reinit (int channels, int sample_rate) {
            delay_lines.erase(delay_lines.begin(),delay_lines.end());
            for (int i = 0; i < channels; ++i ) {
                delay_lines.push_back(DRingBuf<float>(sample_rate));
                delay_lines[i].push(0.0);
            }
        }
        float process_sample (float sample, float feedback, int channel) {
            float output_sample = 0.0;
            if (delay_lines[channel].is_full()) {
                output_sample = feedback * delay_lines[channel].get(delay_lines[channel].size() - 8820);
                delay_lines[channel].pop();
            }
            delay_lines[channel].push(sample + output_sample);
            return output_sample;
        }
    private:
        std::vector<DRingBuf<float>> delay_lines;
    };
}
