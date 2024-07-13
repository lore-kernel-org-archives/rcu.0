Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E25918E20;
	Sat, 13 Jul 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720899131; cv=none; b=tX1m/ixc6sVQnJYVHB7AZy23cULfFbUBylzawfIOVEmyo28Mhga85qumRyAvGF9dAEaV3bua0diz9Y1hLYsJw6z6VgMvgZfKC6nkj/ZYuWIrOwYtNKgbO3Kj2PuSvgTIRR2ohHjlvTD7eTniAf2FbzNJhvxZGIJBk8fUwk/aKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720899131; c=relaxed/simple;
	bh=GsdSioRswa5ZtwiNP4Fqw+tz6HJ1LDN6fkMxS0buikA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOh2WSPeHL5bYfKUbdfZ/gZtxRiugnIq80eosQOry4Snh4TEEL4Am06MBh/IbAqQOYWLMeEVe63g+dRJ9M/PhSi8h0t+sZtp5eJPazQX+FVtGY8m+mTdNsQBSiLSMjIUpQJFUmZ1EdEzbds+EtKqJ4Fy1cFctsV+xK/RW2UpDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bc0mIFIk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bc0mIFIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AC8C32781;
	Sat, 13 Jul 2024 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720899130;
	bh=GsdSioRswa5ZtwiNP4Fqw+tz6HJ1LDN6fkMxS0buikA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bc0mIFIk2NuSGdrG80Dj0ECDoC/ek18aeBhrXsGculeF0LFi/g7XyXY0hB15Rwdyn
	 /QtXj8JoP7lhrBlgips+SXx1ePAnBfEi1kDGm878gLrfi01ySVdcbeDC3h9BvaC7bM
	 exaLQ+ao40/yCxoYzIoZYS6gmxqJQQTEyVwN6+v6+r28UxNHgVuUpTfih6yqWDQyfx
	 Df+X+BjEt7AjtRBsK3pclThskwJoHblPNxvg+symj9qh3bpF612mFrEb/k5L6KJa1C
	 4+jKfH5RF10hsLJmlUWcGjSEbAuIXQhjT4YMGmHnDpDsOge8MZOxJoLU4G9j4tL3C5
	 8UKsC1uOv9xfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6A711CE09EE; Sat, 13 Jul 2024 12:32:10 -0700 (PDT)
Date: Sat, 13 Jul 2024 12:32:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Rik van Riel <riel@surriel.com>
Cc: neeraj.upadhyay@kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	mingo@kernel.org, peterz@infradead.org, leobras@redhat.com,
	imran.f.khan@oracle.com
Subject: Re: [PATCH  2/3] locking/csd_lock: Provide an indication of ongoing
 CSD-lock stall
Message-ID: <ed89d87a-027e-4a99-8437-28258fd0f691@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240713165642.GA215331@neeraj.linux>
 <20240713165846.216174-2-neeraj.upadhyay@kernel.org>
 <ee33a2c3e32d98b5fc04983745c47f918f9ea2d2.camel@surriel.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee33a2c3e32d98b5fc04983745c47f918f9ea2d2.camel@surriel.com>

On Sat, Jul 13, 2024 at 01:16:47PM -0400, Rik van Riel wrote:
> On Sat, 2024-07-13 at 22:28 +0530, neeraj.upadhyay@kernel.org wrote:
> > 
> > @@ -228,6 +241,7 @@ static bool
> > csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> >  		cpu = csd_lock_wait_getcpu(csd);
> >  		pr_alert("csd: CSD lock (#%d) got unstuck on
> > CPU#%02d, CPU#%02d released the lock.\n",
> >  			 *bug_id, raw_smp_processor_id(), cpu);
> > +		atomic_dec(&n_csd_lock_stuck);
> >  		return true;
> >  	}
> >  
> 
> So we decrement it when it gets unstuck. Good.
> 
> > @@ -251,6 +265,8 @@ static bool
> > csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> >  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d,
> > waiting %lld ns for CPU#%02d %pS(%ps).\n",
> >  		 firsttime ? "Detected" : "Continued", *bug_id,
> > raw_smp_processor_id(), (s64)ts_delta,
> >  		 cpu, csd->func, csd->info);
> > +	if (firsttime)
> > +		atomic_dec(&n_csd_lock_stuck);
> > 
> 
> However, I don't see any place where it is incremented when things
> get stuck, and this line decrements it when a CPU gets stuck for
> the first time?
> 
> Should this be an atomic_inc?

Good catch, thank you!  I will go get that brown paper bag...

							Thanx, Paul
