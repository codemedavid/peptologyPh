import React, { useState, useEffect } from 'react';
import { Plus, Edit, Trash2, Save, ArrowLeft, Tag, Percent, DollarSign } from 'lucide-react';
import { supabase } from '../lib/supabase';
import type { PromoCode } from '../types';

interface PromoManagerProps {
    onBack: () => void;
}

const PromoManager: React.FC<PromoManagerProps> = ({ onBack }) => {
    const [promos, setPromos] = useState<PromoCode[]>([]);
    const [loading, setLoading] = useState(true);
    const [currentView, setCurrentView] = useState<'list' | 'add' | 'edit'>('list');
    const [editingId, setEditingId] = useState<string | null>(null);
    const [isProcessing, setIsProcessing] = useState(false);

    // Form State
    const [formData, setFormData] = useState<any>({
        code: '',
        description: '',
        discount_type: 'fixed',
        discount_value: '',
        min_spend: '',
        usage_limit: '',
        is_active: true
    });

    useEffect(() => {
        fetchPromos();
    }, []);

    const fetchPromos = async () => {
        try {
            setLoading(true);
            const { data, error } = await supabase
                .from('promo_codes')
                .select('*')
                .order('created_at', { ascending: false });

            if (error) throw error;
            setPromos(data || []);
        } catch (error) {
            console.error('Error fetching promos:', error);
            alert('Failed to load promo codes');
        } finally {
            setLoading(false);
        }
    };

    const handleAddClick = () => {
        setFormData({
            code: '',
            description: '',
            discount_type: 'fixed',
            discount_value: '',
            min_spend: '',
            usage_limit: '',
            is_active: true
        });
        setEditingId(null);
        setCurrentView('add');
    };

    const handleEditClick = (promo: PromoCode) => {
        setFormData({
            code: promo.code,
            description: promo.description,
            discount_type: promo.discount_type,
            discount_value: promo.discount_value,
            min_spend: promo.min_spend,
            usage_limit: promo.usage_limit,
            is_active: promo.is_active
        });
        setEditingId(promo.id);
        setCurrentView('edit');
    };

    const handleDelete = async (id: string) => {
        if (!confirm('Are you sure you want to delete this promo code? This cannot be undone.')) return;

        try {
            setIsProcessing(true);
            const { error } = await supabase.from('promo_codes').delete().eq('id', id);
            if (error) throw error;

            setPromos(promos.filter(p => p.id !== id));
            // alert('Promo code deleted successfully');
        } catch (error) {
            console.error('Error deleting promo:', error);
            alert('Failed to delete promo code');
        } finally {
            setIsProcessing(false);
        }
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();

        if (!formData.code || Number(formData.discount_value) < 0) {
            alert('Please fill in all required fields correctly.');
            return;
        }

        try {
            setIsProcessing(true);
            const payload = {
                code: formData.code.toUpperCase(),
                description: formData.description,
                discount_type: formData.discount_type,
                discount_value: Number(formData.discount_value),
                min_spend: Number(formData.min_spend) || 0,
                usage_limit: formData.usage_limit ? Number(formData.usage_limit) : null,
                is_active: formData.is_active
            };

            if (editingId) {
                const { data, error } = await supabase
                    .from('promo_codes')
                    .update(payload)
                    .eq('id', editingId)
                    .select()
                    .single();

                if (error) throw error;
                setPromos(promos.map(p => p.id === editingId ? data : p));
            } else {
                const { data, error } = await supabase
                    .from('promo_codes')
                    .insert([payload])
                    .select()
                    .single();

                if (error) throw error;
                setPromos([data, ...promos]);
            }

            setCurrentView('list');
        } catch (error: any) {
            console.error('Error saving promo:', error);
            alert(`Failed to save promo code: ${error.message || 'Unknown error'}`);
        } finally {
            setIsProcessing(false);
        }
    };

    if (loading) {
        return <div className="p-8 text-center text-gray-500">Loading promo codes...</div>;
    }

    // Form View
    if (currentView === 'add' || currentView === 'edit') {
        return (
            <div className="max-w-3xl mx-auto px-4 py-8">
                <div className="flex items-center justify-between mb-6">
                    <button
                        onClick={() => setCurrentView('list')}
                        className="flex items-center gap-2 text-gray-600 hover:text-theme-accent transition-colors"
                    >
                        <ArrowLeft className="w-5 h-5" />
                        <span className="hidden md:inline font-medium">Back to Promos</span>
                    </button>
                    <h1 className="text-lg md:text-xl font-bold text-theme-text">
                        {currentView === 'add' ? 'Create New Voucher' : 'Edit Voucher'}
                    </h1>
                </div>

                <div className="bg-white rounded-xl shadow-soft p-6 border border-gray-100">
                    <form onSubmit={handleSubmit} className="space-y-6">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-6">

                            {/* Code */}
                            <div className="col-span-2">
                                <label className="block text-sm font-semibold text-gray-700 mb-2">Voucher Code *</label>
                                <div className="relative">
                                    <Tag className="absolute left-3 top-1/2 -translate-y-1/2 w-5 h-5 text-gray-400" />
                                    <input
                                        type="text"
                                        value={formData.code}
                                        onChange={(e) => setFormData({ ...formData, code: e.target.value.toUpperCase() })}
                                        className="w-full pl-10 pr-4 py-3 bg-gray-50 border border-gray-200 rounded-lg focus:ring-2 focus:ring-theme-accent focus:border-theme-accent transition-colors font-mono font-bold tracking-wider"
                                        placeholder="e.g., WELCOME10"
                                        required
                                    />
                                </div>
                            </div>

                            {/* Description */}
                            <div className="col-span-2">
                                <label className="block text-sm font-semibold text-gray-700 mb-2">Description</label>
                                <input
                                    type="text"
                                    value={formData.description || ''}
                                    onChange={(e) => setFormData({ ...formData, description: e.target.value })}
                                    className="w-full px-4 py-3 bg-white border border-gray-200 rounded-lg focus:ring-2 focus:ring-theme-accent focus:border-theme-accent transition-colors"
                                    placeholder="Internal note or customer facing description"
                                />
                            </div>

                            {/* Discount Type */}
                            <div className="col-span-2 md:col-span-1">
                                <label className="block text-sm font-semibold text-gray-700 mb-2">Discount Type *</label>
                                <div className="grid grid-cols-2 gap-3">
                                    <label className={`flex items-center justify-center gap-2 p-3 rounded-lg border-2 cursor-pointer transition-all ${formData.discount_type === 'fixed'
                                        ? 'border-theme-secondary bg-theme-secondary/5 text-theme-secondary'
                                        : 'border-gray-200 hover:border-gray-300 text-gray-600'
                                        }`}>
                                        <input
                                            type="radio"
                                            name="discount_type"
                                            checked={formData.discount_type === 'fixed'}
                                            onChange={() => setFormData({ ...formData, discount_type: 'fixed' })}
                                            className="hidden"
                                        />
                                        <DollarSign className="w-4 h-4" />
                                        <span className="font-medium text-sm">Fixed</span>
                                    </label>
                                    <label className={`flex items-center justify-center gap-2 p-3 rounded-lg border-2 cursor-pointer transition-all ${formData.discount_type === 'percentage'
                                        ? 'border-theme-accent bg-theme-accent/5 text-theme-accent'
                                        : 'border-gray-200 hover:border-gray-300 text-gray-600'
                                        }`}>
                                        <input
                                            type="radio"
                                            name="discount_type"
                                            checked={formData.discount_type === 'percentage'}
                                            onChange={() => setFormData({ ...formData, discount_type: 'percentage' })}
                                            className="hidden"
                                        />
                                        <Percent className="w-4 h-4" />
                                        <span className="font-medium text-sm">Percent</span>
                                    </label>
                                </div>
                            </div>

                            {/* Discount Value */}
                            <div className="col-span-2 md:col-span-1">
                                <label className="block text-sm font-semibold text-gray-700 mb-2">
                                    {formData.discount_type === 'fixed' ? 'Amount (₱)' : 'Percentage (%)'} *
                                </label>
                                <input
                                    type="number"
                                    min="0"
                                    step={formData.discount_type === 'percentage' ? '1' : '0.01'}
                                    value={formData.discount_value}
                                    onChange={(e) => setFormData({ ...formData, discount_value: e.target.value })}
                                    className="w-full px-4 py-3 bg-white border border-gray-200 rounded-lg focus:ring-2 focus:ring-theme-accent focus:border-theme-accent transition-colors"
                                    placeholder="0"
                                    required
                                />
                            </div>

                            {/* Min Spend */}
                            <div className="col-span-2 md:col-span-1">
                                <label className="block text-sm font-semibold text-gray-700 mb-2">Minimum Spend (₱)</label>
                                <input
                                    type="number"
                                    min="0"
                                    value={formData.min_spend}
                                    onChange={(e) => setFormData({ ...formData, min_spend: e.target.value })}
                                    className="w-full px-4 py-3 bg-white border border-gray-200 rounded-lg focus:ring-2 focus:ring-theme-accent focus:border-theme-accent transition-colors"
                                    placeholder="0"
                                />
                            </div>

                            {/* Usage Limit */}
                            <div className="col-span-2 md:col-span-1">
                                <label className="block text-sm font-semibold text-gray-700 mb-2">Usage Limit (Optional)</label>
                                <input
                                    type="number"
                                    min="0"
                                    value={formData.usage_limit}
                                    onChange={(e) => setFormData({ ...formData, usage_limit: e.target.value })}
                                    className="w-full px-4 py-3 bg-white border border-gray-200 rounded-lg focus:ring-2 focus:ring-theme-accent focus:border-theme-accent transition-colors"
                                    placeholder="Unlimited if empty"
                                />
                            </div>

                            {/* Active Status */}
                            <div className="col-span-2 pt-2">
                                <label className="flex items-center gap-3 cursor-pointer">
                                    <div className={`w-12 h-6 rounded-full p-1 transition-colors ${formData.is_active ? 'bg-green-500' : 'bg-gray-300'}`}>
                                        <div className={`w-4 h-4 bg-white rounded-full shadow-sm transform transition-transform ${formData.is_active ? 'translate-x-6' : 'translate-x-0'}`} />
                                    </div>
                                    <input
                                        type="checkbox"
                                        checked={formData.is_active}
                                        onChange={(e) => setFormData({ ...formData, is_active: e.target.checked })}
                                        className="hidden"
                                    />
                                    <span className="font-medium text-gray-700">Detailed Status: {formData.is_active ? 'Active' : 'Inactive'}</span>
                                </label>
                            </div>

                        </div>

                        <div className="flex gap-4 pt-6 mt-6 border-t border-gray-100">
                            <button
                                type="button"
                                onClick={() => setCurrentView('list')}
                                className="flex-1 px-6 py-3 border border-gray-200 text-gray-700 font-medium rounded-lg hover:bg-gray-50 transition-colors"
                            >
                                Cancel
                            </button>
                            <button
                                type="submit"
                                disabled={isProcessing}
                                className="flex-1 bg-theme-accent hover:bg-theme-accent/90 text-white px-6 py-3 rounded-lg font-bold shadow-lg shadow-theme-accent/20 transition-all flex items-center justify-center gap-2 disabled:opacity-50"
                            >
                                <Save className="w-5 h-5" />
                                {isProcessing ? 'Saving...' : 'Save Voucher'}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        );
    }

    // List View
    return (
        <div className="min-h-screen bg-theme-bg">
            {/* Header */}
            <div className="bg-white shadow-sm border-b border-gray-200">
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                    <div className="flex items-center justify-between h-16 gap-2">
                        <div className="flex items-center gap-2 md:gap-4 flex-1">
                            <button
                                onClick={onBack}
                                className="text-gray-500 hover:text-theme-accent transition-colors p-2 hover:bg-gray-100 rounded-lg"
                            >
                                <ArrowLeft className="w-5 h-5" />
                            </button>
                            <div className="min-w-0">
                                <h1 className="text-lg md:text-xl font-bold text-theme-text flex items-center gap-2 truncate">
                                    <Tag className="w-4 h-4 md:w-5 md:h-5 text-theme-secondary flex-shrink-0" />
                                    Promo Vouchers
                                </h1>
                            </div>
                        </div>
                        <button
                            onClick={handleAddClick}
                            className="bg-theme-accent hover:bg-theme-accent/90 text-white px-3 md:px-4 py-2 rounded-lg font-medium shadow-sm transition-all flex items-center gap-2 whitespace-nowrap"
                        >
                            <Plus className="w-4 h-4" />
                            <span className="hidden sm:inline">Create New</span>
                            <span className="sm:hidden">New</span>
                        </button>
                    </div>
                </div>
            </div>

            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    {promos.length === 0 ? (
                        <div className="col-span-full text-center py-12 bg-white rounded-xl border border-gray-200 border-dashed">
                            <Tag className="w-12 h-12 text-gray-300 mx-auto mb-4" />
                            <h3 className="text-lg font-medium text-gray-900 mb-2">No vouchers yet</h3>
                            <p className="text-gray-500 mb-6">Create your first promo code to get started.</p>
                            <button
                                onClick={handleAddClick}
                                className="text-theme-accent hover:text-theme-accent/80 font-medium"
                            >
                                Create new voucher
                            </button>
                        </div>
                    ) : (
                        promos.map((promo) => (
                            <div key={promo.id} className="bg-white rounded-xl shadow-soft border border-gray-100 overflow-hidden group hover:shadow-medium transition-all">
                                <div className="p-5">
                                    <div className="flex justify-between items-start mb-4">
                                        <div>
                                            <div className="flex items-center gap-2 mb-1">
                                                <span className="font-mono font-bold text-lg text-theme-text bg-gray-100 px-2 py-1 rounded">
                                                    {promo.code}
                                                </span>
                                                <span className={`px-2 py-0.5 rounded-full text-xs font-semibold ${promo.is_active ? 'bg-green-100 text-green-700' : 'bg-gray-100 text-gray-500'
                                                    }`}>
                                                    {promo.is_active ? 'Active' : 'Inactive'}
                                                </span>
                                            </div>
                                            <p className="text-sm text-gray-500 line-clamp-1">{promo.description || 'No description'}</p>
                                        </div>
                                        <div className="flex gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                            <button
                                                onClick={() => handleEditClick(promo)}
                                                className="p-2 text-gray-400 hover:text-theme-accent hover:bg-gray-50 rounded-lg transition-colors"
                                            >
                                                <Edit className="w-4 h-4" />
                                            </button>
                                            <button
                                                onClick={() => handleDelete(promo.id)}
                                                className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                            >
                                                <Trash2 className="w-4 h-4" />
                                            </button>
                                        </div>
                                    </div>

                                    <div className="border-t border-gray-50 pt-4 mt-2 grid grid-cols-2 gap-4">
                                        <div>
                                            <p className="text-xs text-gray-400 font-medium uppercase tracking-wide">Discount</p>
                                            <p className="font-bold text-theme-secondary text-lg">
                                                {promo.discount_type === 'percentage'
                                                    ? `${promo.discount_value}% OFF`
                                                    : `₱${promo.discount_value} OFF`}
                                            </p>
                                        </div>
                                        <div className="text-right">
                                            <p className="text-xs text-gray-400 font-medium uppercase tracking-wide">Usage</p>
                                            <p className="font-semibold text-gray-700">
                                                {promo.usage_count} / {promo.usage_limit || '∞'}
                                            </p>
                                        </div>
                                    </div>

                                    {promo.min_spend > 0 && (
                                        <div className="mt-3 text-xs text-gray-500 bg-gray-50 px-2 py-1 rounded inline-block border border-gray-100">
                                            Min. Spend: ₱{promo.min_spend}
                                        </div>
                                    )}
                                </div>
                            </div>
                        ))
                    )}
                </div>
            </div>
        </div>
    );
};

export default PromoManager;
