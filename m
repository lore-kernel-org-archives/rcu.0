Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1842139A8;
	Fri, 14 Feb 2025 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535055; cv=none; b=mhslpJmL8pDLPvtPGyP5lmnQ2U7xw8F8N7NZUUDM2TJ2B6EIEzVUTTB44BIJTlvKT9LU2bDIvscrBblJcn1Whw2N/z9q0G72zydKbpsmS8D7EXN1jc6unjPdTt8VfZUholv5uj1Ry1yazb2eWYXAb2ZzkmlQPyk/eTWVlLnOt0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535055; c=relaxed/simple;
	bh=Vkm/fIjGV1Zi4OLao+eFLnkFlhtDFUA1jZRivO8SgH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9X1v711YEytNs2hx+EaU/6L5AMRUVceD45WZyhZN62609o5yWIE+gM8K8sqcFPEy8DK3TWDOOts19CxYxJNlUCnm2DYnCFns+kn9xaerALUohtvEX3jocrnpC0ENm6Z2qJdLPKHLwxDzQeBAz/1yBWPkzoyktTJaUYRFXIvojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU4BxNWA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU4BxNWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A05C4CED1;
	Fri, 14 Feb 2025 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739535054;
	bh=Vkm/fIjGV1Zi4OLao+eFLnkFlhtDFUA1jZRivO8SgH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fU4BxNWAQ6LOCjJ3kxNM5vG47SfVZsUn20Mg2wLTX/ctNqprza2c5NyVHswaCZVWS
	 M9go970yksmR0P5uiPGOjnmhQ5b+h2Ax7I3MLQ2q1Dmr7DzBeO7cscLjrAexH/Z6eh
	 JpjBei5bdQmhhNyZzByHI+C6Qmuh1+6RWSfaqCtirTNmwvKY7TXm5QWIKxTXduUqRS
	 H+dkenyK9R4QHkKfNnhWpRtgVVqeKpOdTEdoLy+5+nT4KVNRpUAZFKdaY7OSgMh3yy
	 gPyoSkdB05f1to3IY6XgbGAKHED+Ym73d9IAtz6d9cvKM/oMF1qPeIVIvDlmsd/bVi
	 zw+KhhaPyUODQ==
Date: Fri, 14 Feb 2025 13:10:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 3/3] rcu/exp: Remove needless CPU up quiescent state
 report
Message-ID: <Z68yzBURiIr_7Lmy@pavilion.home>
References: <20250213232559.34163-1-frederic@kernel.org>
 <20250213232559.34163-4-frederic@kernel.org>
 <fe931d3a-bf97-4be5-8420-f1fcb55e6a46@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe931d3a-bf97-4be5-8420-f1fcb55e6a46@paulmck-laptop>

Le Fri, Feb 14, 2025 at 01:01:56AM -0800, Paul E. McKenney a écrit :
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
> 
> Thank you for digging into this!
> 
> When I ran tests that removed the call to sync_sched_exp_online_cleanup()
> a few months ago, I got grace-period hangs [1].  Has something changed
> to make this safe?

Hmm, but was it before or after "rcu: Fix get_state_synchronize_rcu_full()
GP-start detection" ?

And if after do we know why?

Thanks.
