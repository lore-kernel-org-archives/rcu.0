Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEE93CF66
	for <rcu@vger.kernel.org>; Tue, 30 Jan 2024 06:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706597906; cv=none; b=SVetkpa2G87n8NWTWioyc6XwBeKM4IOjdcEmDtCwdW7sFVxF7+/s55VByZs5jN1fudLIjTti85u2NA2b/oNR1I258zCZjhJM4siYohDPVOcxZ6TC31H6j1R9kJyKR6xHjXWty/uso1shl6oyB9OYl/cDwSy9LvMgKRfe7eCaOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706597906; c=relaxed/simple;
	bh=+mN04OYxTwklJfBwUh+ouOVD4RdXKyAK8nEAuwM811o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG/uLCgbX29ECcNAqlndH+AvLCuSxVaU2UUJzVmB2lmTsJTAcff/95+mYw/S/CM7klKY07Gpp/7MEuM+ue0HuMV/7T6WsfJGodaSILxrVe+uK3LKc1I3qvmNrudiQ9tLpcz2oyp0A3jAsgv4rGu+xMScjZpqvkkjgMy7tlopVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XZrLZgqi; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XZrLZgqi"
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C49E03F5DA
	for <rcu@vger.kernel.org>; Tue, 30 Jan 2024 06:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706597901;
	bh=OkKEAPuQY6Jk+mc4uBLBeXL2S1t9w2MRwMzU4/LZJLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=XZrLZgqi2+DgTOdoJFgJw9E8OW3eaIyDQnFQsA5Ik/aaOlxzCnkUo+WpPOoJqwxJ6
	 xm2l0rznHvlaG588zaOanxy8YFjbtowaz6zN4987/wcLsz9pWqT4mVB6qBR/flmqwa
	 xIWA26FeC5MA/YO3MCTvmbHJFjNzS6EAXbuwSLYDs6XR/FT1aldCzEmBnLXd25qpbc
	 jqX+++3gayxi+2CrpjUFYiBcMBysk4wceuNcaqGFae78giyG9KToBXkWosmDZuRV9M
	 I8diWwDqknoPM2gOk5w2qi3qhsaPe9lHZc493VAcx7rqZWK0fMAAW1GF8vwJXJdsrq
	 0aGGPTCmmODhg==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-55f3f3533e0so190171a12.3
        for <rcu@vger.kernel.org>; Mon, 29 Jan 2024 22:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706597901; x=1707202701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkKEAPuQY6Jk+mc4uBLBeXL2S1t9w2MRwMzU4/LZJLM=;
        b=kBmkdKs2XdAyRHMMMKS8dioTmJSKXMJ+69rpn9c+GyhIy9hXXS8xguPXxXTHt27g+N
         2WcTL0SXrfY4nUHd5cd41Va8Zfa3EXWjFxuqiMGE7ns2IaZB5Xti37JIF2RFbi5W/A1K
         0Hbngrc5A/Li/urOGedfcAWTyrHDiZkx9EcRuRwyLFQfTfeZUkEjrgWeLxHWlJ8DdMP7
         tp9BJTo4WU1aCM+CdnXVKnd9SY/JodXZeKddxaQyMhFOZ39Nukcwhp3ILAFXlqeK+VgM
         Cl6bTMFEs0t5dvCpcWkpbFZ2xv1OoqvS1/yvsqA4c7EipR4eFVz0EXDsNgQ+GBioioiE
         Fp0A==
X-Gm-Message-State: AOJu0YwjF5O2I9/2kgl7PrrJS+3WK85A8JQ/SixHJbNrkc+BhYWDRIWE
	CuhUKPnvcn8Vqh0UPTjRiSxZOUaOvPY1ua9fXQrTxeuto8cJLNaErh4/Y/geqJK5I7U1rAsMB4q
	KnZBadcvJYviNQj6LlTWWbQUY3IQiccaZ2m0P2sNtaOXeSBMdKOYchC7214SJY1wL6g==
X-Received: by 2002:a05:6402:2741:b0:55e:c56e:b210 with SMTP id z1-20020a056402274100b0055ec56eb210mr6162621edd.17.1706597901228;
        Mon, 29 Jan 2024 22:58:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMnWn40vsmanGnAmrz0yXPZC7Y/KJXtKn5qBhhvDT3NVStncMxWpKxJ2qwtYlhKboaYhYtrg==
X-Received: by 2002:a05:6402:2741:b0:55e:c56e:b210 with SMTP id z1-20020a056402274100b0055ec56eb210mr6162607edd.17.1706597900843;
        Mon, 29 Jan 2024 22:58:20 -0800 (PST)
