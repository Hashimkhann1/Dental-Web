// contact_event.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class LaunchWhatsAppEvent extends ContactEvent {}

class LaunchEmailEvent extends ContactEvent {}

class SubmitFormEvent extends ContactEvent {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String message;
  final DateTime appointmentDate;

  const SubmitFormEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.message,
    required this.appointmentDate,
  });

  @override
  List<Object> get props => [name, email, phone, address, message];
}


abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactSuccess extends ContactState {
  final String message;

  const ContactSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ContactError extends ContactState {
  final String error;

  const ContactError(this.error);

  @override
  List<Object> get props => [error];
}

class FormSubmitting extends ContactState {}

class FormSubmitted extends ContactState {}

class FormSubmissionError extends ContactState {
  final String error;

  const FormSubmissionError(this.error);

  @override
  List<Object> get props => [error];
}

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  static const String whatsappNumber = "923139217887";
  static const String emailAddress = "hmk182002@gmail.com";

  ContactBloc() : super(ContactInitial()) {
    on<LaunchWhatsAppEvent>(_onLaunchWhatsApp);
    on<LaunchEmailEvent>(_onLaunchEmail);
    on<SubmitFormEvent>(_onSubmitForm);
  }

  Future<void> _onLaunchWhatsApp(
      LaunchWhatsAppEvent event,
      Emitter<ContactState> emit,
      ) async {
    try {
      emit(ContactLoading());

      final whatsappUrl = Uri.parse("https://wa.me/$whatsappNumber");

      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
        emit(const ContactSuccess("WhatsApp opened successfully"));
      } else {
        // Fallback to WhatsApp web if app is not available
        final whatsappWebUrl = Uri.parse("https://web.whatsapp.com/send?phone=$whatsappNumber");
        if (await canLaunchUrl(whatsappWebUrl)) {
          await launchUrl(whatsappWebUrl, mode: LaunchMode.externalApplication);
          emit(const ContactSuccess("WhatsApp Web opened successfully"));
        } else {
          emit(const ContactError('Could not launch WhatsApp'));
        }
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
      emit(const ContactError('Could not open WhatsApp. Please make sure WhatsApp is installed.'));
    }
  }

  Future<void> _onLaunchEmail(
      LaunchEmailEvent event,
      Emitter<ContactState> emit,
      ) async {
    try {
      emit(ContactLoading());

      final emailUrl = Uri.parse("mailto:$emailAddress?subject=Healthcare Inquiry");

      if (await canLaunchUrl(emailUrl)) {
        await launchUrl(emailUrl, mode: LaunchMode.externalApplication);
        emit(const ContactSuccess("Email client opened successfully"));
      } else {
        // Fallback to Gmail web
        final gmailWebUrl = Uri.parse("https://mail.google.com/mail/?view=cm&fs=1&to=$emailAddress&su=Healthcare Inquiry");
        if (await canLaunchUrl(gmailWebUrl)) {
          await launchUrl(gmailWebUrl, mode: LaunchMode.externalApplication);
          emit(const ContactSuccess("Gmail opened successfully"));
        } else {
          emit(const ContactError('Could not launch email client'));
        }
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
      emit(const ContactError('Could not open email client. Please check if you have an email app installed.'));
    }
  }

  Future<void> _onSubmitForm(
      SubmitFormEvent event,
      Emitter<ContactState> emit,
      ) async {
    try {
      emit(FormSubmitting());

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Here you would typically make an actual API call
      // Example:
      // final response = await ApiService.submitAppointment({
      //   'name': event.name,
      //   'email': event.email,
      //   'phone': event.phone,
      //   'address': event.address,
      //   'message': event.message,
      // });

      emit(FormSubmitted());
    } catch (e) {
      debugPrint('Error submitting form: $e');
      emit(const FormSubmissionError('Failed to submit appointment request. Please try again.'));
    }
  }

  // Helper methods for UI
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('Appointment request submitted successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }



}