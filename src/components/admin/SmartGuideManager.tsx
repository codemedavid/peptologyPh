import React, { useState, useRef } from 'react';
import { Plus, Trash2, Edit2, FileText, Image, File, ChevronDown, ChevronUp, Upload, ExternalLink, X, Save } from 'lucide-react';
import { useSmartGuides } from '../../hooks/useSmartGuides';
import { SmartGuide } from '../../types';

const SmartGuideManager: React.FC = () => {
    const { guides, loading, createGuide, updateGuide, deleteGuide, addFile, deleteFile } = useSmartGuides();
    const [isCreating, setIsCreating] = useState(false);
    const [newGuideTitle, setNewGuideTitle] = useState('');
    const [expandedGuideId, setExpandedGuideId] = useState<string | null>(null);
    const [uploadingForGuideId, setUploadingForGuideId] = useState<string | null>(null);
    const [isUploading, setIsUploading] = useState(false);

    // Edit mode states
    const [editingGuideId, setEditingGuideId] = useState<string | null>(null);
    const [editTitle, setEditTitle] = useState('');

    const fileInputRef = useRef<HTMLInputElement>(null);

    const handleCreateGuide = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!newGuideTitle.trim()) return;

        const result = await createGuide(newGuideTitle);
        if (result.success && result.data) {
            setExpandedGuideId(result.data.id);
        }
        setNewGuideTitle('');
        setIsCreating(false);
    };

    const handleDeleteGuide = async (id: string) => {
        if (confirm('Are you sure you want to delete this topic and all its files?')) {
            await deleteGuide(id);
        }
    };

    const handleUpdateGuide = async (id: string) => {
        if (!editTitle.trim()) return;
        await updateGuide(id, { title: editTitle });
        setEditingGuideId(null);
    };

    const startEdit = (guide: SmartGuide) => {
        setEditingGuideId(guide.id);
        setEditTitle(guide.title);
    };

    const toggleExpand = (id: string) => {
        setExpandedGuideId(expandedGuideId === id ? null : id);
    };

    const handleFileSelect = async (e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file || !uploadingForGuideId) return;

        try {
            setIsUploading(true);
            // Default display name is filename, user can update it later if we add that feature, 
            // for now just use filename without extension
            const displayName = file.name.replace(/\.[^/.]+$/, "");
            await addFile(uploadingForGuideId, file, displayName);
        } catch (error) {
            alert('Upload failed');
        } finally {
            setIsUploading(false);
            setUploadingForGuideId(null);
            if (fileInputRef.current) fileInputRef.current.value = '';
        }
    };

    const triggerUpload = (guideId: string) => {
        setUploadingForGuideId(guideId);
        setTimeout(() => {
            fileInputRef.current?.click();
        }, 0);
    };

    const getFileIcon = (type: string) => {
        switch (type) {
            case 'image': return <Image className="w-4 h-4 text-purple-500" />;
            case 'pdf': return <FileText className="w-4 h-4 text-red-500" />;
            default: return <File className="w-4 h-4 text-gray-500" />;
        }
    };

    if (loading) {
        return (
            <div className="flex justify-center p-8">
                <div className="w-8 h-8 border-4 border-gray-200 border-t-theme-accent rounded-full animate-spin"></div>
            </div>
        );
    }

    return (
        <div className="space-y-6">
            <div className="flex justify-between items-center">
                <div>
                    <h2 className="text-xl font-bold text-gray-800">Smart Guide System</h2>
                    <p className="text-sm text-gray-500">Manage topics and downloadable resources for the QR page</p>
                </div>
                <button
                    onClick={() => setIsCreating(true)}
                    className="bg-theme-accent hover:bg-theme-accent/90 text-white px-4 py-2 rounded-lg flex items-center gap-2 text-sm font-medium transition-colors"
                >
                    <Plus className="w-4 h-4" />
                    Add Topic
                </button>
            </div>

            {isCreating && (
                <form onSubmit={handleCreateGuide} className="bg-gray-50 p-4 rounded-lg border border-gray-200 flex gap-3 animate-fade-in">
                    <input
                        type="text"
                        value={newGuideTitle}
                        onChange={(e) => setNewGuideTitle(e.target.value)}
                        placeholder="Enter topic title (e.g., Weight Loss Plateau)"
                        className="flex-1 px-4 py-2 rounded border border-gray-300 focus:ring-2 focus:ring-theme-accent focus:border-transparent"
                        autoFocus
                    />
                    <button
                        type="submit"
                        className="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded font-medium text-sm"
                    >
                        Save
                    </button>
                    <button
                        type="button"
                        onClick={() => setIsCreating(false)}
                        className="bg-white border border-gray-300 hover:bg-gray-50 text-gray-700 px-4 py-2 rounded font-medium text-sm"
                    >
                        Cancel
                    </button>
                </form>
            )}
            {isCreating && (
                <p className="text-xs text-gray-500 ml-1">
                    <span className="font-semibold text-theme-secondary">Note:</span> You can upload files (PDFs, Images) after creating the topic.
                </p>
            )}

            <div className="space-y-4">
                {guides.length === 0 ? (
                    <div className="text-center py-12 bg-white rounded-xl border border-dashed border-gray-300">
                        <p className="text-gray-500">No topics found. Create one to get started.</p>
                    </div>
                ) : (
                    guides.map((guide) => (
                        <div key={guide.id} className="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
                            {/* Header */}
                            <div className="p-4 flex items-center justify-between bg-white hover:bg-gray-50 transition-colors">
                                <div className="flex items-center gap-3 flex-1">
                                    <button onClick={() => toggleExpand(guide.id)} className="text-gray-400 hover:text-gray-600">
                                        {expandedGuideId === guide.id ? <ChevronUp className="w-5 h-5" /> : <ChevronDown className="w-5 h-5" />}
                                    </button>

                                    {editingGuideId === guide.id ? (
                                        <div className="flex items-center gap-2 flex-1 max-w-md">
                                            <input
                                                value={editTitle}
                                                onChange={(e) => setEditTitle(e.target.value)}
                                                className="flex-1 px-2 py-1 border rounded text-sm"
                                            />
                                            <button onClick={() => handleUpdateGuide(guide.id)} className="text-green-600 hover:text-green-700"><Save className="w-4 h-4" /></button>
                                            <button onClick={() => setEditingGuideId(null)} className="text-gray-500 hover:text-gray-700"><X className="w-4 h-4" /></button>
                                        </div>
                                    ) : (
                                        <h3 className="font-semibold text-gray-800">{guide.title}</h3>
                                    )}

                                    <span className="bg-gray-100 text-gray-600 text-xs px-2 py-0.5 rounded-full">
                                        {guide.files?.length || 0} files
                                    </span>
                                </div>

                                <div className="flex items-center gap-2">
                                    <button
                                        onClick={() => startEdit(guide)}
                                        className="p-2 text-gray-400 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                                    >
                                        <Edit2 className="w-4 h-4" />
                                    </button>
                                    <button
                                        onClick={() => handleDeleteGuide(guide.id)}
                                        className="p-2 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded-lg transition-colors"
                                    >
                                        <Trash2 className="w-4 h-4" />
                                    </button>
                                </div>
                            </div>

                            {/* Content (Files) */}
                            {expandedGuideId === guide.id && (
                                <div className="border-t border-gray-100 bg-gray-50/50 p-4">
                                    <div className="space-y-2">
                                        {guide.files?.map((file) => (
                                            <div key={file.id} className="flex items-center justify-between bg-white p-3 rounded-lg border border-gray-100 shadow-sm group">
                                                <div className="flex items-center gap-3">
                                                    <div className="p-2 bg-gray-50 rounded-lg">
                                                        {getFileIcon(file.file_type)}
                                                    </div>
                                                    <div>
                                                        <p className="text-sm font-medium text-gray-700">{file.display_name}</p>
                                                        <p className="text-xs text-gray-400 uppercase">{file.file_type}</p>
                                                    </div>
                                                </div>
                                                <div className="flex items-center gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                                                    <a
                                                        href={file.file_url}
                                                        target="_blank"
                                                        rel="noopener noreferrer"
                                                        className="p-1 text-gray-400 hover:text-blue-600 hover:bg-blue-50 rounded"
                                                        title="View File"
                                                    >
                                                        <ExternalLink className="w-4 h-4" />
                                                    </a>
                                                    <button
                                                        onClick={() => deleteFile(file.id, file.file_url)}
                                                        className="p-1 text-gray-400 hover:text-red-600 hover:bg-red-50 rounded"
                                                        title="Delete File"
                                                    >
                                                        <Trash2 className="w-4 h-4" />
                                                    </button>
                                                </div>
                                            </div>
                                        ))}

                                        <button
                                            onClick={() => triggerUpload(guide.id)}
                                            disabled={isUploading}
                                            className="w-full py-3 border-2 border-dashed border-gray-300 rounded-lg text-gray-500 hover:border-theme-accent hover:text-theme-accent hover:bg-white transition-all flex items-center justify-center gap-2 text-sm font-medium"
                                        >
                                            {isUploading && uploadingForGuideId === guide.id ? (
                                                <>
                                                    <div className="w-4 h-4 border-2 border-theme-accent border-t-transparent rounded-full animate-spin"></div>
                                                    Uploading...
                                                </>
                                            ) : (
                                                <>
                                                    <Upload className="w-4 h-4" />
                                                    Upload File (PDF, Image, Doc)
                                                </>
                                            )}
                                        </button>
                                    </div>
                                </div>
                            )}
                        </div>
                    ))
                )}
            </div>

            {/* Hidden File Input */}
            <input
                type="file"
                ref={fileInputRef}
                onChange={handleFileSelect}
                className="hidden"
                accept=".pdf,.doc,.docx,.jpg,.jpeg,.png,.gif,.webp" // Broad acceptance
            />
        </div>
    );
};

export default SmartGuideManager;
