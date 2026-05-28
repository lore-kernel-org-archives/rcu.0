Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch [79.135.106.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C193314D2
	for <rcu@vger.kernel.org>; Thu, 28 May 2026 06:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949706; cv=none; b=nT8h8qALTUyoOFjD8+sxojpRzyFoAGv4n+N1jxrG5YVcrsDSFcKjARZKYpAqJXk2UJOGP7hVDxPiXSwj+kTaJx8cs05qaB/TfZLiLagMeMPCNRlQEfAGz4piaOR13yfVmQgZ3twLLdRVi+ePkT3o76urV59whfGEbrZFU0hw0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949706; c=relaxed/simple;
	bh=r9OTM24KA6NX+bhS8hKOgq9wzzId73OfMpI5oy17eWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j5Oak8YLTO/sgSxDnvbqH2nMdA0gNBw6257k8br+gvYB9d0iUZItvIkk4AsxWZHbrtkZx4G6WjoIAJyJ7tf9y0ar7FwE1hSC3nKoJW4ncBRwDLbwvDdZE3OgX16DqjTpqZhzJA2C+uIHieH36ilFdQWWtNlgS7a12e032HY3z84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=dvOiq3vX; arc=none smtp.client-ip=79.135.106.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="dvOiq3vX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779949698; x=1780208898;
	bh=Ee42yZhShWZECuGcP1k6WHYqDjh9zHjbNXLjINc6/9A=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dvOiq3vXda7bb35LZgdhC5v359D/Nz0JIr0XDeAzTkn2j94fr+BmQEaoVVBhTT1l6
	 OcptNjx7YNf6JC1OAaWR2eibrpY/RsK5xKrHDUquYvK10I/8i6EnQM35HfUqqbVqg+
	 A/grOhLeG2k+0IPsbzRV9aME6Uyzm75hlBig12pPs/gnFPjneKybCEXHcqK8hRaG/1
	 MHmsVE43CbQZRGEhq6l1zuitNdGEzq6aBbmPp/lmT3COcbXtjOgRXmi2LB76ubY5fj
	 zFfyzyQtnax36ndn+yCMjhlqGUGeR0IFsdG+zEFzeAEZ9hKRX9FqVM5D+fMWe7P67S
	 WfyghnPsfHfyQ==
X-Pm-Submission-Id: 4gQxPm2l2jz2ScpZ
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
Subject: [PATCH v7 0/4] rust: helpers: add SRCU helpers
Date: Thu, 28 May 2026 09:27:32 +0300
Message-ID: <20260528062810.256212-1-work@onurozkan.dev>
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
 rust/helpers/srcu.c      |  35 +++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++
 10 files changed, 250 insertions(+), 26 deletions(-)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

