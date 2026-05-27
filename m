Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35D13ED3C2;
	Wed, 27 May 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903700; cv=none; b=hcVdbfWMxkGEXQXRQtsgUIdDTJkm4A6do3gnTK7K0kscLlw14fAYWf0xkFKtNJ3JuYSENErlUqdJsCj9G6zX1k9u6eHk4LVnTLUVqvK/ORt3bmkJXlfeyILuSA4rWjNndQUdVRSotAz8kOsPJES+qsznjVqKFpxZBixQAZzUzD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903700; c=relaxed/simple;
	bh=52uCWsUmLNMfHoGHwCGnngx8KuftcE216Vly75hLh9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uL3CMhXSexJ0OEuGazNjgEke2e91B5aCbYCnmgduqycDO46UxSXCgeSHpfhu4RRUWw86Aa9D8VHI661eTR/GJZs5ASa1MPDWqdZd0fQCoec0PlG6HLMTVGvt9CoqDm50b22OMQcnBYOjTp+McST4uKlvZCct2K0aQfPuUCYxM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=gk83a0PA; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="gk83a0PA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779903686; x=1780162886;
	bh=PbSUQvIb+Oq1KJM9n5lo/LkaYdQ7Z2EbFlFrlD3NkFI=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gk83a0PAgbxbbWZ1K73y3rCsspBZzo0XSI3/8psKJVH9tj0qwcTMi9fvZCtem+mqs
	 DGTyyuDaGI2EqvzX+CwPwt6El/XocCIYbCIYgvNDKut810q5v+vghc/vuaxGdB1gXB
	 boLkb7lqFGemt9X2G6tPH7BczXZkom3g+jq7MMAk3ELYhS9PU/uatcv/y8jizsGHF9
	 6gWXvCqBykG8vO1lrz6okWKtQA23HndcISfrEUp3F2oyv1OcNCikZJD1zf56RCAYMY
	 PI8K9Pt3JDiJBh5uC+evC+5vE0TubfYvUy6K1K4Kn9opHtk6eedP8/G/kqBKqiNfjA
	 GuoiXO2ezqJJQ==
X-Pm-Submission-Id: 4gQcNx4DCfz1DF6x
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
Subject: [PATCH v5 0/4] rust: add SRCU abstraction
Date: Wed, 27 May 2026 20:40:41 +0300
Message-ID: <20260527174120.510447-1-work@onurozkan.dev>
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
 include/linux/srcu.h     |  29 +++++++
 kernel/rcu/srcutiny.c    |   2 +-
 kernel/rcu/srcutree.c    |  25 ------
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  39 +++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 166 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 241 insertions(+), 26 deletions(-)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

