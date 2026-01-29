Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A1189BB0
	for <rcu@vger.kernel.org>; Thu, 29 Jan 2026 00:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647528; cv=none; b=b+fp/1NKeMjZTAMh8P3CMOapZypUMAV7zzYILDZIWz72QgZxO+JdhcjxZwFjqFZNMeflMR8CGLQHI0cudMbNA0UCbUrKEFBB5ia3flgyEQv5TPNIlCc8ff2LPc657M+tOD5ZBNJpvzlvAW86XeilWAyFyad/gpcwRzBwTmfoq1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647528; c=relaxed/simple;
	bh=cTn2mIy8vDJ2tWhZMYk+R0g2H0iMUDUTGMSrtXsMNKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJXmphwXBCxDvauw25xrKqY9r6iCX1Wk7OZmg2OeSMxCQ2PPeJnFbfL8mU99J3cEyQJm9OKrkdvDO8+FWqfTVUk3P5IlGaWAqJmGkBYA5S+xVX0awRKwBXJ8mefRpBqCbgFjSssPMIUHVmI7WESNRiFwMkULUOwsUpM25JPoyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhoXVhEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhoXVhEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF9BC4CEF1;
	Thu, 29 Jan 2026 00:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769647528;
	bh=cTn2mIy8vDJ2tWhZMYk+R0g2H0iMUDUTGMSrtXsMNKM=;
	h=From:To:Cc:Subject:Date:From;
	b=MhoXVhEeSRfqGFvHJvK+dwjELyp3ncZFtRpS7fVAJ6BNxEVHrSD8ETbOFXtYNTEB5
	 jxRgT+5IT8gqWMtdZfcJvNVI4Rz0P/iff6GMhXj+uhl0DCczgysU3YFfxmKym2w9e3
	 pMxVpwe0laf3eBqyTQxvDV5QsxDb0vFSucXYxlmibCujVptH3mcYsPk80a6La5VBKO
	 kfjShxWEUzN9gj/D8v9N6ZJ+CxPYKj884lyD+k5pnMKzY3S2EniE5Gjv9jCjv5HlFS
	 au4RDky4msMtz1Lor6Mxsxtn4Fad9XYelj34sqmDvkfJk44oJzBGdtyOgXndyPsHJ8
	 ygGwBLxMTO3Eg==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0826BF40068;
	Wed, 28 Jan 2026 19:45:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 28 Jan 2026 19:45:26 -0500
X-ME-Sender: <xms:pa16aYqxBG0p_zMCwvZUx-6GGIbBiduM5vVbuz6pC68E29oLo9nM5g>
    <xme:pa16aTSzwMyyYSwQLXSYW7ptisAXWiBOuJrCdZXZBo8Gu6SBVRvkid5m2ZdSbluvU
    v6tVm8L8-4jkyMg4cGEQn0wW8k_A8gq_AaOkj_6MV8GyWcF_lvqqQ>
X-ME-Received: <xmr:pa16af5tcN_ry_8HzXHExdD5q2HoVEBovaJdnCNpPrCuu2KH1b1nFVofv33KiBPzPSikfTFS-FYBJxr69PncdJYhI-dPoLJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    efhfejudeltdejjeduheetvddtveefvdevvddvhffffedtvdevgfegfffhtdfgnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomh
    gvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddqudejjeek
    heehhedvqdgsohhquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnh
    gspghrtghpthhtohepgedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepsghoqhhunheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvg
    htvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhl
    rghnugesrghrmhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:pa16afOvhmLkFz80Yrra0oFp5ihfZdMDKyA10muqYyOTxDcoFeF5rA>
    <xmx:pa16ad8sBCZauiiCqq0bx23-GROo8waXwS_JqtGU9WI7JP0gwnwDaQ>
    <xmx:pa16ae6pW4PqO84IJuVQvIT01b-OvwzTolL9qlDDg67y-ZhH01piEg>
    <xmx:pa16aTl8HulZ6ddVURO63xEovzz-Z88Hgh4rfG5MYNwEGJvDf3fnBw>
    <xmx:pq16aRG4XVIxHufVmvsPONxkS3yv85PbDQJ9d7iSpYQPg7Sxngs7oL6i>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 19:45:25 -0500 (EST)
