new Ajax.PeriodicalUpdater(
  "id1",
  "/cgi/stream_buttons/index.rb",
  {
    "method": "get",
    "parameters": "id=1",
    frequency: 5, // 5秒ごとに実行
    onSuccess: function(request) {
      // 成功時の処理を記述
      // alert('成功しました');
    },
    onComplete: function(request) {
      // 完了時の処理を記述
      // alert('読み込みが完了しました');
    },
    onFailure: function(request) {
      alert('読み込みに失敗しました');
    },
    onException: function (request) {
      alert('読み込み中にエラーが発生しました');
    }
  }
);
new Ajax.PeriodicalUpdater(
  "id2",
  "/cgi/stream_buttons/index.rb",
  {
    "method": "get",
    "parameters": "id=2",
    frequency: 5, // 5秒ごとに実行
    onSuccess: function(request) {
      // 成功時の処理を記述
      // alert('成功しました');
    },
    onComplete: function(request) {
      // 完了時の処理を記述
      // alert('読み込みが完了しました');
    },
    onFailure: function(request) {
      alert('読み込みに失敗しました');
    },
    onException: function (request) {
      alert('読み込み中にエラーが発生しました');
    }
  }
);

new Ajax.PeriodicalUpdater(
  "id3",
  "/cgi/stream_buttons/index.rb",
  {
    "method": "get",
    "parameters": "id=3",
    frequency: 5, // 5秒ごとに実行
    onSuccess: function(request) {
      // 成功時の処理を記述
      // alert('成功しました');
    },
    onComplete: function(request) {
      // 完了時の処理を記述
      // alert('読み込みが完了しました');
    },
    onFailure: function(request) {
      alert('読み込みに失敗しました');
    },
    onException: function (request) {
      alert('読み込み中にエラーが発生しました');
    }
  }
);

new Ajax.PeriodicalUpdater(
  "id4",
  "/cgi/stream_buttons/index.rb",
  {
    "method": "get",
    "parameters": "id=4",
    frequency: 5, // 5秒ごとに実行
    onSuccess: function(request) {
      // 成功時の処理を記述
      // alert('成功しました');
    },
    onComplete: function(request) {
      // 完了時の処理を記述
      // alert('読み込みが完了しました');
    },
    onFailure: function(request) {
      alert('読み込みに失敗しました');
    },
    onException: function (request) {
      alert('読み込み中にエラーが発生しました');
    }
  }
);

new Ajax.PeriodicalUpdater(
  "id5",
  "/cgi/stream_buttons/index.rb",
  {
    "method": "get",
    "parameters": "id=5",
    frequency: 5, // 5秒ごとに実行
    onSuccess: function(request) {
      // 成功時の処理を記述
      // alert('成功しました');
    },
    onComplete: function(request) {
      // 完了時の処理を記述
      // alert('読み込みが完了しました');
    },
    onFailure: function(request) {
      alert('読み込みに失敗しました');
    },
    onException: function (request) {
      alert('読み込み中にエラーが発生しました');
    }
  }
);

new Ajax.PeriodicalUpdater(
  "id6",
  "/cgi/stream_buttons/index.rb",
  {
    "method": "get",
    "parameters": "id=6",
    frequency: 5, // 5秒ごとに実行
    onSuccess: function(request) {
      // 成功時の処理を記述
      // alert('成功しました');
    },
    onComplete: function(request) {
      // 完了時の処理を記述
      // alert('読み込みが完了しました');
    },
    onFailure: function(request) {
      alert('読み込みに失敗しました');
    },
    onException: function (request) {
      alert('読み込み中にエラーが発生しました');
    }
  }
);

