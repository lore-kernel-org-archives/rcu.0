Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBD3955DC
	for <rcu@vger.kernel.org>; Thu, 21 May 2026 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779346817; cv=none; b=d9VwKpOtw10H4cH7wM/O9GzuZ47BRtAvCpsGZzngS2cWZvky5RGv7HvTNxuNqmWdVz6AJO/bjcAd9Q8xVTXoFr/pXkMExdrAQGPePhG+eeHnNhMqYb/Z0+DEm+ELgG/eS4qXy2fyx5OZkcHV2kpIAy2/11XHs2OUnPfPva7DuLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779346817; c=relaxed/simple;
	bh=d63X+oFfSjcaBWqshGJfwLycLFMBJZRpHEnPMCuCVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bADqEM7CoIkVu2+6IDZhn/c4Lh5DYCum3b1OMm/IWpWb2VsZLb9cMrEdM/zutcrBPE6VG7f0tNUBp6FBkR1bl6dpiNTlfkbWkhumltdA2FUJYwyMIn0ZzGNvs4AP61CGqGpEwoAS0Tph9t0w8tmPELM9Veq2hcYC49tPmRjNgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fymXKRrI; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fymXKRrI"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-839dc688d6cso2539004b3a.2
        for <rcu@vger.kernel.org>; Thu, 21 May 2026 00:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779346816; x=1779951616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9hhUj3jZkDnmmSfY0KCk0TW5FKcGtMJ1hBup3liDLW4=;
        b=fymXKRrIcZOiKUcNJi7EIAYo6R9yLZIsuSIkubxcDatL7Mdv7ijUaDSv1/OyQb4qCY
         SLfn4M6yZ1hHphvAhg1dydb+NVIF+CArPV0HM038c1mMcCiqne9HakJD/wjb4I0PW+Qm
         K7YxBk5mEH0+cMR/u+DkwBeKIkQ3fV+f0BGUtN2+AuWUBvyHNFdFeDG1673OoxBJlUEs
         eMWkvrBVHCzGTbAyU0hkpGQkOH/P8T19ruvTqeRwniJ92Z3m4DZYPTjr5fU8xDm+Zp4U
         9Ce9WsQQsTJYGxUx9ElxZaDib4bL0hZuE5WlCvfCyKt28oYPh70Ird0b1FL7xGDoxEKM
         MyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779346816; x=1779951616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hhUj3jZkDnmmSfY0KCk0TW5FKcGtMJ1hBup3liDLW4=;
        b=TmHgAG4oksvPHYhoXDFDPlk20TjXyVAigTt4JDfCZZbe1XoDSW17g/Osa1w6VoEtL4
         +9Z0d6qo8HR3IBrd8BsZEz34udsSb9h1E1wC+a9ajlFSo8yy34Y2wtPZLrf6M9GCmi6S
         84HiEY1ZxkiSk2wcQ7YBfXKxVS1IIwyfaXW08cOPMF+7C+TRBnJu+SJLlNAzaOdUj4of
         lNWAwJj21AA+lv/vfFD37hY6be5iGXumpfF0w5pMu9uasQTIybdj16uNXLEaS51cHlAJ
         uX3DQZVucDA3q+DuKoizQd38FRWKomAQvKCh7SwsWjaCq7zTY+lB/zmBQW0fAsLEh4Mx
         ALpg==
X-Forwarded-Encrypted: i=1; AFNElJ8C/2j/SnBOv0vtcQb/noDcopDVQCm2n+gle8j3mg9XP0x5OgNAYApLVQj8JFwiTQNdGJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDLqf1rNzzre51UkuyfTMqdOHnMk7Lmjaq4L6nG535x/JmqNf
	UPK5M/NJjJyLRMXt4U88kXyXPajjLHvYOOYhJdSVg1/OVRikscpNs5oC
