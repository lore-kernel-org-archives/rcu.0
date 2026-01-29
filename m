Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD861FF7C7;
	Thu, 29 Jan 2026 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647674; cv=none; b=Bi+qYMq3G/zPhJIJgjw7QJKL7XQcPcCODhcmOm9Y3X0pWj58A+2yGeWBZa/6MOQxpFKI7qlakuRFpQn5AlR/JLpB8WB0EQ6iPU+RX62GLcShfYUlwh+D2QEuMAC3bTyYutLvHwbFwdXNi8clIe+hCSZoUrZMr6QtUn4LrRZa0HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647674; c=relaxed/simple;
	bh=s1xvWyNrritNLgbPhI5qFzhOWX5vOBvdf8aR2I6/q7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkgyuLSHRW1o5qygESpw70U1kDm73iGB06gmJZeGjqKcuj3dkYR0M5frsIWg1By7fSKjpBu8cHSVDeTpe8RVmJccAMoeiJ6Y5gJbqTJbO7sjhtM7uOsFdO5IGX23zpOUuHVEkNvFRTkTkoITMv3ngtDTE5fG+rQ2n3Sy3U7PsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MI4f0ydc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MI4f0ydc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104EFC4CEF1;
	Thu, 29 Jan 2026 00:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769647674;
	bh=s1xvWyNrritNLgbPhI5qFzhOWX5vOBvdf8aR2I6/q7E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MI4f0ydcwX1l4tksHLQtm5GrKRQFB16OS8Kv/MCbGwMXnLxv6NaawT2uVdVu5lnhM
	 Cc7mGEyORMhuuV9nTaOFFB5c9No/ICkIYLuw1D2znos92xm+Ww2x794KSLk1rbTxUj
	 szF45IvUMQq6sPVqyEahbF3G/GKDmmndZRxW1KNj9R6PbtgobUqFuVg69zXCNIFKMT
	 3ORFIrurA4OB0tFoS1Hg1selYoMmtpPKQcxTG6s1l3t0eVMJZiM0UWckXYXKaaXoD/
	 6O7lwn3BmiAR8J145t0a2e6cFrWQk7WnX6QdPEqo8OdOYLuNHxAIQpxHhkcOTj2eIc
	 lMcyAZ1m9m6qQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97F05CE3907; Wed, 28 Jan 2026 16:47:53 -0800 (PST)
Date: Wed, 28 Jan 2026 16:47:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Lyude Paul <lyude@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Miguel Ojeda <ojeda@kernel.org>,
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update my email address to @kernel.org
Message-ID: <cb8548ca-286a-498c-a427-ef5b07803e55@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260129004520.62697-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129004520.62697-1-boqun@kernel.org>

On Wed, Jan 28, 2026 at 04:45:18PM -0800, Boqun Feng wrote:
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

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
> -- 
> 2.50.1 (Apple Git-155)
> 
