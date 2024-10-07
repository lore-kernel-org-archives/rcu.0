Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12F814AD17;
	Mon,  7 Oct 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728297779; cv=none; b=dmvFm4gV33mNrmW6WWriekxl1blyxwxP0I6S2JnlAD0y3PjY/PD37PMMKABdIhjCpbfs9p+3LsUXDykVzmeotQGV1L0oSaodxTm5ADPHU3sg4rh8C1+N1vdwaWp8Lni4Wb/Who2Lpox/ZnbSOvzP9qtC662jm/gYlckb46Pge7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728297779; c=relaxed/simple;
	bh=njbck6Ml0PEjAxLYmHKAGsbYIxEvGaAHvYTs36bXAQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+U8jLcoDOA8mcwHFBsOdERrFMAlxGSmDsme9aV4TArJ7RNR996eVx5CINsuzWNwasdQPzR0CL/CNYcoz2RfcjtwUynj8anrBeBJPc6OJ7NDzL3ASz2kvMHtII3pqaeUWJNkSCjw4bD7yFnjRGB7/An98ZPoP+0JQSfBV2KEc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p0EXI4/V; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p0EXI4/V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g05qBTGyZVIxUFe0rYd3vtXtUIDafbc2+oZifH/Yg1U=; b=p0EXI4/VR/FUuQlAhWY7U3wu3R
	j0FqzCaS3DEniv+Xlz17Jn51ZiLfkAtmT11uvD0kwI8X0WFjDHPnWBjmSAkA6b52hWwXIN17JVVai
	xxgi8zLJajVhHl7gz6SefugIyurIgy1l7F8+0pdz9CYt0pUQZLFk2umVs7H6qw4qi9PApPv8+Y2hJ
	h1TrH3d3nVs5VrAjVrpemvtU686M+gUuk3vjzhA7v3Jal+Ani56lHEcVvvpA9h+ZUL9soyQW4dctY
	bU1Zxvr/VxmwbTCgvwg+mUegta88eIpMAmbbxeSD/JzsV08hU37nnE+RWiYIVwil54v6/MWPKderG
	vi/QoL8Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sxlCO-00000004PBu-49TU;
	Mon, 07 Oct 2024 10:42:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E7AE30088D; Mon,  7 Oct 2024 12:42:44 +0200 (CEST)
Date: Mon, 7 Oct 2024 12:42:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
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
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [RFC PATCH v2 3/4] hp: Implement Hazard Pointers
Message-ID: <20241007104244.GC4879@noisy.programming.kicks-ass.net>
References: <20241004182734.1761555-1-mathieu.desnoyers@efficios.com>
 <20241004182734.1761555-4-mathieu.desnoyers@efficios.com>
 <20241005160444.GA18071@noisy.programming.kicks-ass.net>
 <20241005160723.GI33184@noisy.programming.kicks-ass.net>
 <6e7812f7-c94a-46ba-ba4d-cf4b7b1f60c9@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7812f7-c94a-46ba-ba4d-cf4b7b1f60c9@efficios.com>

On Sat, Oct 05, 2024 at 02:56:26PM -0400, Mathieu Desnoyers wrote:
> On 2024-10-05 18:07, Peter Zijlstra wrote:
> > On Sat, Oct 05, 2024 at 06:04:44PM +0200, Peter Zijlstra wrote:
> > > On Fri, Oct 04, 2024 at 02:27:33PM -0400, Mathieu Desnoyers wrote:
> > 
> > > > +void hp_scan(struct hp_slot __percpu *percpu_slots, void *addr,
> > > > +	     void (*retire_cb)(int cpu, struct hp_slot *slot, void *addr))
> > > > +{
> > > > +	int cpu;
> > > > +
> > > > +	/*
> > > > +	 * Store A precedes hp_scan(): it unpublishes addr (sets it to
> > > > +	 * NULL or to a different value), and thus hides it from hazard
> > > > +	 * pointer readers.
> > > > +	 */
> > 
> > This should probably assert we're in a preemptible context. Otherwise
> > people will start using this in non-preemptible context and then we get
> > to unfuck things later.
> 
> Something like this ?
> 
> +       /* Should only be called from preemptible context. */
> +       WARN_ON_ONCE(in_atomic());

	lockdep_assert_preemption_enabled();

that also checks local IRQ state IIRC.