X-Gm-Gg: Acq92OHe9WPjQ3VczDQvjP5ysQhQzRph9T6h43DZqyqv+nJMyiICK4ewO6Z1AVHqClj
	H8971rLiAntzrKNJtH9C61Hu98Q8fme+21AK51ZGeRZLp8g3zCgyqbj2TbXqxbpcKApSdYLlDpJ
	zEaL900yK4RjDVU34KpsrR2PcNOQ7Zb0+flY8sibcsOaOdYuqTw7b1NbQQJHcccl4vkTvcJpPOW
	Lw0gycVNLJBQqTIIxXPqFzUgi82533g1OvlIdWS6O33qyqlA0NRXPwtkKOGB51H9jkAbU4LanfB
	YL9GPnAqWbfIcYiFG6yDR0xiyqbq34RKEnE5FtD5G08yt8zydtdMD28CrqHccI+VYV0/B9kdD0j
	uNZJ0/ikENYbsTN6w3a3F+DK+h0rWNRpgKpL40OcLp5ecA61hEArGPDChz0xUOzh7wQz4CyLDfs
	7SKJIuDwgwXdnl34dvna1Dq9d36axQZCrK4P0Q4W33JRfPHB7eUNOJ3ypKYmiOeDRSDYSv/pIv9
	KwIrQBi
X-Received: by 2002:a05:6a00:92a4:b0:834:e882:3280 with SMTP id d2e1a72fcca58-8414adf6975mr1742050b3a.31.1779346815565;
        Thu, 21 May 2026 00:00:15 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-109-223.dynamic-ip.hinet.net. [36.225.109.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841549fb065sm234017b3a.14.2026.05.21.00.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 00:00:15 -0700 (PDT)
Date: Thu, 21 May 2026 15:00:11 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260521143042.G853f@cchengyang.duckdns.org>
References: <20260519171745.1551340-1-yphbchou0911@gmail.com>
 <20260519171745.1551340-3-yphbchou0911@gmail.com>
 <e17e4c18-33a3-47dd-a866-e1e381b0c496@paulmck-laptop>
 <20260520222617.G302e@cchengyang.duckdns.org>
 <41dacbf1-8255-4101-b6bf-636fd7d81efa@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41dacbf1-8255-4101-b6bf-636fd7d81efa@paulmck-laptop>

Hi Paul,

On Wed, May 20, 2026 at 09:35:35AM -0700, Paul E. McKenney wrote:
[...]
> > > > +		free_cpumask_var(stalled_mask);
> > > 
> > > And free_cpumask_var() is happy to ignore a NULL pointer, so it is OK to
> > > invoke it on the pointer passed to a failing call to zalloc_cpumask_var().
> > 
> > One question here: Sashiko flagged that the GFP_ATOMIC allocation
> > risks deadlock if the stalled CPU holds a scheduler or allocator lock.
> 
> That sounds like a bug in either the combination of GFP_ flags used or in
> the memory allocator itself.  It should be possible to allocate so that
> you either get memory or get a NULL pointer, without risk of deadlock.
> 
> What am I missing here?
> 

Ah, you are right here, thanks for the correction.

> > Rather than keeping dynamic allocation with cpumask_available() guards,
> > I was planning to pre-allocate rcu_stall_cpumask and rcu_exp_stall_cpumask
> > in rcu_init() with GFP_KERNEL and clear them at the start of each stall
> > event. That would eliminate have_mask, cpumask_available(), and
> > free_cpumask_var() from the stall paths entirely.
> 
> Please note that rcu_init() runs when there is only one CPU online that
> is running with interrupts disabled.  So the fact that GFP_KERNEL works
> in that environment is because the memory allocator is interpreting it
> specially (see GFP_BOOT_MASK).
> 
> Does static allocation work?
> 

Yes, static allocation works. Declaring:

	static struct cpumask rcu_stall_cpumask;
	static struct cpumask rcu_exp_stall_cpumask;

and calling cpumask_clear() at the start of each stall event removes all
allocation, NULL checks, cpumask_available() guards, and free calls from
the stall paths. No boot-time failure path to worry about either.

> > Does that direction work for you, or would you prefer the dynamic
> > allocation path with proper cpumask_available() guards?
> 
> On the one hand, memory is getting expensive.  On the other hand, cpumasks
> are not *that* big.  I prefer dynamic allocation, but am not inalterably
> opposed to static (or, *almost* equivalently, boot-time) allocation.
> 
> The "*almost*" refers to the fact that boot-time allocation can fail.
> Usually, the system fails to boot in that situation, but some sort of
> check would be good.

Given that static allocation avoids the failure check concern and
simplifies the stall paths, I will use static allocation for v5.

Thanks!

-- 
Cheers,
Cheng-Yang
