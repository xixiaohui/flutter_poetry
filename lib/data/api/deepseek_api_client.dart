import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../models/poem.dart';

/// DeepSeek API 异常
class DeepSeekApiException implements Exception {
  final String message;
  final int? statusCode;
  DeepSeekApiException(this.message, {this.statusCode});

  @override
  String toString() => 'DeepSeekApiException: $message${statusCode != null ? ' (status: $statusCode)' : ''}';
}

/// DeepSeek AI API 客户端
final class DeepSeekApiClient {
  final Dio _dio = DioClient.deepseek;

  /// 设置 API Key (从安全存储或配置中获取)
  void setApiKey(String apiKey) {
    _dio.options.headers['Authorization'] = 'Bearer $apiKey';
  }

  /// AI 赏析 — 对指定诗词生成赏析
  Future<String> analyzePoem(Poem poem) async {
    try {
      final prompt = _buildAnalysisPrompt(poem);

      final response = await _dio.post(
        '/v1/chat/completions',
        data: {
          'model': 'deepseek-chat',
          'messages': [
            {
              'role': 'system',
              'content':
                  '你是一位精通中国古典诗词的学者。请用优美、深入浅出的中文为用户赏析诗词。从意境、技法、情感、历史背景等维度进行解读，字数控制在 300 字左右。',
            },
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 0.7,
          'max_tokens': 800,
        },
      );

      final choices = response.data['choices'] as List;
      return choices.first['message']['content'] as String;
    } on DioException catch (e) {
      throw DeepSeekApiException(
        '诗词赏析请求失败: ${e.message}',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw DeepSeekApiException('诗词赏析处理异常: $e');
    }
  }

  /// AI 配图 — 生成国风插画描述
  Future<String> generateIllustrationPrompt(Poem poem) async {
    try {
      final response = await _dio.post(
        '/v1/chat/completions',
        data: {
          'model': 'deepseek-chat',
          'messages': [
            {
              'role': 'system',
              'content':
                  '你是一位国风插画师。请根据诗词内容，用中文描述一幅适合该诗词的国风插画画面。描述应包含构图、色彩、元素、氛围，适合作为 AI 绘画工具的 prompt 输入。字数控制在 150 字以内。',
            },
            {
              'role': 'user',
              'content': '请为以下诗词创作一幅国风插画描述：\n\n《${poem.title}》\n${poem.content}',
            },
          ],
          'temperature': 0.8,
          'max_tokens': 400,
        },
      );

      final choices = response.data['choices'] as List;
      return choices.first['message']['content'] as String;
    } on DioException catch (e) {
      throw DeepSeekApiException(
        '配图描述请求失败: ${e.message}',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw DeepSeekApiException('配图描述处理异常: $e');
    }
  }

  String _buildAnalysisPrompt(Poem poem) {
    final buffer = StringBuffer();
    buffer.writeln('请赏析以下诗词：');
    buffer.writeln();
    buffer.writeln('《${poem.title}》');
    buffer.writeln('作者：${poem.author.name}');
    buffer.writeln('朝代：${poem.dynasty.name}');
    buffer.writeln();
    buffer.writeln(poem.content);
    return buffer.toString();
  }
}
