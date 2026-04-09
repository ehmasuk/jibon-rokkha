import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/category_model.dart';
import '../../../models/aid_model.dart';
import '../../../core/providers/firebase_providers.dart';

// Static Categories as requested
final categoriesProvider = Provider<List<CategoryModel>>((ref) {
  return [
    CategoryModel(id: '1', nameBn: 'হার্ট ও রক্তসঞ্চালন', icon: '❤️', color: '#C0392B', order: 1, items: ['হার্ট অ্যাটাক', 'সিপিআর (কার্ডিওপালমোনারি)', 'স্ট্রোক', 'বুক ব্যথা']),
    CategoryModel(id: '2', nameBn: 'শ্বাসনালী ও এয়ারওয়ে', icon: '🫁', color: '#3498DB', order: 2, items: ['শ্বাসকষ্ট (প্রাপ্তবয়স্ক)', 'শ্বাসকষ্ট (শিশু)', 'অ্যাজমা অ্যাটাক', 'শ্বাস বন্ধ হয়ে যাওয়া']),
    CategoryModel(id: '3', nameBn: 'রক্তপাত ও ক্ষত', icon: '🩸', color: '#E74C3C', order: 3, items: ['গভীর রক্তপাত', 'কাটা ক্ষত', 'নাক দিয়ে রক্ত পড়া', 'ছিদ্র হওয়া ক্ষত', 'ব্লান্ট ট্রমা']),
    CategoryModel(id: '4', nameBn: 'পোড়া', icon: '🔥', color: '#E67E22', order: 4, items: ['থার্মাল পোড়া', 'কেমিক্যাল পোড়া', 'ইলেকট্রিক পোড়া', 'সান বার্ন/স্ক্যাল্ড']),
    CategoryModel(id: '5', nameBn: 'কামড় ও দংশন', icon: '🐍', color: '#27AE60', order: 5, items: ['সাপের কামড়', 'কুকুরের কামড়', 'বিচ্ছুর দংশন', 'মৌমাছি/বোলতার দংশন', 'বানরের কামড়', 'জোঁকের কামড়']),
    CategoryModel(id: '6', nameBn: 'ডুবে যাওয়া', icon: '💧', color: '#2980B9', order: 6, items: ['ডুবে যাওয়া (প্রাপ্তবয়স্ক)', 'ডুবে যাওয়া (শিশু)']),
    CategoryModel(id: '7', nameBn: 'বিদ্যুৎ শক', icon: '⚡', color: '#F1C40F', order: 7, items: ['ইলেকট্রিক শক', 'বজ্রপাতের আঘাত']),
    CategoryModel(id: '8', nameBn: 'হাড় ও আঘাত', icon: '🦴', color: '#95A5A6', order: 8, items: ['হাত ভাঙা', 'পা ভাঙা', 'মেরুদণ্ডের আঘাত', 'মচকানো/ডিসলোকেশন']),
    CategoryModel(id: '9', nameBn: 'বিষক্রিয়া', icon: '🤢', color: '#8E44AD', order: 9, items: ['বিষ খাওয়া', 'কীটনাশক বিষক্রিয়া', 'ড্রাগ ওভারডোজ', 'গ্যাস/কার্বন মনোক্সাইড বিষক্রিয়া', 'অ্যালকোহল বিষক্রিয়া']),
    CategoryModel(id: '10', nameBn: 'মাথা ও স্নায়ুতন্ত্র', icon: '🧠', color: '#34495E', order: 10, items: ['মাথায় আঘাত', 'খিঁচুনি/অজ্ঞান হয়ে যাওয়া', 'গুরুতর মাথা ঘোরা']),
    CategoryModel(id: '11', nameBn: 'তাপজনিত অসুস্থতা', icon: '🌡️', color: '#D35400', order: 11, items: ['হিটস্ট্রোক', 'উচ্চ জ্বর', 'হাইপোথার্মিয়া', 'সানবার্ন']),
    CategoryModel(id: '12', nameBn: 'শিশু প্রাথমিক চিকিৎসা', icon: '👶', color: '#F39C12', order: 12, items: ['নবজাতকের জরুরি অবস্থা', 'শিশুর উচ্চ জ্বর', 'শিশুর খিঁচুনি', 'শিশুর শ্বাসকষ্ট', 'শিশুর পোড়া']),
    CategoryModel(id: '13', nameBn: 'সড়ক দুর্ঘটনা', icon: '🚗', color: '#C0392B', order: 13, items: ['সাধারণ সড়ক দুর্ঘটনা', 'আহত ব্যক্তিকে সরানো', 'দুর্ঘটনার পর অচেতনতা', 'মোটরসাইকেল/রিকশা দুর্ঘটনা']),
    CategoryModel(id: '14', nameBn: 'চোখ, কান ও নাক', icon: '👁️', color: '#16A085', order: 14, items: ['চোখে আঘাত', 'চোখে রাসায়নিক পড়া', 'কানে বিদেশী বস্তু', 'নাকে বিদেশী বস্তু', 'গলায় বস্তু আটকে যাওয়া']),
    CategoryModel(id: '15', nameBn: 'মানসিক স্বাস্থ্য জরুরি', icon: '😔', color: '#9B59B6', order: 15, items: ['প্যানিক অ্যাটাক', 'তীব্র মানসিক আঘাত', 'আত্মহত্যার প্রবণতা']),
    CategoryModel(id: '16', nameBn: 'ডায়াবেটিস ও রক্তের শর্করা', icon: '🩸', color: '#E91E63', order: 16, items: ['হাইপোগ্লাইসেমিয়া', 'হাইপারগ্লাইসেমিয়া', 'ডায়াবেটিক কোমা']),
    CategoryModel(id: '17', nameBn: 'মাতৃত্বকালীন জরুরি অবস্থা', icon: '🤰', color: '#E1BEE7', order: 17, items: ['প্রসবকালীন জরুরি অবস্থা', 'গর্ভাবস্থায় রক্তপাত', 'প্রসব পরবর্তী জরুরি অবস্থা']),
    CategoryModel(id: '18', nameBn: 'অ্যালার্জি ও অ্যানাফিল্যাক্সিস', icon: '🤧', color: '#CDDC39', order: 18, items: ['অ্যানাফিল্যাক্টিক শক', 'গুরুতর অ্যালার্জি', 'বিষাক্ত কামড়ে অ্যালার্জি']),
    CategoryModel(id: '19', nameBn: 'সংক্রামক জরুরি অবস্থা', icon: '🦠', color: '#1ABC9C', order: 19, items: ['ডেঙ্গুর লক্ষণ', 'কলেরা/তীব্র ডায়রিয়া', 'টাইফয়েড জ্বর', 'ম্যালেরিয়ার লক্ষণ', 'জলাতঙ্ক সন্দেহ']),
  ];
});

// Stream of All Aids from Firestore
final allAidsProvider = StreamProvider<List<AidModel>>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return firestore
      .collection('aids')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => AidModel.fromMap(doc.data(), doc.id))
        .toList();
  });
});
