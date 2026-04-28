Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C673EDAC5
	for <rcu@vger.kernel.org>; Tue, 28 Apr 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372503; cv=none; b=E4Pzb3unnC5CJ7uUhGglwCIYPG24FjdVEN1W6+prQ3eHs8vRDVb3pO7+os8zVVI6zw6Y4nzIQ24aZkvj4Cygo2lCJCYekpVvnHjxFb9XkApfThUxoMaJHI7aqLJAyIodAIami3jw15Bud3Dl+0kA4nepZuEwPNhkkooXPazQ4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372503; c=relaxed/simple;
	bh=zc0PVa0wStocrJTRGk3zNrN7vUwMURbQ8m0Mo36m8HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PhOMgfYKadX+uaWEF399GcTYxbAiouuBlmf3UT5kJSdtFVC6rDZY6fnGqXuuoekiGpzae7aE5lPKmHukqHDk6cgTraiytwjfbtVEth7aoxF7RB3ZGjoHwXbTny5Boi7bd/ipOmFttwc/qUbl9K6ESKByJCXmFnXkOEswgswl/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=K0I9MiQO; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="K0I9MiQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=protonmail; t=1777372484; x=1777631684;
	bh=3tBcphaWLZwdT5az17P+ae+vs9M+THwDeWukgGLTHlg=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=K0I9MiQOBjE+h6tBd6FDoU5HE27weakIy0O7q9u6Wf5I7htr6RYv2kxUYlccOIRVR
	 Y/uUgaMEYOU4c48FB9kbKi1tPPL+ovpbR6aliYsevpNyFqd9tXinThmZh0ev+kqV8D
	 V7aOIy2hTK0aj+NFLc3UpQbH+fq10IBRe8tDP0lxB/wix6Hd6+nSzsFgQcbfe8ymMx
	 3W+bHz+qoT4IIXttVeUiawi4Ax0VxomthQg0vJsC0sPUdZJn3u2VeewyKVGZGeey+M
	 coOfZWkGe+edfLX7tVQskI7pd3xPD3Bl1UlW06GO6buGDVugdFSt1mzvOBp1acEuVx
	 at/DtJ7Bse8Lw==
X-Pm-Submission-Id: 4g4cJ04zQRz2ScpS
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
Subject: [PATCH v1 0/3] rust: add SRCU abstraction
Date: Tue, 28 Apr 2026 13:34:34 +0300
Message-ID: <20260428103437.156236-1-work@onurozkan.dev>
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
paths. That reset series started to require too many independent dependencies,
so this SRCU support is split out as a standalone Rust API to keep the reset
series focused on the reset logic and easier to review, rebase and land.

[1]: https://lore.kernel.org/all/20260416171728.205141-1-work@onurozkan.dev/

Onur Özkan (3):
  rust: helpers: add SRCU helpers
  rust: sync: add SRCU abstraction
  MAINTAINERS: add Rust SRCU files to SRCU entry

 MAINTAINERS              |   3 +
 rust/helpers/helpers.c   |   1 +
 rust/helpers/srcu.c      |  24 ++++++++
 rust/kernel/sync.rs      |   2 +
 rust/kernel/sync/srcu.rs | 121 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+)
 create mode 100644 rust/helpers/srcu.c
 create mode 100644 rust/kernel/sync/srcu.rs

-- 
2.51.2

