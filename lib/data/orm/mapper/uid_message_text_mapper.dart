import 'package:flutter_application_3/data/orm/entity/registr_entity.dart';
import 'package:flutter_application_3/domain/registr/message_text.dart';

extension UidMessageTextMapper on UidMessageText {
  UidRegistrEntityDB toDB() => UidRegistrEntityDB(
        keys: {
          'uid_message': uidMessage,
          'type': type?.name,
          'is_archive': isArchive == null
              ? null
              : isArchive!
                  ? 1
                  : 0,
        },
      );
}
