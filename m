Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D3F3AD520
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779176631; cv=none; b=KiZkp38QXjodQ9QzQwBhXe/TmwgbXHPu/eRJjV9OPdawo7IXD2HysKF1c7h1LxOfS46Qb9U7MZ6Fdvsu4pc7Xq27pTk0vxVxKosPHl3B83quKs6whVh/FKguedC9lU8OBvZfoFXwHnmMm3UM7LpKxSirVHM/mRfLlujbBdDZ7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779176631; c=relaxed/simple;
	bh=Ma73bIKtXamBlWaM/VDHafxoPoVAW+jzx6syH3yqYyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECLybm0aCbvG7+q5eIEtc7suWDXushAutxaUJocgwmJuNdePUU8hEcFLoa+2w817bU+GNvuiKk7TlKVzF7rRk9A6B+L5yulnUQnmGotT69qQV2HTDSFpT106hy/wqLLylOGixb4XXpBPBgjaeGzMwPyxckKzkLfwr+EV5Do6Kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIGMeWCC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIGMeWCC"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-369576666d5so1442592a91.0
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779176630; x=1779781430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OYHCHqqXvael8k8ZlnLK0HvHIXLjQQYj+ItChZNwZ6U=;
        b=kIGMeWCCoz3TK8NoKLJButdJZtz0g1G/ldKA+0hpAA6etAKYcyx7eqg0t85O24j5L6
         DNoTL8mGh4MLpkDPa90jkIiE2o3qb39G1FnN4VbChExzw/IM/503jGKupNwZopXHgMk8
         ko/kTietasnc7qZlW4BsBYSufmWS6yDgkUVN9TSyVbR7qDiYB3EZOJ6JnpTerSnWdF9+
         P4aY7UDEM7kzlyuGbypRLGasB9KJdP2Jfs86yfoQ2++fSbM2cSDi2bp93xus7nQRmQ0+
         NuOz0HWRvjZ3YmFFLSbCu1jG/I3Q70x0CtIrBkenR8uYewm3KfmfdY/nlJ6zS4cFE802
         9/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779176630; x=1779781430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYHCHqqXvael8k8ZlnLK0HvHIXLjQQYj+ItChZNwZ6U=;
        b=GWQhjsqhHE/BA82kgKnZtD98KSYkQkZFI9VNZuZPlJP4LkfjNiKgG0zczGf0XRfigN
         or3u8WKnhrYGRjwR6h33yoFFQ0d/Mk6KdVAVdiKjpNImUynNEQodX0wCJE2bJi5T8mXt
         ahIjnFs5X7hmGh+/N22bavuJjLAoXI1IKSfRbU7amBmcy1sGjlp4lMWUfarmB+RcmLRX
         3zwATdYvJBWSeA3q+sqEtJG1hJAH7DKOTvvGpaNBwCg6GFJ+sOCZJ166Hett9HhMSctQ
         WHGt0+CCs0oAiP34hrIBAwyl17M/yt+QFxjGVBmh9Y5b8G8YMLVME8a/3OQG42ibwKgJ
         NsAA==
X-Forwarded-Encrypted: i=1; AFNElJ/wjAgv5k7MX++0eHwjIQyG4hK9AJiRxDY8jCsYObEMUjL2zzYL4u8F5TBqGOrsF6Y+Qs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIioYW8C6sKGdbWmmaL5D6qUxdmrPaaXPlToTn3qi4Bb4b8m06
	M4XVxO033HkkaHcFEKstxSj++vSddbc8ZEqN8f7vDGr+9V//8q5tYHk8
X-Gm-Gg: Acq92OFRm0gYhIEkkbpoGIXY6SoTQ6BXzoUDCjZ5s3uMPix9mxDDRWQA08zG7kuJEYs
	vBw4xJFLwI/4w9PcVT/q7UqkukgknO2Ql0UzuM4Y3sUy1ULwpJBZr5cqtNzFBXkcqzu9BBhmSWg
	fThwsKgLlJcMvZio3GyAd4MlFkNzbL2dYw7Nln+JsXNorTaE6J/QO8BwuQzTBAXpU8fnGVl4I/u
	ZyN6Gcs54mVkdAEAcZjMBnvvb2qPheUKPre2PW+YlPM8fnYxsBJXGAszAhGrObPwl1EAaCqjZqC
	kUTGwwqqzaDWoOTeNPf+HPfbkuWZZ2Rk76Ynh2kqxsuXieHPeTHIta+ug3K5qKQmWE7fhQwio5U
	5msf1iqhHKu74JErit16fJEJ+jfjobOX2x82GvuE9qqYxb7ljsjFTKTqpxh5MPHYl53waHz6f9E
	yX0r6KPiylEqEV40oJpR644YeH7wsGPR/fHYwZEICgXsluOkjJlxQjmeAbS/tCYcZMaBKO+7WTG
	cEhaA==
X-Received: by 2002:a17:90b:2742:b0:368:cefe:ddd0 with SMTP id 98e67ed59e1d1-36951b82f8fmr19049211a91.15.1779176630003;
        Tue, 19 May 2026 00:43:50 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-116-93.dynamic-ip.hinet.net. [36.225.116.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424c2sm13554811a91.4.2026.05.19.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:43:49 -0700 (PDT)
Date: Tue, 19 May 2026 15:43:45 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	"Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v3 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260519152904.G1f99@cchengyang.duckdns.org>
References: <20260518131311.1170786-1-yphbchou0911@gmail.com>
 <20260518131311.1170786-3-yphbchou0911@gmail.com>
 <agtoyycMdwatAiFc@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agtoyycMdwatAiFc@slm.duckdns.org>

Hi Tejun,

On Mon, May 18, 2026 at 09:30:19AM -1000, Tejun Heo wrote:
> On Mon, May 18, 2026 at 09:11:49PM +0800, Cheng-Yang Chou wrote:
> > +bool scx_rcu_cpu_stall(const struct cpumask *stalled_mask)
> >  {
> > -	return handle_lockup(-1, "RCU CPU stall detected!");
> > +	int exit_cpu = cpumask_empty(stalled_mask) ? -1 : (int)cpumask_first(stalled_mask);
> > +
> > +	return handle_lockup(exit_cpu, "RCU CPU stall on CPUs (%*pbl)",
> > +			     cpumask_pr_args(stalled_mask));
> 
> Wouldn't you want to pipe this down so that you can prioritize all stalled
> CPUs when dumping?

Ahh yes, will add stall_cpus to scx_exit_info, store the full mask
there, and update scx_dump_state() to dump all stalled CPUs first.

Thanks.

-- 
Cheers,
Cheng-Yang
