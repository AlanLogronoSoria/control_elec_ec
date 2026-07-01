/// Widget de entrada de votos por candidato/organización.
library;

import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/acta_entity.dart';

class VoteEntryForm extends StatelessWidget {
  const VoteEntryForm({
    super.key,
    required this.formFields,
    required this.voteControllers,
  });

  final List<OrganizacionFormEntity> formFields;
  final Map<String, TextEditingController> voteControllers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: formFields.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  width: 12, height: 12,
                  decoration: BoxDecoration(
                    color: Color(int.parse(f.colorHex.replaceAll('#', '0xFF'))),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(f.organizationName,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(f.candidateName,
                          style: const TextStyle(fontSize: 11, color: AppColors.textHint)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 70,
                  child: TextFormField(
                    controller: voteControllers[f.candidateId],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
    );
  }
}
