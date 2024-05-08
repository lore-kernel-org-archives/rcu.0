Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E38172A;
	Wed,  8 May 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165947; cv=none; b=hRF+n/uicCFKTZWOYlOHAG8s4vKMIhtWwLpgkB9DjC9feQeiPidemI3pkWOH00H7qP3raW6asUjohFvC4yB3sMGNdcpgk/ts8fDglyubI3eTZkcfJQJg55JP9+zAUdcc64NN3ZUgZs9EZNQ16/IXrSaidzsnBW7G5sc3QuuUZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165947; c=relaxed/simple;
	bh=6VZ7r11vgmtx2F69LIOMPd3L9p0ehngsk+gDZpyp9lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/hXcgXtrBvWlja10N3U/FV4AXAymmI4EIvihIXKEIYnB0hrStdQAWr2U3eBJPtdaDITxWJNwnfhTBRVkoH8NAl2mdKJjiLX5gXMM0AOB8Ka9vlYU8N4wl8F4zG4bHXJmD4piHNtymfgv7aZsVPlJRVrqTDGN2m7rmo55BbBbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4QZLng8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4QZLng8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4580EC113CC;
	Wed,  8 May 2024 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715165946;
	bh=6VZ7r11vgmtx2F69LIOMPd3L9p0ehngsk+gDZpyp9lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4QZLng8qe62yhyqFmtJpj0LltREfFRz6Vfp0qvmRJBPjp6uh0iDWUslUZT5Y3LMh
	 CbVilUqsouBVEmNYSJEqDdAgrn4lYW2qsI93uUhRiEKcDO4yq5ky93xkk38vDNgKrv
	 j++AKQE2epqE0M+F+Dx5RNS4begnpFtE3K9D7H+b6nxVvqeUw1VDjslYXUmk/9/3Z7
	 zdvqjQWOcdbzskcT1OLxQuNV2SmKbXzErEWrLs9GxututtNbU/SmCjulZPEeFZyxHS
	 +s3rdrAIoN8aL5LrDkak/hly8ADJFOi0yYm3yGoN5koJnmdMHMNsekMe47k0OtWwco
	 0GU86vKRbMfQg==
Date: Wed, 8 May 2024 12:59:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <Zjta9-jCNHmAAh6b@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-19-vschneid@redhat.com>
 <ZjoxIhtCw4Pov0VH@localhost.localdomain>
 <d3177337-51cd-4841-ba4b-8e0f8f5bbc84@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3177337-51cd-4841-ba4b-8e0f8f5bbc84@paulmck-laptop>

Le Tue, May 07, 2024 at 10:14:08AM -0700, Paul E. McKenney a écrit :
> On Tue, May 07, 2024 at 03:48:18PM +0200, Frederic Weisbecker wrote:
> > Le Tue, Apr 30, 2024 at 11:17:22AM +0200, Valentin Schneider a écrit :
> > > The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> > > RCU_WATCHING, the dynticks prefix can go.
> > > 
> > > Furthermore, the "in_eqs_since" part confuses me, as IIUC this only checks
> > > for a change in watching/eqs state, not that RCU transitionned *into* a
> > > EQS after the snapshot was taken.
> > > 
> > > e.g. if
> > >   snap = 0b1000 (EQS)
> > > and the following rcu_watching_snap(CPU) is:
> > > 	 0b1100 (watching)
> > > then
> > >   rcu_watching_in_eqs_since(rdp, snap) -> true
> > > 
> > > but because RCU was already in EQS at the time of the
> > > snap - it hasn't entered EQS "since" the snap was taken.
> > > 
> > > Update the name to reflect that we're only looking at watching/EQS
> > > transitions, not specifically transitions into EQS.
> > 
> > Indeed in practice the function only checks a change. But semantically it really
> > checks a trip to eqs because this function is only ever called after a failing
> > call to rcu_dynticks_in_eqs().
> > 
> > So not sure about that one rename. Paul?
> 
> As you say, Valentin is technically correct.  Me, I am having a hard
> time getting too excited one way or the other.  ;-)
> 
> I suggest thinking in terms of rate-bounding the change.  If you do
> change it, don't change it again for a few years.

Makes sense!

> 
> Either way, should comments be changed or added?
> 
> Of course, the scientific way to evaluate this is to whose a couple
> dozen people the old code and a couple dozen other people the new code,
> and see if one group or the other has statistically significantly lower
> levels of confusion.  I don't see how this is feasible, but it is the
> (painfully) correct way.  On the other hand, it would have the beneficial
> side effect of getting more people exposed to Linux-kernel-RCU internals.
> Unfortunately, it might also have the additional side effect of making
> them (more) annoyed at RCU.  ;-)

Sounds good!

I divided myself in two blank RCU subjects for a double blind study
and locked those people up overnight with a paper containing both proposals.

I opened the door five minutes ago and they both elected by mutual agreement
rcu_watching_changed_since()! Also they are thirsty.

Congratulations Valentin! :-)

> 							Thanx, Paul
