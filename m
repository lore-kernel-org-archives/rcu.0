Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1321148B;
	Tue, 18 Mar 2025 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317638; cv=none; b=JkAqOygBfYuHxbmIsw9ySZyHqwu76ucPnptqz5JpV9NjeZ/eZDy00MFeLBTpQnsfS+5YQriIR/N6wTjFjYHT9A0gBZ416qm8LWyh9ZWxyAseAZCGEfpBdXSq7Nl58DC+V5o62AfzcxvC3h7rZVofM138E6/yvbMJBUnEpf2axbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317638; c=relaxed/simple;
	bh=4boUEoGHzUCSh42Ij27ucrvsuBQHEkD0mBcuZvb5kQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSYivYAgxpEYzyjtKMIpQYXiMkhoHxvEisoDg29YC0AmpMtgdxLJ4YLYyToTyjlGJ874qfhslZNjS2JE6xjF2ZSf3BB/+ugEVRpgRz/iaUNaJiZPqL77W1XChQBEJ22NyTR/ET80Ee12vgWiRzOPaNzjZChWhGI3pA7y/3lUwcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScLYgn/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScLYgn/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E61FC4CEDD;
	Tue, 18 Mar 2025 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742317636;
	bh=4boUEoGHzUCSh42Ij27ucrvsuBQHEkD0mBcuZvb5kQo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ScLYgn/DK1tisavY1cUv5HTz4GNKRKNVZtwohaPbC5LYhNIZ01Vj4aGjb9i2xIsgA
	 fDDKsAUXP9euPayEfnK1cwXP4HIIIvj/hlcmme17nlK2fCdvEyHEeuAJaziBxM8hS3
	 zySOHI66zKHutaVmn32IxSIZ0HtKjd2gz/yPUsHVaX8M6NWY4JD2OH2X2NGS5nkTMf
	 ywPbx3ua9Mm7S4bza8ms8l4ycee7cza9WeevuB99Gt7fLbtpcdnG+ACYmmTHFDpCA+
	 Kfo65ePx76Th14aSScYkxE5ZBUPBH+okEccmW++Pmf+9FlqIMLnPAdNFyLIe1AnyKH
	 +jvdW9QLJSD6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E62AACE0843; Tue, 18 Mar 2025 10:07:15 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:07:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <47de9739-7319-4c62-b56c-8f757612744f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <332cc3da-55fa-4729-81bf-625afa5290bd@paulmck-laptop>
 <Z9Q_iWaLfGb9fzA4@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9Q_iWaLfGb9fzA4@localhost.localdomain>

On Fri, Mar 14, 2025 at 03:39:05PM +0100, Frederic Weisbecker wrote:
> Le Mon, Mar 03, 2025 at 12:10:50PM -0800, Paul E. McKenney a écrit :
> > On Fri, Feb 14, 2025 at 12:25:59AM +0100, Frederic Weisbecker wrote:
> > > A CPU coming online checks for an ongoing grace period and reports
> > > a quiescent state accordingly if needed. This special treatment that
> > > shortcuts the expedited IPI finds its origin as an optimization purpose
> > > on the following commit:
> > > 
> > > 	338b0f760e84 (rcu: Better hotplug handling for synchronize_sched_expedited()
> > > 
> > > The point is to avoid an IPI while waiting for a CPU to become online
> > > or failing to become offline.
> > > 
> > > However this is pointless and even error prone for several reasons:
> > > 
> > > * If the CPU has been seen offline in the first round scanning offline
> > >   and idle CPUs, no IPI is even tried and the quiescent state is
> > >   reported on behalf of the CPU.
> > > 
> > > * This means that if the IPI fails, the CPU just became offline. So
> > >   it's unlikely to become online right away, unless the cpu hotplug
> > >   operation failed and rolled back, which is a rare event that can
> > >   wait a jiffy for a new IPI to be issued.
> > > 
> > > * But then the "optimization" applying on failing CPU hotplug down only
> > >   applies to !PREEMPT_RCU.
> > > 
> > > * This force reports a quiescent state even if ->cpu_no_qs.b.exp is not
> > >   set. As a result it can race with remote QS reports on the same rdp.
> > >   Fortunately it happens to be OK but an accident is waiting to happen.
> > > 
> > > For all those reasons, remove this optimization that doesn't look worthy
> > > to keep around.
> > > 
> > > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > 
> > Based on discussions:
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > If it was still just me doing RCU, I would skip this one, just out of an
> > abundance of caution.  But you break it, you buy it!  ;-)
> 
> I'm trying to be optimistic... ;-))

So am I.  ;-)

							Thanx, Paul
