Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AEA160865;
	Tue,  7 May 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102049; cv=none; b=BxUEPw6svhyiHIEoQ8q2lCa7PpAlP50sc8Gwc3Soe0vumaHQmOLu0GdDTnGc+M5UnyYvbCUS3N0OWqJbkwfrsJ8ft0j+DuTcThHpPUVQQwKeBdgRuNNGjI/7lSIDspsiMMNlUYBHnrP5IiuauAgT1GC9r1ICzWZT0Wr7XQ9wF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102049; c=relaxed/simple;
	bh=lmbWOT7TNgeizDvMTV/ftchusmhKpY8WBIGHLAWTrQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZJSq4prMlNBLIuyD5obScedzc0bW8jhVgjGbuEk+ou40TKgjDTqFXO2nPE+4StcO07ORAWRvloCBpt2NzjPo/kSCZNi7aOOg51TRlIRc9mcS7u+CSg4pwQqAUefYXMRjqquBL7EwNL1poja7Ray6UWs4QyCtIKXYoOqp3DM+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIYAp7G/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIYAp7G/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1825C2BBFC;
	Tue,  7 May 2024 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715102048;
	bh=lmbWOT7TNgeizDvMTV/ftchusmhKpY8WBIGHLAWTrQ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MIYAp7G/KBx6IFvo4E46E3D6LvdGX6iTXIHdYcHiiEcXLfETvEisk9q/Q8Ut+2JPy
	 xvYknQAR2kaLDE5xB9eed1ex6HvJM1gmyNVun79yD75QRVzdAf+KasDq29R4rTp7Ky
	 BMw5bVlRAZIy8fWJ3aebPO8wpGvsPBLk3ndrM9/NEWNabtgiHaYS3XqBAS96EVJaNN
	 Pu/DY4k5omP//BtluIY2vjJCsTLyE37ySHHiIFlVfxJQNcP2op7D/xsnaY+NgaSHyj
	 XQ1KbiAKnDq1xyOtTV4VPtPLIpgpKxeerTfV2Bre802M2g8JWHdsQKbWMU5PLjGXIu
	 CIM/AoqF/ISpA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 403B1CE14CC; Tue,  7 May 2024 10:14:08 -0700 (PDT)
Date: Tue, 7 May 2024 10:14:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 18/27] rcu: Rename rcu_dynticks_in_eqs_since() into
 rcu_watching_changed_since()
Message-ID: <d3177337-51cd-4841-ba4b-8e0f8f5bbc84@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-19-vschneid@redhat.com>
 <ZjoxIhtCw4Pov0VH@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjoxIhtCw4Pov0VH@localhost.localdomain>

On Tue, May 07, 2024 at 03:48:18PM +0200, Frederic Weisbecker wrote:
> Le Tue, Apr 30, 2024 at 11:17:22AM +0200, Valentin Schneider a écrit :
> > The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> > RCU_WATCHING, the dynticks prefix can go.
> > 
> > Furthermore, the "in_eqs_since" part confuses me, as IIUC this only checks
> > for a change in watching/eqs state, not that RCU transitionned *into* a
> > EQS after the snapshot was taken.
> > 
> > e.g. if
> >   snap = 0b1000 (EQS)
> > and the following rcu_watching_snap(CPU) is:
> > 	 0b1100 (watching)
> > then
> >   rcu_watching_in_eqs_since(rdp, snap) -> true
> > 
> > but because RCU was already in EQS at the time of the
> > snap - it hasn't entered EQS "since" the snap was taken.
> > 
> > Update the name to reflect that we're only looking at watching/EQS
> > transitions, not specifically transitions into EQS.
> 
> Indeed in practice the function only checks a change. But semantically it really
> checks a trip to eqs because this function is only ever called after a failing
> call to rcu_dynticks_in_eqs().
> 
> So not sure about that one rename. Paul?

As you say, Valentin is technically correct.  Me, I am having a hard
time getting too excited one way or the other.  ;-)

I suggest thinking in terms of rate-bounding the change.  If you do
change it, don't change it again for a few years.

Either way, should comments be changed or added?

Of course, the scientific way to evaluate this is to whose a couple
dozen people the old code and a couple dozen other people the new code,
and see if one group or the other has statistically significantly lower
levels of confusion.  I don't see how this is feasible, but it is the
(painfully) correct way.  On the other hand, it would have the beneficial
side effect of getting more people exposed to Linux-kernel-RCU internals.
Unfortunately, it might also have the additional side effect of making
them (more) annoyed at RCU.  ;-)

							Thanx, Paul
