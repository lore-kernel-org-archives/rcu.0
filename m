Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1222F7EE3;
	Sat, 25 Jul 2026 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785005920; cv=none; b=d6EH0TatYBsfIyrk/Gib4ZjoglqOu4Bbo1v3ChAxtn3Wsk35cHlnzgm3LdhEIJbgGJScMkZAAy2vkdxnC9J8p98uOPaFZebGWQp7EgdlMpRp2laNEjeNN7ynJkcsBglWQc0zSjNZ0IY1Gombi2eD9sGnTXC+aP2TtE1lUPsR2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785005920; c=relaxed/simple;
	bh=jXg5ahg42zcpg8XPWTo+GIoZzkca0FY5hGzfH2LGfDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB0agj7Vz0rlRI3zWyInnyWrCIylEAoxu/OTT9JzosM3KSn85UgEDaBXkJjLdZLhbQ04UrEI8tteMLacNfwE1ZAChnM76BAibOXVGkJXcHiOGqqomu0iB5RQH2AHle7igO6itkJiwETUZISMjKqQALZFkSR6mEp009690kNhAP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YieRvc+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YieRvc+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21201F000E9;
	Sat, 25 Jul 2026 18:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785005918;
	bh=CqU3KmPMm5To1FwSr02Oj7Sxt36KvFN1LUXp4ewJ4iw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=YieRvc+fC9isAxRIaPFa27o955fONshsui4Vla1LVK1Vh3pXEgwG/Cyoh3raS6PMQ
	 ZRbae8MWK4uJrK03lEKI5tIi8GpSsiJYWml18thhX6XWcFPSxAf76JRqFmzK400eRW
	 Nb6A1PRCq3FW0H5FqENck5LvBLD0xolt8opooXn1ot1X59wpTYs1UXhX+1KA3fenOD
	 HsxkcdRMfS6ivD+LyWV/l/lntiLy1W0wsXeiWZq39ByHzdbSODmcljBHVOABzTBJWU
	 wIBLjpgZYFkRTYe+p+vP8r2FSYy4UyD2BaJdvQ3CPocuDI7UInXPoWwbvwcfx4SBLz
	 Vjl1olRAMXovg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 62A7DCE0B17; Sat, 25 Jul 2026 11:58:38 -0700 (PDT)
Date: Sat, 25 Jul 2026 11:58:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2 6/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
Message-ID: <a6749e86-0439-4f17-9bd5-ae4624f59124@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260624132356.516959-7-puranjay@kernel.org>
 <20260724183123.160051-1-puranjay@kernel.org>
 <5a87e5f1-7cbf-45c0-a6e2-88320db628bc@paulmck-laptop>
 <CANk7y0jZ7JuR6MoNKZZU3R=+kfe0pELRUWYomtxHKQwsBan3Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANk7y0jZ7JuR6MoNKZZU3R=+kfe0pELRUWYomtxHKQwsBan3Bw@mail.gmail.com>

On Sat, Jul 25, 2026 at 01:04:21PM +0100, Puranjay Mohan wrote:
> On Sat, Jul 25, 2026 at 1:23 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Jul 24, 2026 at 11:31:23AM -0700, Puranjay Mohan wrote:
> > > Currently, RCU callbacks only track normal grace-period sequence
> > > numbers.  This means callbacks must wait for normal grace periods to
> > > complete even when expedited grace periods have already elapsed.
> > >
> > > Use the full struct rcu_gp_seq (which tracks both the normal and
> > > expedited grace-period sequences) throughout the callback
> > > infrastructure.
> > >
> > > rcu_segcblist_advance() now checks both normal and expedited GP
> > > completion via poll_state_synchronize_rcu_full(), and becomes
> > > parameterless since it reads the grace-period state internally.
> > > rcu_segcblist_accelerate() stores the full state (both sequences)
> > > instead of just the normal one.  rcu_accelerate_cbs() and
> > > rcu_accelerate_cbs_unlocked() use get_state_synchronize_rcu_full() to
> > > capture both sequences, and the NOCB advance checks use
> > > poll_state_synchronize_rcu_full() instead of comparing only the normal
> > > sequence.
> > >
> > > srcu_segcblist_advance() becomes a standalone implementation because it
> > > compares SRCU sequences directly and cannot use
> > > poll_state_synchronize_rcu_full(), which reads RCU-specific globals.
> > > srcu_segcblist_accelerate() sets the ->exp field to
> > > RCU_GET_STATE_NOT_TRACKED so that poll_state_synchronize_rcu_full()
> > > compares only ->norm and ignores ->exp.
> > >
> > > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > > ---
> > > Paul, please take this in place of the original 6/11.  The only change
> > > from v1 is dropping the premature !poll_state_synchronize_rcu_full() gate
> > > in nocb_gp_wait(): if a grace period completed between rcu_advance_cbs()
> > > and that poll, the rcuog slept grace-period-deaf in nocb_gp_sleep() with
> > > advanceable callbacks still queued -- the lost wakeup Frederic diagnosed.
> > > Verified by widening that window with a delay: the original reproduced the
> > > writer stall within ~75s, this version stayed clean.
> >
> > Done, and will test during the weekend, thank you!
> >
> > There were some conflicts, so could you please double-check?
> 
> I have looked at your latest dev branch and everything looks good to me.

Thank you for checking!

And it passed 2400 hours (12 elapsed hours) of testing overnight.

I am calling this good.  ;-)

							Thanx, Paul
