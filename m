Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3122530C601;
	Sat, 13 Jun 2026 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781333644; cv=none; b=Fd6hpZTv0qPKn9tUJAn1l07Daosx5oEdb9bIPbksfv8iHhPz+ReeNx9HQtbTpmH1LUPETyPsOxybHMsDXpeuROH7udS7v/Z8hLyhSjC5VMRMvW8R+r/EG24a9OmRX8k9weFnWi61s3f7OK9HTN31oQpteN+jBNRVkUuo+d345Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781333644; c=relaxed/simple;
	bh=+f/bbT6xH3reNo/R7BhJbB82HYElaxDW6qt1sYwgcFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fB+1tScJ0I6sUyDKiBP+4f+FgV8dO9oiPr/Ji7NrxpYAxHK64mEB8x0AG1tjp2o4GxurmLeLvp+jGHoqHZ69Y29+/iJ3evFYKbq4AB0ixbceuDX/9O3VfLP5qviAzpbrhiqZbn/kDW/drdxjWYgtqoOd6QiikCkxsgOSypY4gI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=jVz1nzL1; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="jVz1nzL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1781333637; x=1781592837;
	bh=So92BBZz50UJgnQPGN7TbCptzOVaFoPrE7igeVhIKw8=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jVz1nzL1KmEF+qy+Bs+no4vq9FTpC8f9CzlBINYCTr/QAqib6B7mRRNzJKPJUOxiH
	 cGQvcWUB7m6tWMG5BRmB2R4efUfUFXJEVmqeCEDLW/SrD9d+RrKdqBFOUU0S3Bj+Sh
	 4tpPJ8Ccf/DxfBGZKISDUxONV/PXxQYf7VqXg9Log642H7vPIGyfDGktg9vtt4bp/j
	 2vXw7bLU1EwjPu9VG7M2hzHH54O9g2wj06ReURWaS5H3M6/XPww7hSBzdPdJGjyuwN
	 UTum2ZAsw8KIRABzjFmTtKZoPqwIT/ENNznM2yIjP6M9i3fEeAJbWXMDiZaJp3yER8
	 SEZSq7mfSo+ZQ==
X-Pm-Submission-Id: 4gcnD04pbfz1DF7c
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
Subject: [PATCH v10 0/5] rust: add SRCU abstraction
Date: Sat, 13 Jun 2026 09:40:06 +0300
Message-ID: <20260613065348.96750-1-work@onurozkan.dev>
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


Changes since v9:

- SRCU initialization restructuring is now a separate patch (the first
  one in this series).
- Comment fix on C initialization functions.


Changes since v8:

- Refactor srcu init handling to provide better init API (motivated by
  the "mutex.h" initializers.
- Use warn_on! instead of pr_warn! on leaked guard detection.


Changes since v7:

- Moved synchronize_srcu() call inside "if srcu_readers_active()"
  condition in "impl PinnedDrop for Srcu".
- Improved comments on the synchronize_srcu() call in
  "impl PinnedDrop for Srcu".


Changes since v6:

- Removed "CONFIG_DEBUG_LOCK_ALLOC" condition from "rust/helpers/srcu.c"
  and created a simple wrapper inside "include/linux/srcu.h" for it.


Changes since v5:

- Created separate srcu_readers_active() variants for "srcutiny.h" and
  "srcutree.h".


Changes since v4:

- Exposed srcu_readers_active from C side and wired it to the Rust
  helpers.
- Used srcu_readers_active() in SRCU drop and logged with pr_warn if
  there are leaked guards during the drop.


Changes since v3 (which are for Sashiko notes [2]):

- Added rust helpers for srcu_barrier() and synchronize_srcu_expedited()
  so the abstraction builds with CONFIG_TINY_SRCU, where these are
  static inline functions.
- Added missing INVARIANT comment in Srcu::new() about why the type
  invariants hold after successful initialization.


Changes since v2:

- Removed closure-based API.
- Added #[doc(hidden)] on new_srcu macro.
- Added #[must_use..] on srcu::Guard.
- Improved the clean-up path (PinnedDrop implementation) which
  eventually made read_lock safe with leaked guards.


Changes since v1:

- Made the owned SRCU read-side guard API unsafe and added a safe closure
  based helper for callers that do not need to keep the guard. This is to
  avoid UB on the C side cleanup_srcu_struct where the SRCU struct is freed
  while there are still active guards, which can happen if the caller leaks
  the guard e.g., with mem::forget().
- Improved doc comments.


v1: https://lore.kernel.org/all/20260428103437.156236-1-work@onurozkan.dev
v2: https://lore.kernel.org/all/20260502162833.34334-1-work@onurozkan.dev
v3: https://lore.kernel.org/all/20260522054228.114814-1-work@onurozkan.dev
v4: https://lore.kernel.org/all/20260525175706.124910-1-work@onurozkan.dev
v5: https://lore.kernel.org/all/20260527174120.510447-1-work@onurozkan.dev
v6: https://lore.kernel.org/all/20260527203615.163688-1-work@onurozkan.dev
v7: https://lore.kernel.org/all/20260528062810.256212-1-work@onurozkan.dev
v8: https://lore.kernel.org/all/20260529114449.112066-1-work@onurozkan.dev
v9: https://lore.kernel.org/all/20260529134004.396743-1-work@onurozkan.dev

[1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.dev
[2]: https://sashiko.dev/#/patchset/20260522054228.114814-1-work@onurozkan.dev?part=2

Onur Özkan (5):
  srcu: make init_srcu_struct() consistently wrap __init_srcu_struct()
  rust: helpers: add SRCU helpers
  srcu: expose srcu_readers_active()
  rust: sync: add SRCU abstraction
  MAINTAINERS: add Rust SRCU files to SRCU entry

 MAINTAINERS              |   3 +
 include/linux/srcu.h     |  29 ++++---
 include/linux/srcutiny.h |  13 +++
 include/linux/srcutree.h |  24 ++++++
 kernel/rcu/srcutiny.c    |  14 ++--
 kernel/rcu/srcutree.c    |  36 ++-------
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  35 ++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 171 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 282 insertions(+), 46 deletions(-)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

