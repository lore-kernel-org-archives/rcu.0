Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CB38F950;
	Fri, 22 May 2026 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428567; cv=none; b=VN6t2414dxtLwelRu+VtOnH49280/RxViu6Pe1KGQ0mf4zqaD14jl3yweeMnKC5ot2rTxMJcXHJiaORjhKPuBTkip27g8LWO7YEalYSaaq3fU1no4VzLBrlbOqFd0DJUZqHp6KnHxhC6ZMshn4hTWisRcExM9Y9/xALSUaOVFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428567; c=relaxed/simple;
	bh=ZdSo7q0h+G5d0AtWUNVGcWyAM6/B2vbM5v8xjiOZvUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H7UnxeBCdyTHa9aTa0qMgazyUcXZ+kUYHkhf9bI7L/Al74vHrmQmZ8jrBgYsRHaUkgiyFHVv0dBAZGy2nDoQxIPJnZjieECcN2dcuDsut8Ti0/etSSZrhQjm7rHIxezFpFtug5pcCl7FQLDRuVy28AYjA2RZ/VdUBXDo3h0Bsdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=t66W2zdL; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="t66W2zdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1779428556; x=1779687756;
	bh=CgbgODZxQ+O+/Ax/2RjpziSsqlgJGy5B1RlFPWxXGP4=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=t66W2zdLIsptFdrBzjJnO8TGrKelPsf7CIHhgJl/RPl9GzMAO0GoD3YcOCOGdo9dt
	 wPWB6GFuBTdcFYy51ajJRmtIlMz0y7q6Qv8ju4C0rCL6HbVJ78C0x+r4EgR6Z7Fpvl
	 1wFFsYR+dWh1CmPS2ewsnN3A1eCVGEplvoGSYvp17Tqj8uMqG93S34DTpJqq0uj+YP
	 4WIRpA6leWvHYYxCOJvLVrytl3DErY7b3P4S3iv/7vVPLW9MK+2YW8jE5bDoWB9F/h
	 8xBQTVhNJu/dZZN/ZE40tMZ+y5veEmnvcNL9/HEObpAddZyI2ydV54Rnxo8cjbE0ed
	 PA6I12CrH17fA==
X-Pm-Submission-Id: 4gMDgq1cChz2ScPj
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
Subject: [PATCH v3 0/3] rust: add SRCU abstraction
Date: Fri, 22 May 2026 08:41:49 +0300
Message-ID: <20260522054228.114814-1-work@onurozkan.dev>
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

[1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.dev


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

Onur Özkan (3):
  rust: helpers: add SRCU helpers
  rust: sync: add SRCU abstraction
  MAINTAINERS: add Rust SRCU files to SRCU entry

 MAINTAINERS              |   3 +
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  24 ++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 156 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 186 insertions(+)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

