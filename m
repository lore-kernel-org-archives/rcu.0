Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC402A1C0;
	Sat, 28 Sep 2024 11:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727523125; cv=none; b=IMGUl05Z0y6J7eh6EpdmXLZfHbKVCYbFXbYYEPPRKS3G1pPqBsuD2qToqi494+E5k40edoEaotH2/05NVNEt0/K9hADstMi/5lvDpqZKpHjg81JU0PZceIWZ9hMYHeiXdVdkIxjlseXIbVn2w7YKqEvX5ceh3LrDR/UjiJ3xoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727523125; c=relaxed/simple;
	bh=bHeWdmxAD41R4bT2Y/3lIBcb9EHeesx11+ZLdT4Jffg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTW+nTWY7UpTjsGaNzPTRHT0ztNwNuvmnIrVWs0MzG0Wyw0yfxwQEIkP0k8ARU8NVnhM9q0s7iSX8dYVniJKo60CFBgDFJqIVsfot8tr/Dn3dxSb3Yr6T9mkrmhfoqmaNzL9TIWz+Kq535qSDFpaGQ+IjetaKj7z8lwGj2grnuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpPoVPGB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpPoVPGB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DC5C4CEC3;
	Sat, 28 Sep 2024 11:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727523124;
	bh=bHeWdmxAD41R4bT2Y/3lIBcb9EHeesx11+ZLdT4Jffg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PpPoVPGBX2eR4pSzBMAnS8OgEY1sFbtrJmxFGMI9/sn6QznFe9KFfXsUwtm4IT1pt
	 BBgA/iS4AcDo0yIQoEhGBiCaBNkNHVmTgtOM4ywycInYOjj60vEG+Clp0f/VQhEYfc
	 eYfrMqz922bR7lzMwic0xkNEbG4xa0hZuK/0ewmcTOg2iTTohn/sCbf8PKCzz3DAB6
	 mS620g1fhdnATICG6rrKOjoCEgdzp0a1dfgkr9rcTds/KDXH214K7KEIRcpYkRD2OV
	 gc4TSeIBvulk2tm6CgScep1nzzIs+o8YoeohVQ9onf35cs3tvemTmXOzuptwuX7w4U
	 Y+lLgIsde+kgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 13A3ACE126B; Sat, 28 Sep 2024 04:32:06 -0700 (PDT)
Date: Sat, 28 Sep 2024 04:32:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <55678fb6-4476-4e25-82d5-5d5ad5b7e7d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240927203334.976821-1-mathieu.desnoyers@efficios.com>
 <23882bd6-c0e0-4f6c-9000-b79216194198@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23882bd6-c0e0-4f6c-9000-b79216194198@efficios.com>

On Fri, Sep 27, 2024 at 07:05:53PM -0400, Mathieu Desnoyers wrote:
> On 2024-09-27 22:33, Mathieu Desnoyers wrote:
> [...]
> 
> > ---
> >   include/linux/compiler.h | 62 ++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 62 insertions(+)
> > 
> 
> I'm wondering if this really belongs in compiler.h, or if it's so
> RCU/HP specific that it should be implemented in rcupdate.h ?
> 
> [... ]
> > +static __always_inline
> > +int ptr_eq(const volatile void *a, const volatile void *b)
> 
> And perhaps rename this to rcu_ptr_eq() ?

For either location or name:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

There are non-RCU uses, but RCU is currently by far the most common.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > +{
> > +	OPTIMIZER_HIDE_VAR(a);
> > +	OPTIMIZER_HIDE_VAR(b);
> > +	return a == b;
> > +}
> > +
> 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
