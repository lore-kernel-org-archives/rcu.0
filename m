Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B312E7F;
	Tue, 14 May 2024 16:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705681; cv=none; b=ELLNRqzWb3QSa5lq+pL4n1GzLtKtR9rlDzEDdseK5uaFuBEm3IvoEy28bdqhA8WYH+IXmESYu7towGEA1YgV/gtBouS/G2W2r15sNNA486BG8Unyn7g9VkTwnCZKs5xj+oHUFPsit5njoY+MRu3WBICB5GfgdDg0qndW2UbZQyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705681; c=relaxed/simple;
	bh=h8R6NGoxB75DYclazRjbVGVue2yl59BqjU5CnXXHtYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxlbiU2FaGhusDvyMss2nWW46FVCFfSelTJUfyJT15x+godzjl340e5+Qho4QuP6OLwBq/Of0hefv0SAulDCZe1te7KtYzxeKN4VIrhtwJxOUQ7QuL92zeKYnMKY2dIYqVC1Jl7QpUYPDA32f7Zouo2q/uhLcTu7UETTh4FLKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzJjA6Vj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzJjA6Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF41C2BD10;
	Tue, 14 May 2024 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715705680;
	bh=h8R6NGoxB75DYclazRjbVGVue2yl59BqjU5CnXXHtYE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VzJjA6VjUCDHRNyUYb34ratDyWIbZRUNyFy7PCrdVRi1Q1DOgd2TbzfVCO6CqwyjJ
	 CnSw2VMLLhJaskf2wIZQYIg0yGo5reye/xcpPVjbh7m7PMU19rcNfbwIjun5zV75s1
	 drRVVyKzOVSvf8t8SawtCBGcfifGpTzFVZVRVpQnCtEfQ0/nv4rnacZ9NT6FS1BGGi
	 6cbBlDjkKHDr+a8+VptoIwlY/+RyWhyw3iXpn2i07FUDGK88dYW5ASTQKFCgFmHqs9
	 f3OyKH5ck9XSapoUp+WiN0DFpvDZRy6+kAr63ZghE45mDorQYXqxtf19o/2o191+1Y
	 GhnwtjMC+zciw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 68E1CCE098A; Tue, 14 May 2024 09:54:39 -0700 (PDT)
Date: Tue, 14 May 2024 09:54:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <4ffb46f8-9b45-472b-93a8-18d0a3bba8d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
 <20240510131849.GB24764@redhat.com>
 <20240510135057.GC24764@redhat.com>
 <474ae55c-fe9e-4668-8f9b-23f819c76d10@paulmck-laptop>
 <CANpmjNMUJ6UMwWAEHfm-7WZ=jKD56PH67Zp8dB6B=fEysiK=Hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMUJ6UMwWAEHfm-7WZ=jKD56PH67Zp8dB6B=fEysiK=Hw@mail.gmail.com>

On Mon, May 13, 2024 at 04:13:35PM +0200, Marco Elver wrote:
> On Fri, 10 May 2024 at 16:11, Paul E. McKenney <paulmck@kernel.org> wrote:
> [...]
> > > > Does this mean that KCSAN/etc treats the files in kernel/rcu/
> > > > differently than the "Rest of Kernel"? Or what?
> > > >
> > > > And how is it enforced?
> > >
> > > I can only find the strnstr(buf, "rcu") checks in skip_report(),
> > > but they only cover the KCSAN_REPORT_VALUE_CHANGE_ONLY case...
> >
> > Huh, new one on me!  When I run KCSAN, I set CONFIG_KCSAN_STRICT=y,
> > which implies CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n, which should
> > prevent skip_report() from even being invoked.
> 
> The strnstr hack goes back to the first version of KCSAN released in
> v5.8 [1]. It was added in response to Paul wanting the "stricter"
> treatment for RCU even while KCSAN was still in development, and back
> then syzbot was the first test system using KCSAN. Shortly after Paul
> added a KCSAN config for rcutorture with a laundry list of options to
> make KCSAN "strict" (before we eventually added CONFIG_KCSAN_STRICT
> which greatly simplified that).
> 
> While the strnstr(.., "rcu") rules are redundant when using the
> stricter rules (at least CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n is
> set), we're keeping the "rcu" special case around because there are
> test robots and fuzzers that use the default KCSAN config (unlike
> rcutorture). And because we know that RCU likes the stricter rules,
> the "value change only" filter is ignored in all KCSAN configs for
> rcu-related functions.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcsan/report.c?id=v5.8

Thank you for the background information!

> Back then syzbot occasionally reported RCU data races, but these days
> rcutorture probably finds all of them before syzbot ever gets its
> hands on new code.

I do try my best.  ;-)

							Thanx, Paul
