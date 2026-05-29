Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367663DC4AE
	for <rcu@vger.kernel.org>; Fri, 29 May 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055109; cv=none; b=RwrhY+wv7tDWl844SIBgYzJ/+B9Sfw6xlE0A7vaqGyBvDTRT4PYfLTZT2ODJ/lay3HsVm7wKnm+umSj9A1ks20uiLBzOJEUG4nNkxTCn94UfRewoIpnRMcAMY+gwXoBeftmYU53FtUykaD3kIwW424u2sU4hSqz+CWnlvw0f888=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055109; c=relaxed/simple;
	bh=QOgMwlVGoSS3aWw2O4I+mn0eC5ABmtw5uXckh0d/Chg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ET1vDai3CpYRXuCwzuoDDN0w/ofCp306YU8EKDps6A6fZkjh6XkFcJQWQTZKws0Tv+pdwhotd/ffqTuZ8MLURzvRwTx8WI5EwN1kSJyCVUTHVfmU4szJA9pPbXb3L3WY5Qt4qrqfw0nJ7J8e45WWTitHAQP6ZlY5BKPz2cFmvBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=mWB16Zn6; arc=none smtp.client-ip=109.224.244.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="mWB16Zn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780055098; x=1780314298;
	bh=teMeCr9MNW9sCv6xOxoqpMjTo09nSFeejzagqRk5rM4=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mWB16Zn6lO6kJTHFFWq2Dr+MPadde1ZYuJUxn9wQ66j6KEHS+KKIO6i6Hw/RP9pI7
	 CMhPv2PTnQhBdRzDj4ZVcRpvRpdPo8LzkiKuxUVerKWQRnnhDYDCBRTI+lTKTejeKJ
	 lzy+84F7a30XdENhRMmNMVzWA2ThfWptEwslE2c5lYksjzQ/z58V8bNTOYGkqrgGwq
	 wLd+QzsoURGxVzs4D64moni7tIX/QVaH6aWg41w3R1ytYZ+hwhwUYHv/aVe84u/VHz
	 8g/yEh7NRJ+twfv1QRe/c+bmxZNYxMMKXmdoz7Q76uOIcLsgT/znqaRmQ0CKmQ2yFq
	 K1WjjCoDLgFsA==
X-Pm-Submission-Id: 4gRhNk40RHz1DF6t
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rcu@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	fujita.tomonori@gmail.com,
	tamird@kernel.org,
	jiangshanlai@gmail.com,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v8 0/4] rust: helpers: add SRCU helpers
Date: Fri, 29 May 2026 14:43:49 +0300
Message-ID: <20260529114449.112066-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The immediate motivation is the Tyr reset infrastructure [1] which needs
to serialize reset sensitive hardware access against reset and teardown
paths. That reset series started to require many independent dependencies
so this SRCU support is split out as a standalone Rust API to keep the
reset series focused on the reset logic and easier to review, rebase and
land.

Changes since v7:

- Moved synchronize_srcu() call inside "if srcu_readers_active()"
  condition in "impl PinnedDrop for Srcu".
- Improved comments on the synchronize_srcu() call in
  "impl PinnedDrop for Srcu".

v7: https://lore.kernel.org/all/20260528062810.256212-1-work@onurozkan.dev

Changes since v6:

- Removed "CONFIG_DEBUG_LOCK_ALLOC" condition from "rust/helpers/srcu.c"
  and created a simple wrapper inside "include/linux/srcu.h" for it.

v6: https://lore.kernel.org/all/20260527203615.163688-1-work@onurozkan.dev

Changes since v5:

- Created separate srcu_readers_active() variants for "srcutiny.h" and
  "srcutree.h".

v5: https://lore.kernel.org/all/20260527174120.510447-1-work@onurozkan.dev

Changes since v4:

- Exposed srcu_readers_active from C side and wired it to the Rust
  helpers.
- Used srcu_readers_active() in SRCU drop and logged with pr_warn if
  there are leaked guards during the drop.

v4: https://lore.kernel.org/all/20260525175706.124910-1-work@onurozkan.dev

Changes since v3 (which are for Sashiko notes [2]):

- Added rust helpers for srcu_barrier() and synchronize_srcu_expedited()
  so the abstraction builds with CONFIG_TINY_SRCU, where these are
  static inline functions.
- Added missing INVARIANT comment in Srcu::new() about why the type
  invariants hold after successful initialization.

v3: https://lore.kernel.org/all/20260522054228.114814-1-work@onurozkan.dev

Changes since v2:

- Removed closure-based API.
- Added #[doc(hidden)] on new_srcu macro.
- Added #[must_use..] on srcu::Guard.
- Improved the clean-up path (PinnedDrop implementation) which
  eventually made read_lock safe with leaked guards.

v2: https://lore.kernel.org/all/20260502162833.34334-1-work@onurozkan.dev

Changes since v1:

- Made the owned SRCU read-side guard API unsafe and added a safe closure
  based helper for callers that do not need to keep the guard. This is to
  avoid UB on the C side cleanup_srcu_struct where the SRCU struct is freed
  while there are still active guards, which can happen if the caller leaks
  the guard e.g., with mem::forget().
- Improved doc comments.

v1: https://lore.kernel.org/all/20260428103437.156236-1-work@onurozkan.dev


[1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.dev
[2]: https://sashiko.dev/#/patchset/20260522054228.114814-1-work@onurozkan.dev?part=2

Onur Özkan (4):
  rust: helpers: add SRCU helpers
  srcu: expose srcu_readers_active()
  rust: sync: add SRCU abstraction
  MAINTAINERS: add Rust SRCU files to SRCU entry

 MAINTAINERS              |   3 +
 include/linux/srcu.h     |   5 ++
 include/linux/srcutiny.h |  13 +++
 include/linux/srcutree.h |  24 ++++++
 kernel/rcu/srcutiny.c    |   2 +-
 kernel/rcu/srcutree.c    |  25 ------
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  35 ++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 173 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 257 insertions(+), 26 deletions(-)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