From: Boqun Feng <boqun@kernel.org>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: Boqun Feng <boqun@kernel.org>,	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,	Gary Guo <gary@garyguo.net>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,	Daniel Lustig <dlustig@nvidia.com>,
	Ingo Molnar <mingo@redhat.com>,	Waiman Long <longman@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,	Zqiang <qiang.zhang@linux.dev>,
	Miguel Ojeda <ojeda@kernel.org>,	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: Update my email address to @kernel.org
Date: Wed, 28 Jan 2026 16:45:18 -0800
Message-ID: <20260129004520.62697-1-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I had issues using my gmail account multiple times this week, hence
switch to @kernel.org.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Gary Guo <gary@garyguo.net>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 .mailmap    |  1 +
 MAINTAINERS | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/.mailmap b/.mailmap
index 84309a39d329..ea3ac46aceda 100644
--- a/.mailmap
+++ b/.mailmap
@@ -153,6 +153,7 @@ Boris Brezillon <bbrezillon@kernel.org> <b.brezillon.dev@gmail.com>
 Boris Brezillon <bbrezillon@kernel.org> <b.brezillon@overkiz.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
+Boqun Feng <boqun@kernel.org> <boqun.feng@gmail.com>
 Brendan Higgins <brendan.higgins@linux.dev> <brendanhiggins@google.com>
 Brian Avery <b.avery@hp.com>
 Brian Cain <bcain@kernel.org> <brian.cain@oss.qualcomm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 2953b466107e..5d4443576687 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4107,7 +4107,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun@kernel.org>
 R:	Mark Rutland <mark.rutland@arm.com>
 R:	Gary Guo <gary@garyguo.net>
 L:	linux-kernel@vger.kernel.org
@@ -4498,7 +4498,7 @@ F:	lib/sbitmap.c
 
 BLOCK LAYER DEVICE DRIVER API [RUST]
 M:	Andreas Hindborg <a.hindborg@kernel.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Boqun Feng <boqun@kernel.org>
 L:	linux-block@vger.kernel.org
 L:	rust-for-linux@vger.kernel.org
 S:	Supported
@@ -11267,7 +11267,7 @@ F:	tools/testing/selftests/timers/
 
 DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
 M:	Andreas Hindborg <a.hindborg@kernel.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Boqun Feng <boqun@kernel.org>
 R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
 R:	Frederic Weisbecker <frederic@kernel.org>
 R:	Lyude Paul <lyude@redhat.com>
@@ -14561,7 +14561,7 @@ M:	Alan Stern <stern@rowland.harvard.edu>
 M:	Andrea Parri <parri.andrea@gmail.com>
 M:	Will Deacon <will@kernel.org>
 M:	Peter Zijlstra <peterz@infradead.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun@kernel.org>
 M:	Nicholas Piggin <npiggin@gmail.com>
 M:	David Howells <dhowells@redhat.com>
 M:	Jade Alglave <j.alglave@ucl.ac.uk>
@@ -14719,7 +14719,7 @@ LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Will Deacon <will@kernel.org>
-M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
+M:	Boqun Feng <boqun@kernel.org> (LOCKDEP & RUST)
 R:	Waiman Long <longman@redhat.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
@@ -21909,7 +21909,7 @@ M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
 M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
 M:	Joel Fernandes <joelagnelf@nvidia.com>
 M:	Josh Triplett <josh@joshtriplett.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun@kernel.org>
 M:	Uladzislau Rezki <urezki@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
@@ -22359,7 +22359,7 @@ RESTARTABLE SEQUENCES SUPPORT
 M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
-M:	Boqun Feng <boqun.feng@gmail.com>
+M:	Boqun Feng <boqun@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	include/trace/events/rseq.h
@@ -22882,7 +22882,7 @@ F:	tools/verification/
 
 RUST
 M:	Miguel Ojeda <ojeda@kernel.org>
-R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Boqun Feng <boqun@kernel.org>
 R:	Gary Guo <gary@garyguo.net>
 R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
 R:	Benno Lossin <lossin@kernel.org>
-- 
2.50.1 (Apple Git-155)