Received: from localhost (host-79-33-203-37.retail.telecomitalia.it. [79.33.203.37])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0055f0c027a3esm1474495eds.30.2024.01.29.22.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 22:58:20 -0800 (PST)
Date: Tue, 30 Jan 2024 07:58:18 +0100
From: Andrea Righi <andrea.righi@canonical.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: paulmck@kernel.org, Joel Fernandes <joelaf@google.com>,
	rcu@vger.kernel.org, "Cc: Frederic Weisbecker" <fweisbec@gmail.com>
Subject: Re: Observation on NOHZ_FULL
Message-ID: <ZbieCjYk8cIgZS8L@gpd>
References: <CAJWu+oo8w6zc=m7f9vkz66xYZnoCqs1FrgmLtcWxEpE5QCJgig@mail.gmail.com>
 <6a2b6857-57e7-4321-adae-132ba69a4fff@paulmck-laptop>
 <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e15e91e-da47-45dd-b7de-7f89b7b6002b@joelfernandes.org>

Hi Joel and Paul,

comments below.

On Mon, Jan 29, 2024 at 05:16:38PM -0500, Joel Fernandes wrote:
> Hi Paul,
> 
> On 1/29/2024 3:41 PM, Paul E. McKenney wrote:
> > On Mon, Jan 29, 2024 at 05:47:39PM +0000, Joel Fernandes wrote:
> >> Hi Guys,
> >> Something caught my eye in [1] which a colleague pointed me to
> >>  - CONFIG_HZ=1000 : 14866.05 bogo ops/s
> >>  - CONFIG_HZ=1000+nohz_full : 18505.52 bogo ops/s
> >>
> >> The test in concern is:
> >> stress-ng --matrix $(getconf _NPROCESSORS_ONLN) --timeout 5m --metrics-brief
> >>
> >> which is a CPU intensive test.
> >>
> >> Any thoughts on what else can attribute a 30% performance increase
> >> versus non-nohz_full ? (Confession: No idea if the baseline is
> >> nohz_idle or no nohz at all). If it is 30%, I may want to evaluate
> >> nohz_full on some of our limited-CPU devices :)
> > 
> > The usual questions.  ;-)
> > 
> > Is this repeatable?  Is it under the same conditions of temperature,
> > load, and so on?  Was it running on bare metal or on a guest OS?  If on a
> > guest OS, what was the load from other guest OSes on the same hypervisor
> > or on the hypervisor itself?

That was the result of a quick test, so I expect it has some fuzzyness
in there.

It's an average of 10 runs, it was bare metal (my laptop, 8 cores 11th
Gen Intel(R) Core(TM) i7-1195G7 @ 2.90GHz), *but* I wanted to run the
test with the default Ubuntu settings, that means having "power mode:
balanced" enabled. I don't know exactly what it's doing (I'll check how
it works in details), I think it's using intel p-states IIRC.

Also, the system was not completely isolated (my email client was
running) but the system was mostly idle in general.

I was already planning to repeat the tests in a more "isolated"
environment and add details to the bug tracker.

> > 
> > The bug report ad "CONFIG_HZ=250 : 17415.60 bogo ops/s", which makes
> > me wonder if someone enabled some heavy debug that is greatly
> > increasing the overhead of the scheduling-clock interrupt.
> > 
> > Now, if that was the case, I would expect the 250HZ number to have
> > three-quarters of the improvement of the nohz_full number compared
> > to the 1000HZ number:
> >> 17415.60-14866.05=2549.55
> > 18505.52-14866.05=3639.47
> > 
> > 2549.55/3639.47=0.70
> 
> I wonder if the difference here could possibly also be because of CPU idle
> governor. It may behave differently at differently clock rates so perhaps has
> different overhead.

Could be, but, again, the balanced power mode could play a major role
here.

> 
> I have added trying nohz full to my list as well to evaluate. FWIW, when we
> moved from 250HZ to 1000HZ, it actually improved power because the CPUidle
> governor could put the CPUs in deeper idle states more quickly!

Interesting, another benefit to add to my proposal. :)

> 
> > OK, 0.70 is not *that* far off of 0.75.  So what debugging does that
> > test have enabled?  Also, if you use tracing (or whatever) to measure
> > the typical duration of the scheduling-clock interrupt and related things
> > like softirq handlers, does it fit with these numbers?  Such a measurment
> > would look at how long it took to get back into userspace.
> 
> Thanks for your detailed questions. I will add Andrea Righi to this list thread
> since he is the author of the bug report. Andrea do you mind clarifying a few
> things mentioned above? Also nice to see you are using CONFIG_RCU_LAZY for Ubuntu :)

Thanks for including me. Sorry that I didn't provide much details of my
tests.

And yes, I really want to see CONFIG_RCU_LAZY enabled in the stock
Ubuntu kernel, so the battery of my laptop lasts longer when I go to
conferences. :)

-Andrea

> 
> thanks,
> 
>  - Joel
> 
> 
> > 
> >> Cheers,
> >>
> >>  - Joel
> >>
> >> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2051342
> > 
