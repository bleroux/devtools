// Copyright 2020 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:vm_service/vm_service.dart';

import 'package:devtools_app/src/debugger/debugger_controller.dart';
import 'package:devtools_app/src/debugger/debugger_model.dart';
import 'package:devtools_app/src/globals.dart';
import 'package:devtools_app/src/service_manager.dart';
import 'package:devtools_app/src/vm_service_wrapper.dart';

void main() {
  ServiceConnectionManager manager;
  DebuggerController debuggerController;

  setUp(() {
    manager = ServiceConnectionManager();
    manager.service = MockVmServiceWrapper();
    when(manager.service.onDebugEvent).thenAnswer((_) {
      return const Stream.empty();
    });
    when(manager.service.onIsolateEvent).thenAnswer((_) {
      return const Stream.empty();
    });
    when(manager.service.onStdoutEvent).thenAnswer((_) {
      return const Stream.empty();
    });
    when(manager.service.onStderrEvent).thenAnswer((_) {
      return const Stream.empty();
    });
    globals[ServiceConnectionManager] = manager;
    debuggerController = DebuggerController();
    debuggerController.isolateRef =
        IsolateRef(id: '1', number: '2', name: 'main');
  });

  tearDown(() {
    globals[ServiceConnectionManager] = null;
  });

  test('Creates bound variables for Uint8ClampedList instance', () async {
    final bytes = Uint8ClampedList.fromList([0, 1, 2, 3]);
    final instance = Instance(
      kind: 'Uint8ClampedList',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 1),
      matchesVariable(name: '[2]', value: 2),
      matchesVariable(name: '[3]', value: 3),
    ]);
  });

  test('Creates bound variables for Uint8List instance', () async {
    final bytes = Uint8List.fromList([0, 1, 2, 3]);
    final instance = Instance(
      kind: 'Uint8List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 1),
      matchesVariable(name: '[2]', value: 2),
      matchesVariable(name: '[3]', value: 3),
    ]);
  });

  test('Creates bound variables for Uint16List instance', () async {
    final bytes = Uint16List.fromList([0, 513, 514, 515]);
    final instance = Instance(
      kind: 'Uint16List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 513),
      matchesVariable(name: '[2]', value: 514),
      matchesVariable(name: '[3]', value: 515),
    ]);
  });

  test('Creates bound variables for Uint32List instance', () async {
    final bytes = Uint32List.fromList([0, 131072, 131073, 131074]);
    final instance = Instance(
      kind: 'Uint32List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 131072),
      matchesVariable(name: '[2]', value: 131073),
      matchesVariable(name: '[3]', value: 131074),
    ]);
  });

  test('Creates bound variables for Uint64List instance', () async {
    final bytes = Uint64List.fromList([0, 4294967296, 4294967297, 4294967298]);
    final instance = Instance(
      kind: 'Uint64List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 4294967296),
      matchesVariable(name: '[2]', value: 4294967297),
      matchesVariable(name: '[3]', value: 4294967298),
    ]);
  });

  test('Creates bound variables for Int8List instance', () async {
    final bytes = Int8List.fromList([0, 1, -2, 3]);
    final instance = Instance(
      kind: 'Int8List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 1),
      matchesVariable(name: '[2]', value: -2),
      matchesVariable(name: '[3]', value: 3),
    ]);
  });

  test('Creates bound variables for Int16List instance', () async {
    final bytes = Int16List.fromList([0, 513, -514, 515]);
    final instance = Instance(
      kind: 'Int16List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 513),
      matchesVariable(name: '[2]', value: -514),
      matchesVariable(name: '[3]', value: 515),
    ]);
  });

  test('Creates bound variables for Int32List instance', () async {
    final bytes = Int32List.fromList([0, 131072, -131073, 131074]);
    final instance = Instance(
      kind: 'Int32List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 131072),
      matchesVariable(name: '[2]', value: -131073),
      matchesVariable(name: '[3]', value: 131074),
    ]);
  });

  test('Creates bound variables for Int64List instance', () async {
    final bytes = Int64List.fromList([0, 4294967296, -4294967297, 4294967298]);
    final instance = Instance(
      kind: 'Int64List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 4294967296),
      matchesVariable(name: '[2]', value: -4294967297),
      matchesVariable(name: '[3]', value: 4294967298),
    ]);
  }, skip: kIsWeb); // Int64List cannot be instantiated on the web.

  test('Creates bound variables for Float32List instance', () async {
    final bytes =
        Float32List.fromList([0, 2.2300031185150146, -4.610400199890137]);
    final instance = Instance(
      kind: 'Float32List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );
    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 2.2300031185150146),
      matchesVariable(name: '[2]', value: -4.610400199890137),
    ]);
  });

  test('Creates bound variables for Float64List instance', () async {
    final bytes = Float64List.fromList([0, 5532.130793, -7532.130793]);
    final instance = Instance(
      kind: 'Float64List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );

    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children, [
      matchesVariable(name: '[0]', value: 0),
      matchesVariable(name: '[1]', value: 5532.130793),
      matchesVariable(name: '[2]', value: -7532.130793),
    ]);
  });

  test('Creates bound variables for Int32x4List instance', () async {
    final bytes =
        Int32x4List.fromList([Int32x4.bool(true, false, true, false)]);
    final instance = Instance(
      kind: 'Int32x4List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );

    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });
    await debuggerController.buildVariablesTree(variable);

    expect(variable.children.first.displayValue,
        '[ffffffff, 00000000, ffffffff, 00000000]',
        skip: kIsWeb);
    // Formatting is different on the web.
    expect(variable.children.first.displayValue, '[-1, 0, -1, 0]',
        skip: !kIsWeb);
  });

  test('Creates bound variables for Float32x4List instance', () async {
    final bytes = Float32x4List.fromList(
        [Float32x4(0.0, -232.1999969482422, 2.3299999237060547, 9.0)]);
    final instance = Instance(
      kind: 'Float32x4List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );

    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children.first.displayValue,
        '[0.000000, -232.199997, 2.330000, 9.000000]');
  });

  test('Creates bound variables for Float64x2List instance', () async {
    final bytes = Float64x2List.fromList([Float64x2(0, -1232.222)]);
    final instance = Instance(
      kind: 'Float64x2List',
      id: '123',
      classRef: null,
      bytes: base64.encode(bytes.buffer.asUint8List()),
    );

    final variable = Variable.create(BoundVariable(
      name: 'test',
      value: instance,
      declarationTokenPos: null,
      scopeEndTokenPos: null,
      scopeStartTokenPos: null,
    ));
    when(manager.service.getObject(any, any)).thenAnswer((_) async {
      return instance;
    });

    await debuggerController.buildVariablesTree(variable);

    expect(variable.children.first.displayValue, '[0.000000, -1232.222000]');
  });
}

Matcher matchesVariable({
  @required String name,
  @required Object value,
}) {
  return const TypeMatcher<Variable>().having(
      (v) => v.boundVar,
      'boundVar',
      const TypeMatcher<BoundVariable>()
          .having((bv) => bv.name, 'name', equals(name))
          .having((bv) => bv.value, 'value', equals(value)));
}

class MockVmServiceWrapper extends Mock implements VmServiceWrapper {}
