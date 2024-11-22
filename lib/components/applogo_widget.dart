import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'applogo_model.dart';
export 'applogo_model.dart';

class ApplogoWidget extends StatefulWidget {
  /// create me a logo for student
  const ApplogoWidget({super.key});

  @override
  State<ApplogoWidget> createState() => _ApplogoWidgetState();
}

class _ApplogoWidgetState extends State<ApplogoWidget> {
  late ApplogoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApplogoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 120.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.circular(60.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              color: FlutterFlowTheme.of(context).info,
              size: 60.0,
            ),
            Text(
              FFLocalizations.of(context).getText(
                'vvbhs0q6' /* StudyPro */,
              ),
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Inter Tight',
                    color: FlutterFlowTheme.of(context).info,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
