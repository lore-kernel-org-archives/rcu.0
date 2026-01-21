Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6593587D7;
	Wed, 21 Jan 2026 19:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022554; cv=none; b=sFNfX8mqJOAHJOBIJnxHCdlRyZYsgC8mKQnOtbbb2tXNKwOchagKj+SHDOMnzXaztFWAePR8/EPMW4a7HYFnnWmvMIVF0+47PKiNWuSWpt+ljrCo7TEVD3YD3EUPqa5YKGVuedvauYI9FylWywwNrW1siPzzOISLJTcvWUSczJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022554; c=relaxed/simple;
	bh=VRHwvTIiCpc1r/zuGyEnF4fetNLFt59j8Kn42NiJ658=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2XbpiQ2bpNmdnbR0HYYZzXlswSiO2jUMjTdQMJQXtwU4CZw7G3EyStdjPy1ojC48TxcIqCzm+k/B8PDAtDd7rCZv1AdnX4m/PutHKWZT6D6Tf7aEhjEsNy0lXiDdXxSWzQkYf8hUXrQde+b/8gogiyneFCwA3v8mAcLPORAdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbN4YGa3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbN4YGa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DB8C4CEF1;
	Wed, 21 Jan 2026 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769022553;
	bh=VRHwvTIiCpc1r/zuGyEnF4fetNLFt59j8Kn42NiJ658=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=IbN4YGa3wCLcKtr3qFbiSRnwbVPpKUKi36zXet8WYy4jKkGTuczwd1CbqCc/deS7c
	 nF73Ll468DN1KH0gYcxR2iFVQiFXhpnkmeCZ7Hf30CZHIWvUnu0nZWGvAvqwZOadsl
	 Z6SWiKADjY6018gEWDN8ssS1ukK7cU1mha7TvAd0t1kc1+aYuErZ+8lXW2BjRmXJk/
	 aiB0UMtc4gKKdRSYlt6oF7SnQvIYngXTrdaG5mD50T6z2BCB5n7/I2LOp1pXXJccfd
	 aBo0QCGn/v32M/9NzqA3b6/2v9GtpIGcKVe95WNT+e6dfrgmHjme0b3oEQHKRyOVi/
	 A4jVf821GH80g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 73E87CE0B2B; Wed, 21 Jan 2026 11:09:13 -0800 (PST)
Date: Wed, 21 Jan 2026 11:09:13 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	rcu@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH -next v3 0/3] rcu/nocb: Cleanup patches for next merge
 window
Message-ID: <f568bee5-9cda-40bb-977a-a9063bd2c611@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260119231223.989409-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119231223.989409-1-joelagnelf@nvidia.com>

On Mon, Jan 19, 2026 at 06:12:20PM -0500, Joel Fernandes wrote:
> These are a few nocb related cleanup patches for the next merge window.
> 
> Also Frederic please object to the second patch ("Remove dead callback overload
> handling") if you would like, but I think based on our discussion I have
> implemented your suggestion, so it should be good.
> 
> Changes from v2:
> - Dropped patch 2 "Add warning if no rcuog wake up attempt happened during
>   overload" as it was not needed since we removed the dead CB overload handling.
> - Replaced "Add warning to detect if overload advancement is ever useful" with
>   "Remove dead callback overload handling" per Frederic's feedback - instead of
>   adding a warning, just remove the dead code path entirely.
> 
> nocb rcutorture scenarios passed overnight testing on my system.

I reverted three of your earlier patches in order to apply this, only
one of which I am really confident in.  Please check my -rcu tree to see
if any of the three should be added back in, and I am starting tests in
the meantime.

							Thanx, Paul

> Link to v2: https://lore.kernel.org/all/20260114173154.1701056-1-joelagnelf@nvidia.com/
> Link to v1: https://lore.kernel.org/all/20260101163417.1065705-1-joelagnelf@nvidia.com/
> 
> Joel Fernandes (3):
>   rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake path
>   rcu/nocb: Remove dead callback overload handling
>   rcu/nocb: Extract nocb_defer_wakeup_cancel() helper
> 
>  kernel/rcu/tree.c      |  2 +-
>  kernel/rcu/tree.h      |  3 +-
>  kernel/rcu/tree_nocb.h | 80 ++++++++++++++----------------------------
>  3 files changed, 29 insertions(+), 56 deletions(-)
> 
> -- 
> 2.34.1
> 
