import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final EdgeInsets padding;
  final EdgeInsets? contentPadding;
  final String? label;
  final TextEditingController? controller;
  final String? errorLabel;
  final String? placeholder;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final Function(String)? onSubmit;
  final bool readOnly;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Color? backgroundColor;
  final Color? focusBorderColor;
  final double radius;
  final int? minLine;
  final int? maxLine;
  final bool? isRequired;
  final bool? showCursor;
  const AppTextField(
      {super.key,
      //
      this.label,
      this.controller,
      this.errorLabel,
      this.padding = EdgeInsets.zero,
      this.contentPadding,
      this.placeholder,
      required this.onChanged,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.onSubmit,
      this.readOnly = false,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onTap,
      this.backgroundColor = Colors.transparent,
      this.focusBorderColor,
      this.radius = 8,
      this.maxLine = 1,
      this.minLine = 1,
      this.isRequired = true,
      this.showCursor = true
      //
      });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (widget.label!.isNotEmptyOrNull)
          //   PrimaryRequiredLabel(widget.label!, widget.isRequired!),
          // if (widget.label.isNotEmptyOrNull) const SizedBox(height: 0),
          Container(
            decoration: BoxDecoration(
                color: widget.backgroundColor ?? Colors.white,
                borderRadius: BorderRadius.circular(widget.radius)),
            child: TextField(
              decoration: InputDecoration(
                  isDense: true,
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      fontSize: 16),
                  hintText: widget.placeholder,
                  contentPadding: widget.contentPadding ??
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(widget.radius)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: widget.errorLabel != null
                              ? Colors.red
                              : widget.focusBorderColor ?? Colors.grey),
                      borderRadius: BorderRadius.circular(widget.radius)),
                  errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(widget.radius))
                      .copyWith(
                          borderSide: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(widget.radius))
                              .borderSide
                              .copyWith(color: Colors.red)),
                  // suffixIcon: widget.suffixIcon ??
                  //     (widget.obscureText == true
                  //         ? InkWell(
                  //             onTap: () => setState(() {
                  //               obscureText = !obscureText;
                  //             }),
                  //             child: Container(
                  //                 color: Colors.transparent,
                  //                 padding: const EdgeInsets.all(5),
                  //                 margin: const EdgeInsets.only(right: 8),
                  //                 child: obscureText
                  //                     ? Assets.icons.icEye
                  //                         .svg(width: 20, height: 20)
                  //                     : Assets.icons.icEyeOff
                  //                         .svg(width: 20, height: 20)),
                  //           )
                  //         : null),
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 42,
                    maxWidth: 56,
                  ),
                  prefixIcon: widget.prefixIcon,
                  prefixIconConstraints: widget.prefixIcon != null
                      ? const BoxConstraints(maxHeight: 32)
                      : null,
                  focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 1,
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(widget.radius))
                      .copyWith(
                          borderSide: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(widget.radius))
                              .borderSide
                              .copyWith(
                                  color: widget.errorLabel != null
                                      ? Colors.red
                                      : widget.focusBorderColor ??
                                          Colors.deepPurpleAccent))),
              onChanged: (value) {
                setState(() {});
                widget.onChanged?.call(value);
              },
              textInputAction: widget.textInputAction,
              onSubmitted: widget.onSubmit,
              keyboardType: widget.textInputType,
              controller: widget.controller ?? TextEditingController(),
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              obscureText: obscureText,
              showCursor: widget.showCursor,
              cursorColor: Colors.deepPurpleAccent,
              minLines: widget.minLine,
              maxLines: widget.maxLine,
            ),
          ),
          // if (widget.errorLabel != null) const SizedBox(height: 8),
          // if (widget.errorLabel != null)
          //   RichText(
          //     textAlign: TextAlign.start,
          //     text: TextSpan(
          //       children: [
          //         WidgetSpan(
          //           child: Padding(
          //             padding: const EdgeInsets.only(right: 2),
          //             child: Assets.icons.icErrorWarningFill
          //                 .svg(width: 16, height: 16, color: Colors.red),
          //           ),
          //         ),
          //         TextSpan(
          //           text: tr(widget.errorLabel!),
          //           style: GoogleFonts.notoSans(
          //               color: AppColors.red,
          //               fontSize: 12,
          //               fontWeight: FontWeight.w400),
          //         ),
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
