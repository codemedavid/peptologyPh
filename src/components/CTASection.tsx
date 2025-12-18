import React from 'react';
import { ArrowRight } from 'lucide-react';

const CTASection: React.FC = () => {
    return (
        <section className="py-24 bg-theme-navy relative overflow-hidden">
            {/* Background Accents */}
            <div className="absolute top-0 right-0 w-96 h-96 bg-theme-blue/10 rounded-full blur-3xl -mr-20 -mt-20 pointer-events-none"></div>
            <div className="absolute bottom-0 left-0 w-72 h-72 bg-theme-lightblue/5 rounded-full blur-3xl -ml-10 -mb-10 pointer-events-none"></div>

            <div className="container mx-auto px-4 relative z-10 text-center">
                <h2 className="text-3xl md:text-5xl font-bold text-white mb-6">
                    Ready to begin your renewal journey?
                </h2>
                <p className="text-lg text-theme-lightblue/80 mb-10 max-w-2xl mx-auto">
                    Join thousands of others optimizing their health with research-backed peptide solutions.
                </p>
                <button
                    className="inline-flex items-center gap-2 bg-theme-blue text-white hover:bg-theme-blue/90 px-8 py-4 rounded-full text-lg font-semibold transition-all shadow-lg shadow-theme-blue/20 hover:shadow-theme-blue/40"
                    onClick={() => document.getElementById('product-section')?.scrollIntoView({ behavior: 'smooth' })}
                >
                    Start Your Journey
                    <ArrowRight className="w-5 h-5" />
                </button>
            </div>
        </section>
    );
};

export default CTASection;
