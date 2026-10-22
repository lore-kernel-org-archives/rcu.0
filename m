Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635643;
	b=4WPEzy8V0OOog8xDDA1x2fgPQFqliTsQTDuFH9cR7wQ0MaOF9i69RdPRRmFNNj/NewZ/
	 kQxZHiDNSEcdRor7bIUDa4fXkbUz6BnWr670YO4Tn1d9I0jHvGHchXamlTltD9QRwG8MG
	 4afGzFzt165WcFAjsNCfyyJlqNmj+r/ATuI4dyjBLTpHp0bkTNwEA13GHzFz8GL9njSk/
	 e0WE7DcvQITRb6/7LEHzKxTOD8QXRPSBnwzPJ1Mab2pap4xpO9+LxIwQa8ynFOwQPFPCd
	 f/DfTJ2ZMVSx9VmVGOg5v7OwYmGySGJ8PQB+iDTwsKKvwxVVjq8q8G+xxCyenaLcjtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635643;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=VS++8lfv+iUGyzWiCyTunJ6v+1pwljGGEpWgSHzeWGA=;
	b=09MFGQojuQ5mGfOAgTX8QBo9QstavnzbFeoz638bOpdpfd6SIHyjSpVkEnq1excfS469
	 Qlbf/CgXtCtY3+Kqp2p/DBP8z77R6v6BGDNU2rZAhQj5opnXVK4sYLH/HuuELcKmhExDH
	 nHh6dVr49Z9KvhGrdnNp4bChb1MyiehU7CtwaxIJwRBWKR9/4hFzm9uDR59O2wnqxEvdG
	 wsa3wd7hewERa0A0AJRcDlpHEMKLkEQr9VxIZJNzjgt5NQtDLNjs+h/hCSTDM744K+3cR
	 9Z+PzaLSHybN9ggUPEdNaD8rkKiWXWs0ZBZvN+oq5fCgM8P9PnF3FsxzKNWd0drmdnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I01uq+M4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A208606A321;
	Thu, 22 Oct 2026 02:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I01uq+M4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE2A1F000C4;
	Thu, 22 Oct 2026 02:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635642;
	bh=VS++8lfv+iUGyzWiCyTunJ6v+1pwljGGEpWgSHzeWGA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=I01uq+M4MF2R+13xVFh0pwHiuZaQA1pZxaI3GUHbdqOAMJmd7Zsh9hiubNEeE1eCF
	 BPY4MlkuWPOOrHhPHru3hQTSrvq6Im8B5TfnxFGOnT7vjkJT8NQFAJZDn5iVo2jrYX
	 nCPwZdgO4AX/CNx8f9kX9eodI+XO6q/xNhckRw45CcZWN7oHE1qwJdh7F5/zVNVpKH
	 AmvPGF/P4N4NMiq+ZBWtygbmz+JrPrzll5so+U0/+/IZZ+2ZVfM/1Hx1TmlZmvWoDQ
	 AI5h6TrviajeqLa98HjtdKuoRvm5w5M06l+mlj4F/ThJxN56RKKEc7bj7kSFQYxh3G
	 ACiOASFnEhucQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6BAA4CE1E08; Wed, 21 Oct 2026 19:20:42 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:20:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	Bradley Morgan <brads@mainlining.org>,
	Kunwu Chan <kunwu.chan@gmail.com>, rcu@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC -rcu/dev] hazptr: Record per-CPU slot owner after
 claiming the slot
Message-ID: <e0145c14-9d6a-4c91-816c-57dabd98879b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261019161852.12783-1-parri.andrea@gmail.com>
 <4defa4de-ab42-4809-9645-100cad68972b@efficios.com>
 <fa16d2b1-594e-494b-8cfc-9b8c13f2c223@paulmck-laptop>
 <20261021090753.20442-1-parri.andrea@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021090753.20442-1-parri.andrea@gmail.com>

On Wed, Oct 21, 2026 at 11:07:52AM +0200, Andrea Parri wrote:
> On Tue, Oct 20, 2026 at 02:12:09PM -0700, Paul E. McKenney wrote:
> 
> [...]
> 
> > Thank you all!  Queued for testing and further review.
> 
> Thank you!
> 
> > Andrea, on your KUNIT reproducer, is there any chance that this code
> > can be folded into the existing hazptrtorture.c work so that it just
> > gets tested automatically?
> 
> Yes, though not as it is: the KUnit test relies on a test-only hook
> in __hazptr_try_acquire(), which I would rather not add to hazptr.h.
> hazptrtorture already has the interrupt side, in
> hazptr_torture_acquire(), but its readers rarely reach
> __hazptr_acquire(), where the race is.
> 
> So v1 of the hazptrtorture series will add, as patches 2 and 3:
> 
>   - two CONFIG_HAZPTR_DEBUG checks of the recorded slot owner, in
>     hazptr_release_debug() and hazptr_note_context_switch(), and
> 
>   - a nest_acquire module parameter (default 2) that makes readers
>     take a second, nested hazard pointer through __hazptr_acquire().
> 
> Without the fix, PREEMPT and NOPREEMPT then report the race about 6
> seconds after boot; with nest_acquire=0, they run 10 minutes without
> a report.  The nesting costs about 30% of the readers' loop
> iterations, so it could instead default to zero and be enabled from
> the scenario files, if you prefer.

This sounds like a good approach, and I am looking forward to seeing
what you come up with.

							Thanx, Paul
