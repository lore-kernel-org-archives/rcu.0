Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F3368299
	for <rcu@vger.kernel.org>; Fri,  5 Jun 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670012; cv=none; b=LHOqaZwjk/iDFTqB8bEW9fuVkuXHwd29OYQc5BEMx5r3xiYchkH5m14jNMFmw4yc9kM9r82GTbAySWn3lDjrb5pteflQjJqNLkLQz18RdDc7MEmRPMNpSdotMFCwojR+GzkdB/WbN38Vgh1p4AD5kLMbHGfYZ94NidVmaG2XbVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670012; c=relaxed/simple;
	bh=lEPb8QCE5aw8R5/q3CiaERnDfjzcpKrKM4kCtHSpwBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF7ouD2+JP0RUru9Wv1RJzYCEKWr4+7puyG9Z2gPxdXgbl9IU6drxYREQn20AbyfG9G0PrtXYWHQ8wblworh9y5lrRqlFfW10B9CM4nIlhYewqm4064xfwqfIgE6ltS/T16uwGMA9RQe7uoenfFaOjM+mUkpfxCIkUXm+b+lJnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5EVXhBa; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5EVXhBa"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1363e78746eso2145533c88.1
        for <rcu@vger.kernel.org>; Fri, 05 Jun 2026 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780670010; x=1781274810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYBmRS0ychjc3ot497BNA8iEuuGUaJ/uihQW0fCPGsE=;
        b=j5EVXhBaz/7KI53vCz+BvhCEkl36aGpDbVtSHvYFFjsMa1W6JCBDeA6t3EXaLDU2WA
         qXaeobeKX/ry7/G2CYdndS5xEQBoZ+23BISoe38pvroIArlXrHoPKHieSg42OT+SgLU7
         +JlKYBI6iThnm0S+RFAiW4LxCjiAB41oqpkbIy21mu+kzfWpyC7Hhu3vIBGNCDxmfA4o
         TKvmPiRWdGTghUyynak4x4uUv4nl+YFJmZH2mc9Iisojc51abliUeCBSl0uUIz9U8HT9
         HiqfjxDSAng8mNCv1mQhkXvy36GHJJK1jyVyqPQZsYUaCQCV7CpJbnqWoQyGBpeI7MMh
         iQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780670010; x=1781274810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYBmRS0ychjc3ot497BNA8iEuuGUaJ/uihQW0fCPGsE=;
        b=iqu9u6FHWvyubRSVxJyvo0wDeiigZpjNqrZhM3vk3b+6TxEUyPBXw6ejFMkIzIR1vZ
         sE3ptw0E68m+D5WHTpmdryZB0N6u0os7UhRMKgIUVNio/vQLmqmQAMyQaN7j8PnYlH5/
         8x7V9Hu0oqC8A1E6Yb3zRMQKoBldYuFhT9ToxFHp6jfiZxgqCA69DOrv7Wf/Xz6prhBL
         Vzo5YF+AsQH1NczF+27MaNfi8ZYHd6/RrrHA3mfDjr8yEZGXjojdBRyUzcXe3V++E+bv
         9ST9KyfkT68c9t8Ywf+oJzv5yL1KLkYIbMcpxats1ykgWlU40d0Tdn6Zqv1c43f6BOCl
         DiEA==
X-Forwarded-Encrypted: i=1; AFNElJ8FytQEgP6RiiCqnQFmPec8Vrqo+KPgea0LSmO2V3ZJY6KKgY4awMxG3QwNndo/hfEFPUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxubBLqSVmvn3lfHRmtFf/3p/ulb9OyRP2MwMPcv2+x/xJhXIp+
	RKYspBQV+xSazXJ/6spzl6JlCLQaWuVUZoPV2/M8h7whbyEOqlwZ/NbJ
X-Gm-Gg: Acq92OEgDNUVHitGJA0dNJdKBJ9Xn0hUZMutuW29er1uyDiEL7wp5wTWqYrUoxocJx+
	OxRnA8CeIazdVEIQG9OlLLASxWxZXdvT0XP0cY8PnlRcX+068p6IrvRf2R24rX1ckUcw7pocrsM
	oTyH4jCQXeJTzfQk/N39Yy8vf8OshBLjXrr09gXz6mYua/xFGoQhVVMn57Z/e9egSGEQ+uoYBS3
	ZKvcu/9N7/TIwatnSxXHB6SnPAZCoDnvdRNF1YT4KSi+X3cnldlFmJ3MZCVM1HXA1RVdgytRkfZ
	ZseqtBLUEGVDIZAW069uoWofIKBldiMlYrx+dZD77NhDU3L+S8d9hPO4riCXJu2rVELYUXFK69g
	SV+MATjIx2QwZcxF9bD4CRgRMMFtsSmFlzB7Y3P9xnkxNbUvzNxhhfodQzNuVSA/jnqqzk1rTsj
	rBOZr0HJrzV7Eh/2YYmJhegucA/SBpyzF09QM9i/vtK9TgeSCacZwnNXh8B2VGqjKtvthf2y47N
	SYptS1YOrzO5PBLte4=
X-Received: by 2002:a05:701b:271c:b0:134:ff2e:a71c with SMTP id a92af1059eb24-13806684f0amr886935c88.9.1780670010297;
        Fri, 05 Jun 2026 07:33:30 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-194-119.dynamic-ip.hinet.net. [36.226.194.119])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54db05csm6106066c88.8.2026.06.05.07.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 07:33:29 -0700 (PDT)
Date: Fri, 5 Jun 2026 22:33:24 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, rcu@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH 2/2] sched_ext, rcu: Upgrade RCU stall paths to report
 cpumask of stalled CPUs
Message-ID: <20260605223156.G3249@cchengyang.duckdns.org>
References: <20260531152646.1206799-1-yphbchou0911@gmail.com>
 <20260531152646.1206799-3-yphbchou0911@gmail.com>
 <14ffaa7d-1033-4cf7-af32-f1120f1f523a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ffaa7d-1033-4cf7-af32-f1120f1f523a@paulmck-laptop>

Hi Paul,

On Thu, Jun 04, 2026 at 10:57:38AM -0700, Paul E. McKenney wrote:
> On Sun, May 31, 2026 at 11:25:27PM +0800, Cheng-Yang Chou wrote:
> > scx_rcu_cpu_stall() previously recorded the detector CPU rather than the
> > stalled one, and the expedited grace period path had no stalled CPU to
> > report at all.
> > 
> > Thread a cpumask through panic_on_rcu_stall() and scx_rcu_cpu_stall()
> > to capture all stalled CPUs. Report cpumask_first() as exit_cpu and the
> > full CPU list in the exit message. Task-only stalls yield exit_cpu = -1.
> > 
> > Store the stall mask in scx_sched rather than scx_exit_info, keeping the
> > BPF-visible struct unchanged. scx_dump_state() reads sch->stall_cpus
> > directly and dumps all stalled CPUs first to avoid losing them to
> > truncation.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> From an RCU perspective:
> 
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

Thanks for your guidance and review! ^0^

-- 
Cheers,
Cheng-Yang
