Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793BE329C54;
	Fri, 29 May 2026 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062024; cv=none; b=XJsEf/yb/ZEWWhbESJ4iLmkCRFeuvwqRu/3IK26D8Arzek2eVzYas1ybhqzMlYDFbQkSX0OdmDnuEbwzfPE6w8hZ7JW4eZiZmCMCTHemSzZjF8K3UCDVhxezS5Q7Fn634kEtUO74WjrAGye7cKqyWSqoNzWOKL7enkv7KOQu4Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062024; c=relaxed/simple;
	bh=V76K5Gugw6gQcruCr4ZwRGVpHteVhlI7zrGVVaUh6c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bgE428uiOU36gpna6wxxk68q6mJwhIlOjHpT+H6eolAjfvgRetDGHUuSB5uzZGp03D1avN8/z7FArnvqP43iewfR8wLg+I3JL0V6soZSHJo1FRtaMiUYI2z02j1K9cM5mHWXEDYxZt7GEWahiFkj6PHFQQ0qxY9mq5cpkrfiyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=OYYs7Z6j; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="OYYs7Z6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1780062011; x=1780321211;
	bh=IOtnxQrp4YaiFhpRJRIKIPHnMA6NKedXJ2qcTsHdZiA=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OYYs7Z6j+Fbsx08EbflZG40e9b1u3/NwDRlJXHQj8NJTZhaNc23qY/bBB3lQtZpHL
	 O9o9w1LfXJ9u7o8VpUKs0tAB4Q+m2KNeXX/KqOzKWTeSxrT2ABiIlsnNhFRJHpvIOV
	 Tdm6keqycPcY19Au3JswpqZuPWrJvBBZgFWLfRwtierRrged9YcBm03+rvL8s/ikpy
	 s0S6utLNqPEoMQfwfZKxKIGvN4ZHddfVJyYWyuyyDyLbklfjwpVfU1oeGhcrL7TOLv
	 +Lx3YULtRgndj+5Ql/7k+Rfp6OV/5WGSxTP3Pgmokv80qCOwQ9RKxlBz98f/Bp/wGg
	 0ZZZBqYFxEUew==
X-Pm-Submission-Id: 4gRkxh0m33z1DDL0
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
Subject: [PATCH v9 0/4] rust: add SRCU abstraction
Date: Fri, 29 May 2026 16:39:50 +0300
Message-ID: <20260529134004.396743-1-work@onurozkan.dev>
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

Changes since v8:

- Refactor srcu init handling to provide better init API (motivated by
  the "mutex.h" initializers.
- Use warn_on! instead of pr_warn! on leaked guard detection.

v8: https://lore.kernel.org/all/20260529114449.112066-1-work@onurozkan.dev

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
 include/linux/srcu.h     |  29 ++++---
 include/linux/srcutiny.h |  13 +++
 include/linux/srcutree.h |  24 ++++++
 kernel/rcu/srcutiny.c    |  12 +--
 kernel/rcu/srcutree.c    |  34 ++------
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  35 ++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 171 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 280 insertions(+), 44 deletions(-)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

