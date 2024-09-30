Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5D913D52E;
	Mon, 30 Sep 2024 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727694267; cv=none; b=NnG/w5BaWcIybKF8g3YHlsYu28Gy3ai/RI3ji92fYHYZv9PnQaAIePbYhGpDzgVuy1MJQ/BbB30nAsrqYHX4fpWkt1oo8VdiE/xkseoIiVy5nDh192eJkwkYd80sI8a3cmOrUX4nGGPky88oGA2PVvq3M7KNd08gFajsF++ltJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727694267; c=relaxed/simple;
	bh=NQiIbZLHWN50/ws+KIDFjx4xxlpqFvb6ih5bgRVnqkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjR0dZnvR5MN+nVe/8fBE+Kh7KnDBC0kHK7AkGlRX8LQXJC5dnYdDCoFA4mvn0KQP1t8zFo9IELEOI9Nq+oIfG7YFXK7rE4ggqXHyLoS+RkjWPDGc0aRTNFuM8yZGHnz8aLROrH1vw70Am+hHdn0BSbL/Pu4HK/L6edpIpo7PoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/P5vZLe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/P5vZLe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BF1C4CECD;
	Mon, 30 Sep 2024 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727694267;
	bh=NQiIbZLHWN50/ws+KIDFjx4xxlpqFvb6ih5bgRVnqkI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=C/P5vZLe/MApdutuJdD7IdXpboJkOnr82ejl4aWFIY2nN0iymjeJrp83d8Pk81wHa
	 Dm1PX4Cy5emOCjgmBZNSf9hGHYYQicAsTDZxz1+5OIgb0BSOq1yuQTKb5/gw+NxVZw
	 yy/Gw1HP3ogtenV6G79kqC+8WDt4CUqWJjvgvvgd+WWdRSYvEWz9neaz/3tN9eMBvR
	 62WHvSaHtIwteuXCcVPMN+aEvzPpHLxhMFR7ZM1hIbet4Clpahf8BeiWGXfJ8xurFR
	 7whUxrFmhedCkwdff8RmITyp+PsrEDmHZ+UsaS9Hj9bLDi3x3YyFDmMl5bnj86wA+5
	 j/RllRuBUom/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3B78CE09D1; Mon, 30 Sep 2024 04:04:26 -0700 (PDT)
Date: Mon, 30 Sep 2024 04:04:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, John Stultz <jstultz@google.com>,
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
	Mateusz Guzik <mjguzik@gmail.com>, Gary Guo <gary@garyguo.net>,
	rcu@vger.kernel.org, linux-mm@kvack.org, lkmm@lists.linux.dev
Subject: Re: [PATCH 1/2] compiler.h: Introduce ptr_eq() to preserve address
 dependency
Message-ID: <973ae617-96a8-456a-a805-af3d61270125@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <25344f33-b8dc-43fb-a394-529eff03d979@rowland.harvard.edu>
 <f635f9ce-fef4-4a9e-bee1-70dbc24a82ad@huaweicloud.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f635f9ce-fef4-4a9e-bee1-70dbc24a82ad@huaweicloud.com>

On Mon, Sep 30, 2024 at 11:42:11AM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 9/28/2024 um 11:15 PM schrieb Alan Stern:
> > On Sat, Sep 28, 2024 at 11:55:22AM -0400, Mathieu Desnoyers wrote:
> > > On 2024-09-28 17:49, Alan Stern wrote:
> > > > Isn't it true that on strongly ordered CPUs, a compiler barrier is
> > > > sufficient to prevent the rcu_dereference() problem?  So the whole idea
> > > > behind ptr_eq() is that it prevents the problem on all CPUs.
> > > 
> > > Correct. But given that we have ptr_eq(), it's good to show how it
> > > equally prevents the compiler from reordering address-dependent loads
> > > (comparison with constant) *and* prevents the compiler from using
> > > one pointer rather than the other (comparison between two non-constant
> > > pointers) which affects speculation on weakly-ordered CPUs.
> > 
> > I don't see how these two things differ from each other.  In the
> > comparison-with-a-constant case, how is the compiler reordering
> > anything?  Isn't it just using the constant address rather than the
> > loaded pointer and thereby breaking the address dependency?
> 
> I also currently don't see any major difference between the constant and
> register case. The point is that the address is known before loading into b,
> and hence the compiler + hardware can speculatively load *b before loading
> into b.
> 
> The only difference is how far before loading into b the address is known.

In theory, true.  In practice, in the register case, you need a little
more bad luck for the compiler to be able to exploit your mistake.

Still, it is indeed far better to attain a state of bliss by keeping
the compiler ignorant.

							Thanx, Paul
