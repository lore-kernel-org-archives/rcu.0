Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD49225A5A;
	Fri, 20 Dec 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734738201; cv=none; b=LgDTLddGFgI11jSRcY2BboFlFMUNo+zoqoAKROAzTZD/l61D6vrZgTaqX11E9UAHbjB9M5+heJVMrL4GLibrRTodeB2JrfHupTZy+dUnUIdRWe0MUV/gtLc9dRokQ1xC83nkZ0Q04BpFupeCJVSairjb8KdiQQaYciCJghZZQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734738201; c=relaxed/simple;
	bh=XANWQpmPUwonTu6y7W6CTiM3uGmNOjJvGWNUk+0JA2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvA+6ATw3H3RJaTv5lOGOpQOAr6GO9wIgr12Imkwip7JVy6B48gx2qOtMyy5438Yhb9SAF9WThrlQRATrJIMAwxDiuxa6d2vR0zFhveT2jOGR+FgWbMgi5MQBLvYjAYSWv+VAEI2jlJMWNm8aXwXEBll8Tg0drnR8Evk/De8G7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmP9/LDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmP9/LDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9984BC4CED4;
	Fri, 20 Dec 2024 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734738200;
	bh=XANWQpmPUwonTu6y7W6CTiM3uGmNOjJvGWNUk+0JA2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YmP9/LDyk2WyJe4SluxUGZyQk5/k/Tqe4trRczxjfgMrf7ouUbyN21O7DDZGGZaWQ
	 6GuQEuFPqfwjV584aHUQthXCnN63fRpmPi5b2rpkriFHZZoBl0AT9D0reuobojMrp3
	 Uqt6AoT5zTvqTzilDuzOeNivbA8wKEGhCN+nL8u0cHJ+WqenpyuE6Bf9EjZpqAd523
	 3gDlcTz6u6i6r7HqTdu5ZrvTaJi8Uqz2PcNk/9owEpHmPRcVJJzHjs6+tbkEaCU8NV
	 y0Sb0DJvUTPCjLFZTu7g8sC31WZVgS6ufvZcshTvjldRScody4NW8Mr+N6zKwn9bM7
	 hIQ8RQbluUAuQ==
Date: Sat, 21 Dec 2024 00:43:17 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, vlad.wing@gmail.com,
	rcu@vger.kernel.org, boqun.feng@gmail.com, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, Cheng-Jui.Wang@mediatek.com,
	leitao@debian.org, kernel-team@meta.com, paulmck@kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 1/3] hrtimers: Force migrate away hrtimers queued after
 CPUHP_AP_HRTIMERS_DYING
Message-ID: <Z2YBFQ_WNm60HTx4@pavilion.home>
References: <20241218165008.37820-1-frederic@kernel.org>
 <20241218165008.37820-2-frederic@kernel.org>
 <b2d31c28-96c4-4762-a0b4-686713bc6778@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2d31c28-96c4-4762-a0b4-686713bc6778@gmail.com>

Le Thu, Dec 19, 2024 at 10:00:12PM +0300, Usama Arif a écrit :
> > @@ -1240,6 +1280,12 @@ static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
> >  
> >  	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
> >  
> > +	if (unlikely(!this_cpu_base->online)) {
> > +		enqueue_hrtimer_offline(timer, base, mode);
> 
> Thanks for the fix!
> 
> It looks good to me, maybe as a follow up, we could rename switch_hrtimer_base to 
> enqueue_hrtimer_local? (or maybe something more appropriate)
> There are now 2 different paths that switch hrtimer base (enqueue_hrtimer_offline and
> switch_hrtimer_base).

I considered extending switch_hrtimer_base() instead to handle offline
CPU from there but that turned out ugly since what follows assumes to either
queue locally and possibly reprogram or queue remotely and not reprogram.

enqueue_hrtimer_global() does only enqueue remotely and possibly
trigger a reprogram.

And indeed we could move switch_hrtimer_base() + enqueue_hrtimer() +
hrtimer_force_reprogram() to a enqueue_hrtimer_online() for example.

Perhaps that would clarify things a bit, I don't know...

Thanks.

> 
> > +		return 0;
> > +	}
> > +
> > +
> nit: extra new line above.
> >  	/* Switch the timer base, if necessary: */
> >  	if (!force_local) {
> >  		new_base = switch_hrtimer_base(timer, base,
> 
