Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CC3C2788;
	Wed, 27 May 2026 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914196; cv=none; b=O6d/CklP+K6scpksCXMf0qkbM2a1Sm0yUHnvTk8/xJAOaYj6i9iVGilLUB1Kdq8O3TFxZvO09SWS+oQRExoG6T/DmTp+2/l/Wmv/yuXvVqG2kIHaYiLHCoNRiQR8xpjwBpSGZV414toABHdPkmN3h8WGRuObMhd3GbWdpKv1SQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914196; c=relaxed/simple;
	bh=jEjK9jyk4uZ7ong8MTHRrWbWeP797rZzVs8FP6mTMFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OxIHKbw2KWt8bEsiJSSV/QMKcHekwPjSMC5nHMIQV1U5BqXYefBvMkjGTFJWpMHqv4Se6TsKdF3FCzWdCNCpIvKi5ruk/bzX/pxZKQk+x1dVta3UObjtH9vHtCiqSK49edBeH/7Xq26E8osQUCmAUnCXvj38MqAC8K+EPdDd4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=T+RJ020I; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="T+RJ020I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779914183; x=1780173383;
	bh=v6yqgk/6+RxRiahqqze7IuzCz/a7SeihPRS98LY+g2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T+RJ020IVYxTZGCQzCd4F/ErtditX8SCT8v84UzGSepj1W0WIBQeHkx8pfwnIRq+7
	 YWm30KwCeCNa61dVwBFBZ7mMVB/cVAYbInSgmM3zRlGHuJyimYI7+B+jftDfIyTXqR
	 i1CJ0Vk1j6KxouCaKcl551GP+1b5WSbmDukUSNLPB4ngpo8vPX5NF/s524rsNomJeX
	 z+vY+QayK72qAdqqbnFQ4nKLNATumWPIOl8R+LJs1SCisiTRrPC/eoR/904etwBjdw
	 4sR4aGW14PiGXnu6eLTJeh4/fy73w6GRzI1Ak7AkrWlzhS1xgcFvma8GpfkMYyawh4
	 Cu8TqYrDiKNKg==
X-Pm-Submission-Id: 4gQhGp2ncZz2Scpy
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
Subject: [PATCH v6 0/4] rust: helpers: add SRCU helpers
Date: Wed, 27 May 2026 23:35:31 +0300
Message-ID: <20260527203615.163688-1-work@onurozkan.dev>
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
 include/linux/srcutiny.h |  13 +++
 include/linux/srcutree.h |  24 ++++++
 kernel/rcu/srcutiny.c    |   2 +-
 kernel/rcu/srcutree.c    |  25 ------
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  39 +++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 249 insertions(+), 26 deletions(-)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

