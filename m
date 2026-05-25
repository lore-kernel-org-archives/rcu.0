Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F2533C183;
	Mon, 25 May 2026 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731846; cv=none; b=N+ZpZry1NJcz+G7pFxEB668TiQ8sT7inAd5KOCjeSzsT8GbZZeIkDjN3gtYFeFTAfX5oEeEbTk93e+4N3HvbHbeQqocY56aphk8N+RMCcMrbGEptJnFdwrsgTjlWpnC2mlaoB/9qhF/YeKdX8y2hmtcn8xdabnc0Sppxv+ewk4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731846; c=relaxed/simple;
	bh=5ag0g8Pe8hw3uGFtksZfZPxzgoKI/HUoxic9q1ce2Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gSMjT4+P/e+CIR6YU4q/dtKdhuc2+UbFGzU4flvWfSfCaz4pawMpIvdHhxs2wLYd4cXmNbxTtzurUa4dFpo9VZ/2CYewXKJSlRgdmAY8fxfMzGlaIijE2roKxbe0AG7GP3Gt4BdhfNk43CjhoQ8pr0jB4+Kwz9ikCxsLreOs6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=AsTVVizs; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="AsTVVizs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779731834; x=1779991034;
	bh=XpiSBDTqN+PaCF5N+vNz4MkNWtuoqKEfF4wHRVdIqZs=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AsTVVizszxE9AbLvKjEQ+8iggeZ+v75kfY7indVlIVzH3Dt7Kmf5suN0DhWPQIkXN
	 ByL+vUwqvBa1s5IPmZWEGw8AQLocKgYp6Ks20Sj4JE92ayLZkFhIPuuUcI0YnFMSWR
	 wFAhILkWpcgBd9xHCtO+95X3uLbcae46pQ5/HtNF93ZafFL7SW1AcY8eFk+htmlrvK
	 gbHHKy+MFF3IQCa4NNE4a4aWiLHYPBX/B2KSu+4x1CM5Dq04FTaYhqF2ely0S6psCf
	 9XJ9oADv/AAtOdOctk4A3HvinnR+wT4PX0kNR8Paw983dpu9/tmiai8DxP2dhBJEVd
	 4t4bBNvXjfBGQ==
X-Pm-Submission-Id: 4gPNr466Ttz1DH2k
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
Subject: [PATCH v4 0/3] rust: add SRCU abstraction
Date: Mon, 25 May 2026 20:55:48 +0300
Message-ID: <20260525175706.124910-1-work@onurozkan.dev>
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

Onur Özkan (3):
  rust: helpers: add SRCU helpers
  rust: sync: add SRCU abstraction
  MAINTAINERS: add Rust SRCU files to SRCU entry

 MAINTAINERS              |   3 +
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  34 +++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 158 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

