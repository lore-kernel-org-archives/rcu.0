Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454A86341;
	Sat, 29 Aug 2026 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788044936; cv=none; b=Nhq5ZmVhma/VZnN/qnPQ+9X3JaXMmTQQnasfnqt7Il8kVZtj3mAcYA2Z5E9t4MqnB0tGxGQ4TgJ/Pprwkk54udUC09yqRRAsfAh1cYmsBCXRrRnsLIvtkVXIbcZgxAPcrd4jXBQ39qBaL7coh6NvD34Ufpx7VFZVMz+nESIdpvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788044936; c=relaxed/simple;
	bh=LqCLwqKuWTL6vwDESXogvCGopr8QOkjSQ0447/MdRSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAGk458139ruDQbNU+Tqh8WzU6Qi/SVfBJtNjyWZ2rpMEFdOI9VD3J/fjJhGGYjvA92y4gHwxT2iH04GHSO/FX39nQfohpv8X/9FxnQZ5iIvfcsiwQkQc+D7h+plVEkKV+oncc6+VQhsq+wMBnUwD3uTPgqjlmBXDB1Usk2mOh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/pJfjYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/pJfjYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F9D1F000E9;
	Sat, 29 Aug 2026 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788044934;
	bh=QKZbSL0ssByTYNKKs03JMxEKHIZPEmymi2q/wIpi4Ac=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=G/pJfjYiO+FZ4tBBxMJmw39q7IujzVRMGjW14LydGtZSqvDIEzaL+695cEKmGvYRu
	 5UMu4Kf1/OiePY1w0b4YdKHza0siD37BnWiKwlK5qbHux/nI0wEtJbM2Oi5Mpvm+8+
	 K4Jd7Iizm6LxsPQGSZdNB9oDL4hmDo0kUf8kxLKaPu8eAXYDybiGskSvq9WUjJcNfQ
	 nN8QY2psYuTxXJIDBNipqPP4n4zSXzRUfY2dlqB2hvGgTubWgWDSnGUajklSc+GGjL
	 I0EyjNvexGskhA2IZ7nxrKOaqagfkfmS2pqXZwnDXsNijDjg5cukNVe279utJpQWUn
	 lBHYDwiPyMbtw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6E009CE0540; Sat, 29 Aug 2026 16:08:54 -0700 (PDT)
Date: Sat, 29 Aug 2026 16:08:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: Sunho Park <shpark061104@gmail.com>, linux-kernel@vger.kernel.org,
	syzbot+d4faf7db59e11f6fd1ab@syzkaller.appspotmail.com,
	rcu@vger.kernel.org
Subject: Re: [BUG] srcu: false-positive WARN in cleanup_srcu_struct() after
 78a38cbf6f20
Message-ID: <d3314430-102b-4b27-825d-c8c976100c99@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <24c0edd6-3cdc-4536-ac78-394bf785aad4@gmail.com>
 <0e74e6799bf042293fd1e34e2f242c56786c3de4@linux.dev>
 <9e216978-d884-4d56-b39f-d134f78a4999@gmail.com>
 <eb2132ad05cd3804a8f2a170de441d79afa793e9@linux.dev>
 <f85c60a0-81d7-41a4-9926-f69cf10222d0@gmail.com>
 <e6350377085ddd85d6ef00d8e9a67bd50c762d3c@linux.dev>
 <698a4d8b6c559f9049ee6fa6b0bc99d45a3d7e44@linux.dev>
 <d036078f31cd8f0fdf0b9185ce8cadef803cc375@linux.dev>
 <28ac9afd-92dc-4c92-91f3-94f025977ca7@gmail.com>
 <b3964e625bd41303b4b40357d4b30aa23a536098@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3964e625bd41303b4b40357d4b30aa23a536098@linux.dev>

On Thu, Aug 27, 2026 at 01:41:54PM +0000, Zqiang wrote:
> > 
> > On 8/27/26 21:40, Zqiang wrote:
> > 
> > > 
> > > Now, I am trying to rephrase your problem in the following way:
> > >  1- the step1 call_srcu() trigger SRCU grace period has been end and queue sdp->work.
> > >  2- the step4 queue srcu callback has been intercepted by step5 srcu_barrier()
> > >  and start a new SRCU grace period.
> > >  3- this new SRCU grace period end, and invoke rcu_seq_end(&sup->srcu_gp_seq), queue a timer.
> > >  4- the sdp->work begin run, and call srcu_segcblist_advance() with current sup->srcu_gp_seq.
> > >  so the step4's srcu callback and step5's barrier calback both to be run.
> > >  all callback finished, but the len not yet update.
> > >  5- the srcu_barrier() return, begin call srcu_clean_up(), and then the srcu_clean_up
> > >  find the a timer is still pending and the cb_len also not be zero, trigger WARN_ON()
> > >  right?
> > > 
> > Exactly. The real callbacks are properly invoked as srcu_barrier() guarantees. The WARN is triggered only by the two transient states: a pending delay_work timer and a stale cblist len. So I think this is a false positive warning.
> > 
> > Sorry if my explanations were too wordy.
> 
> Would you like to send a patch to fix it ?
> 
> remove WARN_ON() or use rcu_segcblist_empty(&sdp->srcu_cblist) to replace rcu_segcblist_n_cbs(&sdp->srcu_cblist) ?
> 
> Let's hear Paul's opinion.

Thank you both for your work on this!  On the choice between
rcu_segcblist_empty() and rcu_segcblist_n_cbs(), if you are just testing
for zero or for non-zero, rcu_segcblist_empty() is better.  It generates
slightly better code, but the main thing is the improved readability.

I will take a closer look once you both are satisfied with it.

							Thanx, Paul

> Thanks
> Zqiang
> 
> > 
> > Thanks
> > Sunho Park
> >
