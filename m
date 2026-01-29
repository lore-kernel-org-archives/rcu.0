Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6C344DAC
	for <rcu@vger.kernel.org>; Thu, 29 Jan 2026 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769654954; cv=none; b=tgeL8ZlgpFJ6HjbwQ8BifY8ujvM+Jwm4cHwuoP8u74SA0JgPFbQ3WHqAGnExetg3nqtpFMcCUIX7LcN13VhbYNHkUhlvQJz9SXzCph1Ig5I+BjpkUV7Os1DoLfvqsmd5Dx5dhgLLo5EEIQbjftwL9ZxCcXjlQUxdP/pXSk/MwTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769654954; c=relaxed/simple;
	bh=FMBbSDhXFPSkid5kp1UU/j2H/F0IzMkopdtANRDylhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctCjvBJjGswKPNmTy9/v5K7CwyhVFJ/CPQ6ThWcxDRC8q1yYJcaL0VpI8pvgpuZWfXzhfLZgmFtydMFabtqK7CubIYIERpTgiPQA+dSMIh5OXR2Q/GWKrKiZDXFwNf1GB2Hl4DQe1qm1ks0PsV/KAMIjtPOMGgu2wpixXiYDz7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PmsnvBZ0; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PmsnvBZ0"
Message-ID: <2c65737c-eae9-4f73-a93e-9536d318f5d4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769654934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VBsjSopdWUaDrYJ+vyummLSqs20JInbxS9Vu3XZB1wI=;
	b=PmsnvBZ0B6KbwRRGuBaz1W1XtflOu4E93/KohZrkFORS7rhe9PTX06lzEozBDTJ57jFYVc
	rpSQDgrkEWynHQMrr9AqUCxU3MDZe5ohmF4XsrDQCLiTjmEO8sCFD5l1meTteWE53tp7Mo
	8walqbv33qOyhSztlaVHccfLnNSHn8o=
Date: Thu, 29 Jan 2026 10:47:55 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Update my email address to @kernel.org
To: Boqun Feng <boqun@kernel.org>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Miguel Ojeda <ojeda@kernel.org>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20260129004520.62697-1-boqun@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <20260129004520.62697-1-boqun@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/29/26 08:45, Boqun Feng wrote:
> I had issues using my gmail account multiple times this week, hence
> switch to @kernel.org.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Uladzislau Rezki <urezki@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Zqiang <qiang.zhang@linux.dev>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Benno Lossin <lossin@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
>  .mailmap    |  1 +
>  MAINTAINERS | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/.mailmap b/.mailmap
> index 84309a39d329..ea3ac46aceda 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -153,6 +153,7 @@ Boris Brezillon <bbrezillon@kernel.org> <b.brezillon.dev@gmail.com>
>  Boris Brezillon <bbrezillon@kernel.org> <b.brezillon@overkiz.com>
>  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
>  Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
> +Boqun Feng <boqun@kernel.org> <boqun.feng@gmail.com>
>  Brendan Higgins <brendan.higgins@linux.dev> <brendanhiggins@google.com>
>  Brian Avery <b.avery@hp.com>
>  Brian Cain <bcain@kernel.org> <brian.cain@oss.qualcomm.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2953b466107e..5d4443576687 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4107,7 +4107,7 @@ F:	drivers/input/touchscreen/atmel_mxt_ts.c
>  ATOMIC INFRASTRUCTURE
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -M:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun@kernel.org>
>  R:	Mark Rutland <mark.rutland@arm.com>
>  R:	Gary Guo <gary@garyguo.net>
>  L:	linux-kernel@vger.kernel.org
> @@ -4498,7 +4498,7 @@ F:	lib/sbitmap.c
>  
>  BLOCK LAYER DEVICE DRIVER API [RUST]
>  M:	Andreas Hindborg <a.hindborg@kernel.org>
> -R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Boqun Feng <boqun@kernel.org>
>  L:	linux-block@vger.kernel.org
>  L:	rust-for-linux@vger.kernel.org
>  S:	Supported
> @@ -11267,7 +11267,7 @@ F:	tools/testing/selftests/timers/
>  
>  DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]
>  M:	Andreas Hindborg <a.hindborg@kernel.org>
> -R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Boqun Feng <boqun@kernel.org>
>  R:	FUJITA Tomonori <fujita.tomonori@gmail.com>
>  R:	Frederic Weisbecker <frederic@kernel.org>
>  R:	Lyude Paul <lyude@redhat.com>
> @@ -14561,7 +14561,7 @@ M:	Alan Stern <stern@rowland.harvard.edu>
>  M:	Andrea Parri <parri.andrea@gmail.com>
>  M:	Will Deacon <will@kernel.org>
>  M:	Peter Zijlstra <peterz@infradead.org>
> -M:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun@kernel.org>
>  M:	Nicholas Piggin <npiggin@gmail.com>
>  M:	David Howells <dhowells@redhat.com>
>  M:	Jade Alglave <j.alglave@ucl.ac.uk>
> @@ -14719,7 +14719,7 @@ LOCKING PRIMITIVES
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Ingo Molnar <mingo@redhat.com>
>  M:	Will Deacon <will@kernel.org>
> -M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
> +M:	Boqun Feng <boqun@kernel.org> (LOCKDEP & RUST)
>  R:	Waiman Long <longman@redhat.com>
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
> @@ -21909,7 +21909,7 @@ M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
>  M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
>  M:	Joel Fernandes <joelagnelf@nvidia.com>
>  M:	Josh Triplett <josh@joshtriplett.org>
> -M:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun@kernel.org>
>  M:	Uladzislau Rezki <urezki@gmail.com>
>  R:	Steven Rostedt <rostedt@goodmis.org>
>  R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> @@ -22359,7 +22359,7 @@ RESTARTABLE SEQUENCES SUPPORT
>  M:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	"Paul E. McKenney" <paulmck@kernel.org>
> -M:	Boqun Feng <boqun.feng@gmail.com>
> +M:	Boqun Feng <boqun@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  S:	Supported
>  F:	include/trace/events/rseq.h
> @@ -22882,7 +22882,7 @@ F:	tools/verification/
>  
>  RUST
>  M:	Miguel Ojeda <ojeda@kernel.org>
> -R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Boqun Feng <boqun@kernel.org>
>  R:	Gary Guo <gary@garyguo.net>
>  R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
>  R:	Benno Lossin <lossin@kernel.org>

Acked-by: Kunwu Chan <kunwu.chan@linux.dev>

Thanx,  Kunwu
