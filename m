Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C2619047A;
	Mon, 30 Sep 2024 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704463; cv=none; b=L90F228josf9ktDiJzMWCZ64chJQ+Su7/cSmVxL98wSGnk2gjoH5axA5bvUTTOeJ7MZ0dvD05ubJ2y6NIrPcEuhsGRRh/8Y7GN0ZNaMrtFJ1GeioQKcKE56FmEHPcc3/kCV0s8cr/jnYtLQ+qv/Py+RhJMkaQMKJsjEd7Mcyblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704463; c=relaxed/simple;
	bh=Kb3o7fbCjfsS+L3nJzr7RT2aH+ia/D09v5IrixjDUkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuijhV8vIY/J3f7wRqMIsk71yS7ri34dGZhYrVEBpxW0rOmFfMtrfQ9vclkpDpUqinrrNdt8FrVJ3RlbgDicjGdTJ82XqTHE6UVFZPzpH3Qp1doBr/cWre4g82hLeRR+OYmY735TdaA3zf/bnHzv6eEN6csoUkIUaqieXYqGgrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=he6j7o2c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="he6j7o2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6BD4C4CEC7;
	Mon, 30 Sep 2024 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704462;
	bh=Kb3o7fbCjfsS+L3nJzr7RT2aH+ia/D09v5IrixjDUkg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=he6j7o2cLX6V6c1gCqDhsPYvCjBaT/5Z5XKivgQoHNlJxlkjPlAVbDQocEzCCtXqE
	 J4Jz3d+rFTr5iB2qR2Q6ec7OfflGNuFIQefrZs4SLVsQXFo/HwBk+gTbWPbpg5rkV8
	 0oU59WzJBYiqix2kCZ6syFQuzVecKUMGE9roc/9/V2ftNfC6n5u9blax1MeiPTIiRb
	 imQ00XX+3zl8EduUE/wn2xgaYFxxyPAe2qfrtEMp0nwF15pZDgXwzO0QgNlm0rJpcV
	 Mg/V11CbpnTy5GO+KKI8h3YpT3/qO7LFvndMTcfJWqqZtklzpSHxpmP8q1GGm7LTKL
	 qJ3ekaL/7YnxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9868BCE0DB6; Mon, 30 Sep 2024 06:54:22 -0700 (PDT)
Date: Mon, 30 Sep 2024 06:54:22 -0700
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
Message-ID: <490f7491-5e4f-4c03-89a0-854aff3c7ecf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
 <20240928135128.991110-2-mathieu.desnoyers@efficios.com>
 <02c63e79-ec8c-4d6a-9fcf-75f0e67ea242@rowland.harvard.edu>
 <2091628c-2d96-4492-99d9-0f6a61b08d1d@efficios.com>
 <d2c87672-af75-4210-bd96-d7f38f2f63ac@rowland.harvard.edu>
 <d49f5d9f-559d-449b-b330-9e5a57d9b438@efficios.com>
 <25344f33-b8dc-43fb-a394-529eff03d979@rowland.harvard.edu>
 <f635f9ce-fef4-4a9e-bee1-70dbc24a82ad@huaweicloud.com>
 <973ae617-96a8-456a-a805-af3d61270125@paulmck-laptop>
 <50bd6ecb-c8e3-4043-9040-b2b4ee71fc02@huaweicloud.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50bd6ecb-c8e3-4043-9040-b2b4ee71fc02@huaweicloud.com>

On Mon, Sep 30, 2024 at 02:06:12PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 9/30/2024 um 1:04 PM schrieb Paul E. McKenney:
> > On Mon, Sep 30, 2024 at 11:42:11AM +0200, Jonas Oberhauser wrote:
> > > 
> > > 
> > > I also currently don't see any major difference between the constant and
> > > register case. The point is that the address is known before loading into b,
> > > and hence the compiler + hardware can speculatively load *b before loading
> > > into b.
> > 
> > In theory, true.  In practice, in the register case, you need a little
> > more bad luck for the compiler to be able to exploit your mistake.
> 
> If there's one thing I've never run out of, then it is bad luck with
> technology.

Careful!  Someone might try to recruit you as tester.  ;-)

							Thanx, Paul
