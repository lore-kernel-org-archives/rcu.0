Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0C201006;
	Fri, 14 Mar 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963148; cv=none; b=iCHW64y76NA3yiDQrlJeCxzoqtz6UpxKk79r6q8Qc0mcat8rcwWpJWSefMJy0H5p9x82nEWR9xKtHR9luVmZnC353ChEOeFYaWcW1VpI4s9NIdzkfi2nz8jmR/+gDEhSMWDdPTI+Wu2jrIvDftMu3eXfvKFTrgKt98LYBuYGiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963148; c=relaxed/simple;
	bh=+rOCS4ANpOhQrkXaIKAqHuNZwcp5/PpEXC53lEgGM7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQzI1PMh9p70WfbSGhlFK3+eRysbapz4W0mc/TASvU3StS3fpDoBbjTAGX2Mu1niTtaPHPxirtvPO8F05wTTQ6lSNmtLBAw2ohuniWYFj11V0Xv9F52IrL4Spg2t6/rnuUVX9CvHPHtwvdlXKmAAGT4jiLT66eQ33Wu8f8wU3gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loCBhxEB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loCBhxEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4938EC4CEE9;
	Fri, 14 Mar 2025 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963147;
	bh=+rOCS4ANpOhQrkXaIKAqHuNZwcp5/PpEXC53lEgGM7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loCBhxEBErKK3ZIht8R39+ptBlFC2S1QBIaARm2aLPojkPkaPZiUl/F+SVqutA0ac
	 NX2lEwH4CexIWMDqGzyv17BXtlUwYB+szhZLa+fJGJMQd/04J64JyhCWiksYSSDHZU
	 4Cw0l5C71+PpzLn4kYMj0m70dVGjf0gXQIpn2T/w8b/oKTCr/HaaRuMGMeLQQUvVJo
	 MQ80z+4JEmZKB1hHaj2PqI6fpbrGlaW0viu9UwzxJpVsXs8Ra5RcaRlWX+tpq4vW4L
	 vt2wM7lpkf2uPKIhCzk72o/e00wyCpOdIOgaEGLImdi0Ga84XrD6FXdIeHx2khLtrg
	 UhKQbRMW/U+OQ==
Date: Fri, 14 Mar 2025 15:39:05 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <Z9Q_iWaLfGb9fzA4@localhost.localdomain>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <332cc3da-55fa-4729-81bf-625afa5290bd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <332cc3da-55fa-4729-81bf-625afa5290bd@paulmck-laptop>

Le Mon, Mar 03, 2025 at 12:10:50PM -0800, Paul E. McKenney a écrit :
> On Fri, Feb 14, 2025 at 12:25:59AM +0100, Frederic Weisbecker wrote:
> > A CPU coming online checks for an ongoing grace period and reports
> > a quiescent state accordingly if needed. This special treatment that
> > shortcuts the expedited IPI finds its origin as an optimization purpose
> > on the following commit:
> > 
> > 	338b0f760e84 (rcu: Better hotplug handling for synchronize_sched_expedited()
> > 
> > The point is to avoid an IPI while waiting for a CPU to become online
> > or failing to become offline.
> > 
> > However this is pointless and even error prone for several reasons:
> > 
> > * If the CPU has been seen offline in the first round scanning offline
> >   and idle CPUs, no IPI is even tried and the quiescent state is
> >   reported on behalf of the CPU.
> > 
> > * This means that if the IPI fails, the CPU just became offline. So
> >   it's unlikely to become online right away, unless the cpu hotplug
> >   operation failed and rolled back, which is a rare event that can
> >   wait a jiffy for a new IPI to be issued.
> > 
> > * But then the "optimization" applying on failing CPU hotplug down only
> >   applies to !PREEMPT_RCU.
> > 
> > * This force reports a quiescent state even if ->cpu_no_qs.b.exp is not
> >   set. As a result it can race with remote QS reports on the same rdp.
> >   Fortunately it happens to be OK but an accident is waiting to happen.
> > 
> > For all those reasons, remove this optimization that doesn't look worthy
> > to keep around.
> > 
> > Reported-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Based on discussions:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> 
> If it was still just me doing RCU, I would skip this one, just out of an
> abundance of caution.  But you break it, you buy it!  ;-)

I'm trying to be optimistic... ;-))
