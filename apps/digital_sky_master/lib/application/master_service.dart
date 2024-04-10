import 'package:digital_sky_common/digital_sky_common.dart';
import 'package:digital_sky_master/application/game_service.dart';
import 'package:digital_sky_master/application/player_score_provider.dart';
import 'package:digital_sky_master/data/question_pool.dart';
import 'package:digital_sky_master/domain/player.dart';
import 'package:digital_sky_master/presentation/player_list_provider.dart';
import 'package:digital_sky_master/presentation/player_question_answers_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'master_service.g.dart';

@Riverpod(keepAlive: true)
MasterService masterService(MasterServiceRef ref) {
  return MasterService(ref);
}

class MasterService {
  MasterService(this.ref) : _communicationChannel = ref.read(communicationChannelProvider);

  final MasterServiceRef ref;
  final DigitalSkyCommunicationChannel _communicationChannel;

  void init() {
    _communicationChannel
      ..addMessageListener(MessageType.ping, _onPlayerPing)
      ..addMessageListener(MessageType.playerJoin, _onPlayerJoin)
      ..addMessageListener(MessageType.playerLeft, _onPlayerLeave)
      ..addMessageListener(MessageType.playerAnswer, _onPlayerAnswer);
  }

  void _onPlayerJoin(Message message) {
    print("MASTER SAYS: Player joined: ${message.clientId}");
    ref
        .read(playerListProvider.notifier)
        .addPlayer(Player(clientId: message.clientId!, name: message.content, status: PlayerStatus.present));
    sendGameUpdate();
  }

  void _onPlayerPing(Message message) {
    print("MASTER SAYS: Player pinged me! ${message.clientId}");
    ref.read(playerListProvider.notifier).setPlayerStatus(message.clientId!, PlayerStatus.present);
    sendGameUpdate();
  }

  void _onPlayerLeave(Message message) {
    print("MASTER SAYS: Player left the game! ${message.clientId}");
    ref.read(playerListProvider.notifier).setPlayerStatus(message.clientId!, PlayerStatus.idle);
  }

  void _onPlayerAnswer(Message message) {
    print("MASTER SAYS: Player Answered ${message.clientId} :: ${message.content}");
    final parts = Uri.splitQueryString(message.content);
    final question = ref.read(questionPoolProvider).where((element) => element.id == parts['questionId']).first;
    final isCorrect = int.parse(parts['answer']!) == question.answer;
    final scoreGained = isCorrect ? 1000 - (int.parse(parts['t']!) / 100).floor() : 0;

    // Set answer for the player
    final newAnswer = ref.read(playerQuestionAnswersProvider.notifier).addPlayerAnswer(
          message.clientId!,
          parts['questionId']!,
          isCorrect,
        );

    // Add score for the player
    final totalScore = ref.read(playerScoreProvider.notifier).addPlayerScore(
          message.clientId!,
          newAnswer ? scoreGained : 0,
        );

    if (newAnswer) {
      // Send info to player
      _communicationChannel.sendMessage(
        Message(
          type: MessageType.questionResult,
          target: message.clientId!,
          content:
              "correct=${isCorrect ? 'true' : 'false'}&correctAnswer=${question.answer}&score=$scoreGained&totalScore=$totalScore&questionId=${parts['questionId']}",
        ),
      );
    }
  }

  void sendGameUpdate() {
    print("Sending game update...");
    _communicationChannel.sendMessage(
      Message(
        type: MessageType.gameUpdate,
        content: ref.read(gameServiceProvider).toQueryString(),
      ),
    );
  }
}
