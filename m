Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395773D6CB1
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177796; cv=none; b=Qu6IrL32e58TUe1DFGq2x3RYqd4fFCaio0J/YmZYk5HNDVwdPBzsucOKRp1nkYaMQLfeZpsk6XWeAuPvXvleDS2kJIG7giGL7Wjbk21cKEttBdfJlynXknAYUvi+tFKBkErY0DiF8TbHpgVrBw4fMHSfavXrapn3kF2UOurqgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177796; c=relaxed/simple;
	bh=LUHLBLA+t+dlz3Pkv1Lh9An71O0/RK94P+VoQ+FOVkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6IG879I3DVSqJkb5VdBZkYP0bMkcM6G20y6mCzlcbtIa3OWcBwqjjlKQ0dGus9cnlQXvW/BtAkJOBjdvfmFJ3faRvi34zKittpgIlaaB5R7gxlnMQArYRN+G7+dQDbYD8DnpvSLkV4eOOSFA0jsZK0jVzMluHvyR2HULtCJL6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GF25xQ4D; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GF25xQ4D"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80167f56cdso1361604a12.3
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177795; x=1779782595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FzTmNwB8gsREOlS6zByQH9A1MxUASfb5z5mhpssClQs=;
        b=GF25xQ4Dmu9v6+Fpcc2epK8WV0tQfdrts7TkxZje8RVdcuHkd5e3zSjcdy0AIqA3Xk
         qzlu7gEcc3dbfHSm9jjdFj8bAPk9VjXdb3CXsaWH0iiziCCrTo0vKwxOezkE/mffI7np
         Ge0NWiUg4b7AK4v1ICFRPL6iQE27Zw9UxBLS5Gw6EuypIvqnI99wgES03brCxze0VQCF
         OugVa6Fljb19eU9qqi8JfWi7vrdrz/m+VSmtvwtuWLShhvVLEG1a7E+8CAYM3kc165h7
         +ANogRihdkGKf7/RhemZGacxRpstWB5LCbxA8B+Q0BRvTmjHw73EgZRo6CeFji2nb7xp
         lsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177795; x=1779782595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzTmNwB8gsREOlS6zByQH9A1MxUASfb5z5mhpssClQs=;
        b=A+gbySNGaNPdFCAo2T8UlFcISf4qBOkkFs/X0xVi3E+QKQb7CGe9Afb/dniPFn1X+A
         3USO7FfvOMGe6xtgKK1/VLfclbBIJQKP8NmWX+yRCqGkk1YQgL0zEMn02RORBQaAnTyB
         YzMKCa7tJr6fiQH6/Ulh4xwkjMX/K1fWDr0dP7zYALQL6ZMGYdvcltfrNXq7g5p3lM0T
         EgU0bpuG1OM7iOVIhhLVrppbxQrFs9yFuyMpHZ4Wqdas5t4OA8LXY/M9bOpujqSdhl5g
         595CC3Ww3xEMkxxB/td+Poi3W5Tzld3LMa3aNuKBu24w24+Z8td0LNjAls5rQt7/rAjU
         DPig==
X-Forwarded-Encrypted: i=1; AFNElJ9RdU9og3ysRaEQl2qKORzlgyvo9Mp6D9wcBsKxxGz+MIJMEsGzA+ISc0ZDjNbPACI61k4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz57rSz8W0zjdGYHv4zZB+mf4bgX2RnBINSaHQmTQZEkd63sVdF
	64rZuLEzb6MuS2nTCnW8HatHVBNVvbYrfeRpv0DH/+qkyCLfeSyZGJHf
X-Gm-Gg: Acq92OGPa5wtdBfMtFVb6trlc9vo+5W+SAxNc+kfnw/yFJRps2Ik+b3DkMFyovmpZQa
	pd+xaPrfqRUQMTribd+73CiTJtujiEev+pU6LE+KibIJfUMskJp0jt2Sa6YQbn+Hq684mHBKMMl
	KGbgEQCS27btNGlcx1qJLZAzeEk+J7SFwQsLtc8G0pgJOXDkhpYVCvLHSA/1jO33sR7DEZSc+Gp
	rhtnoYM1qRPESdV3vo9AokHUbTErCAGag+J/MPxvWVQ5eM4e7Kha3exhD73GR8+eOw4kOksVtht
	ytP2xT9dH3jZAINRvBjDSP5eHdLWzkvIXFqqbNrkTd/oykz92WB9Xzt/sFjBjungjpAZa3bRv0Y
	4H45tyU0/COUM/VcWKV6ibVBqUU2jP4MGpCwvdwxh4CLN6Oat0F4THtYEZtjmWr+V/np00gI8Wy
	uoAXHjukIkdZIs2xMYWB+Fe0dD0lkEDNeiy75B0Fh388IMjdn5byT59smXDOhS4zcPEzzI9H3xI
	hV+VYzv/YVODwpd
X-Received: by 2002:a17:902:7892:b0:2bd:63dc:b7ad with SMTP id d9443c01a7336-2bd7e86c6b1mr144453945ad.2.1779177794505;
        Tue, 19 May 2026 01:03:14 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-116-93.dynamic-ip.hinet.net. [36.225.116.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11d6easm191361105ad.72.2026.05.19.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:03:14 -0700 (PDT)
Date: Tue, 19 May 2026 16:03:10 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260519160158.Gad1f@cchengyang.duckdns.org>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
 <20260518131311.1170786-3-yphbchou0911@gmail.com>
 <agtoyycMdwatAiFc@slm.duckdns.org>
 <20260519152904.G1f99@cchengyang.duckdns.org>
 <agwW2PET7rOcL_87@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agwW2PET7rOcL_87@slm.duckdns.org>

Hi Tejun,

On Mon, May 18, 2026 at 09:52:56PM -1000, Tejun Heo wrote:
> On Tue, May 19, 2026 at 03:43:45PM +0800, Cheng-Yang Chou wrote:
> > Hi Tejun,
> > 
> > On Mon, May 18, 2026 at 09:30:19AM -1000, Tejun Heo wrote:
> > > On Mon, May 18, 2026 at 09:11:49PM +0800, Cheng-Yang Chou wrote:
> > > > +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
> > > >  {
> > > > -	return handle_lockup(-1, "RCU CPU stall detected!");
> > > > +	int exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> > > > +
> > > > +	return handle_lockup(exit_cpu, "RCU CPU stall on CPUs (%*pbl)",
> > > > +			     cpumask_pr_args(stalled_mask));
> > > 
> > > Wouldn't you want to pipe this down so that you can prioritize all stalled
> > > CPUs when dumping?
> > 
> > Ahh yes, will add stall_cpus to scx_exit_info, store the full mask
> > there, and update scx_dump_state() to dump all stalled CPUs first.
> 
> I'm not sure I'd add it to scx_exit_info as that's public interface. Just
> pipe it to dump?
> 

Ok, just pipe it to dump, will send a v4 patch soon.
Thanks.

-- 
Cheers,
Cheng-Yang
