Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618C713D2B7;
	Tue, 14 May 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683331; cv=none; b=OYXaI1G6ic6a+H0j1OUrJr/bZIrjIgcUxoGYp2pcHob7v+YJNHavXYLR/W+qg59DLKFRgSIObyrKvBTJ+6a3ZNDroJk6tkXqPM/idbALV4lTXqcDvijKkfLfiCwsjYsoh9r7opgclWOws851wRJBF3klQh2sgLbh9g5uIbjHx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683331; c=relaxed/simple;
	bh=pgxgidgbUhrdnKoQE5fZ9bF+iQvru7SDM8rpvdWyrI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTme9VTUGdOCGWi9XutB4eKFqVRgeEJxiKUoWQRoO+mLNRxJthv5QnZggGDQUOlC8QTQFJ7CWpqH21TASP9NDl4Lu5UlS4PI1wr/oRjaOVnrvFYe0kjBBHt6gY6ud8RjiU+of8moGmnoEUEfCDr46eJwVMwx4W+eKTSwUcNhvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhRcCt1L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhRcCt1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDF8C2BD10;
	Tue, 14 May 2024 10:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715683331;
	bh=pgxgidgbUhrdnKoQE5fZ9bF+iQvru7SDM8rpvdWyrI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhRcCt1L93FgX5qyjHoWbueo209p785xTZkBY4tkJbCnMxgQXxpoaADNk4I2Pjn4G
	 a9da9vCHD/orTfWNFOhsU+V1UO4pdtPpG0+WeT/51BAxU35v55fOj33uKezAXvn5rO
	 +qiAYmYbwfOZ7QHoACg9WY9HtvoYoDmZPOdI0h/9lsxcwE1UB6QDsNFlfGjCWk3k8y
	 yqIG74nhvd77DMLYjbWApy54PDSB8XbDTQSw4DDqHay0cxSNvUWI1YNsbdvj4gDAHf
	 PEnu0ZXNwaxSIg7H9J8+efc5QJWNsQYlLrAVaz7QqwK+XeWsr7zYnCDePLMfwJjalg
	 aBL24pUb7kH5A==
Date: Tue, 14 May 2024 12:42:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
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
Message-ID: <ZkNAABSASimEq8ho@localhost.localdomain>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-19-vschneid@redhat.com>
 <ZjoxIhtCw4Pov0VH@localhost.localdomain>
 <d3177337-51cd-4841-ba4b-8e0f8f5bbc84@paulmck-laptop>
 <Zjta9-jCNHmAAh6b@localhost.localdomain>
 <xhsmhttj1h7xy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xhsmhttj1h7xy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

Le Mon, May 13, 2024 at 08:40:09PM +0200, Valentin Schneider a écrit :
> On 08/05/24 12:59, Frederic Weisbecker wrote:
> > Le Tue, May 07, 2024 at 10:14:08AM -0700, Paul E. McKenney a écrit :
> >> On Tue, May 07, 2024 at 03:48:18PM +0200, Frederic Weisbecker wrote:
> >> > Indeed in practice the function only checks a change. But semantically it really
> >> > checks a trip to eqs because this function is only ever called after a failing
> >> > call to rcu_dynticks_in_eqs().
> >> >
> >> > So not sure about that one rename. Paul?
> >>
> >> As you say, Valentin is technically correct.  Me, I am having a hard
> >> time getting too excited one way or the other.  ;-)
> >>
> >> I suggest thinking in terms of rate-bounding the change.  If you do
> >> change it, don't change it again for a few years.
> >
> > Makes sense!
> >
> >>
> >> Either way, should comments be changed or added?
> >>
> >> Of course, the scientific way to evaluate this is to whose a couple
> >> dozen people the old code and a couple dozen other people the new code,
> >> and see if one group or the other has statistically significantly lower
> >> levels of confusion.  I don't see how this is feasible, but it is the
> >> (painfully) correct way.  On the other hand, it would have the beneficial
> >> side effect of getting more people exposed to Linux-kernel-RCU internals.
> >> Unfortunately, it might also have the additional side effect of making
> >> them (more) annoyed at RCU.  ;-)
> >
> > Sounds good!
> >
> > I divided myself in two blank RCU subjects for a double blind study
> > and locked those people up overnight with a paper containing both proposals.
> >
> > I opened the door five minutes ago and they both elected by mutual agreement
> > rcu_watching_changed_since()! Also they are thirsty.
> >
> > Congratulations Valentin! :-)
> 
> :-)
> 
> Now, not that I like wasting everyone's time, but... I hadn't taken a step
> back to realize the calling context implied this would always be used to
> check an entry into EQS, per the waiting loop structures. With this in
> mind, how about the following? 
> 
> 
> /**
>  * rcu_watching_stopped_since() - Has RCU stopped watching a given CPU since
>  * the specified @snap?
>  *
>  * @rdp: The rcu_data corresponding to the CPU for which to check EQS.
>  * @snap: rcu_watching snapshot taken when the CPU wasn't in an EQS.
>  *
>  * Returns true if the CPU corresponding to @rcu_data has spent some time in an

@rdp

>  * extended quiescent state since @snap. Note that this doesn't check if it
>  * /still/ is in an EQS, just that it went through one since @snap.
>  *
>  * This is meant to be used in a loop waiting for a CPU to go through an EQS.
>  */
> static bool rcu_watching_stopped_since(struct rcu_data *rdp, int snap)
> {
> 	if (WARN_ON_ONCE(rcu_watching_in_eqs(snap)))
> 		return true;
> 
> 	return snap != rcu_dynticks_snap(rdp->cpu);
> }
> 
>

Yep, looks good to me!

Thanks.
