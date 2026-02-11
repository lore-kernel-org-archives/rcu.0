Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F621CC59
	for <rcu@vger.kernel.org>; Wed, 11 Feb 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814951; cv=none; b=nhLtj9PXk3x9kMTMK3jlTNQYVBHE8nNBjQgZUYKcIn91etGlHU6wLmQrXBWZigOUBikbtxHWyrO3ATXIIv4jifFXYrN8w0v5BNOwdxLypnK1RDoMuxHKM2GV/MotAV4wRwokAiKgIvrdMXvudQ+aYXFtif0XLPa+GBPLCHH/4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814951; c=relaxed/simple;
	bh=H012cvQr+VpKO70ngb2geNjmZ8+ATogouv6fwUah+ag=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDI8WnKNt6m5PRyS1gzzuqkxsqHiKoHJOzDs+Z61sBkMlRKl9gbIKBvEYw+JmfkBwwWkWhQxOJ+LHilpzovPwAy0BCCw/TT9a7xGhxHowUG+Vu+i+UUbL37oCp4FZzbhFVVxK6VFfvUhqfa9WwP6rn2m0GfZ0+ZRBO247Q0ASd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azDoyft4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azDoyft4"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e0d5c446cso2232550e87.0
        for <rcu@vger.kernel.org>; Wed, 11 Feb 2026 05:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770814948; x=1771419748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=deALlWWmUYhI7Qq/UdLZZQ3FMP5Fpo1V2LM+cbD7E+4=;
        b=azDoyft40sKdFn977XN48qhdAADr2n5H+XfKrgnvoT3haRaoUwC4KEWCqMYAkn2oHq
         9tru40UjunQQm/3embdu837wFwVhYXSOvYM1f1SgZavWIvQsKf8Ugsr6V7EvG4/xKH/u
         RPRpLMTnVdQjyHHPDTvHMMTLTEPej2DChyJVxY+l9yuW8zoYCU1gXy9JayoN4R/t2dHi
         REbsp292khu19BSyZkEC4YD7pNZS1bp5QZYW2K/NbHzfLf9aNTn7bJS7QoqKrZuZf8pG
         oJ9dhiWp60IM3aTmQ1o32xIIaJwLZiLeZZ3ooA7RHloi1CJeyB3jZBSW/+mlcGfPUQXZ
         TE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814948; x=1771419748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deALlWWmUYhI7Qq/UdLZZQ3FMP5Fpo1V2LM+cbD7E+4=;
        b=VO6/g6sDwmaT07f2Le1MjVKYyal87Aub77S/Aw0s9kZpUuGGU3sFrynab4PprQ5E2l
         4dVpsXTK0XB7XUAl0GOc6W02NAq6ramSojzjJEhW44Co7O8dnH6jhv0DBReP7F+tQICU
         N/bTKqyiwb+H46M1vkL+fLLj/rmJlZiZg0/6t1M3yLqXnW2quyJFnHU/RxJsYj/zV18A
         difENOTtgeaMRMSWtqFgXKwjqo0dW2EpOmsu/2PRgFE0mCt66z8aoFWixAHTkaahhe5d
         GBFlQ/8p0/35jwsEYcIL2oRE0tzsZNf+PESD5WTHcTJixSpCqmiYePoUcHETNveRIYrh
         fywA==
X-Forwarded-Encrypted: i=1; AJvYcCX1ay3mmtpbOXBSUfK7u2oGwMKHiJ9wi8sbPi2NVl4slT++5aVQfr4OTzOdu3rszMCwLQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMOYiD7tVLaOzZO9uw8xyTEi1wAS489dFvyyeFQk1Qg6d8cJX
	A2HDm++kJtEyLcv1iostJ7pW5Lza6TpXsRdLaH91UeHvM58zeVI6BAw/
X-Gm-Gg: AZuq6aLOtjeh2q8o91Hme1oIoJYxqvPGHfU5gWw0YSHmJ5Dav6LOdLQ4U8/AttQWNBJ
	C0JLunW/Hzk3+6CqK5Mv3L0i7r3JCoINIZEJI2LFre4wvKSNxMu8IBbb/qUXuj453JmngGAEMBj
	9haIoBAU35xFo+hrtG3TIa8eD7kctIZro63U4AwcP3Rr888Ux43kLpSzH7vL12PBiuRJ70YavFr
	D+/XWeuls53lVl7PVZNeDnEzX+pgaG2hBkXzJ08EowwkfMHObqrX+a3SVoJLy1g9Y4/5SpXv1d3
	R5KO7y2EVCkGNNlisrF6qiGNheDVTFFgtJSvK1MycrZqu22cTTYMRP1hs1vAkZeTYtfR2lOVu96
	flXSVWKAXlCb/+HhLuwSGMce57W6gLBnERp9OOMNTwYmAfR3LQOlwDhTAy632gxhl
X-Received: by 2002:a05:6512:8014:20b0:59e:45ae:7035 with SMTP id 2adb3069b0e04-59e45ae70c4mr4201894e87.3.1770814947718;
        Wed, 11 Feb 2026 05:02:27 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e5f89a356sm313641e87.92.2026.02.11.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 05:02:27 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Wed, 11 Feb 2026 14:02:24 +0100
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Amery Hung <ameryhung@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org,
	linux-mm@kvack.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] mm/slab: introduce k[v]free_rcu() with struct
 rcu_ptr
Message-ID: <aYx94NTsLfQyvflY@milan>
References: <20260206093410.160622-1-harry.yoo@oracle.com>
 <20260206093410.160622-2-harry.yoo@oracle.com>
 <aYxXE6CC0XQr1KNK@milan>
 <aYxdleYc7_TWj9To@hyeyoo>
 <aYxfumz5IlwBDS4n@milan>
 <aYxnfk6kCZ66CaOJ@hyeyoo>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYxnfk6kCZ66CaOJ@hyeyoo>

On Wed, Feb 11, 2026 at 08:26:54PM +0900, Harry Yoo wrote:
> On Wed, Feb 11, 2026 at 11:53:46AM +0100, Uladzislau Rezki wrote:
> > On Wed, Feb 11, 2026 at 07:44:37PM +0900, Harry Yoo wrote:
> > > On Wed, Feb 11, 2026 at 11:16:51AM +0100, Uladzislau Rezki wrote:
> > > > If this is supposed to be invoked from NMI, should we better just detect
> > > > such context in the kvfree_call_rcu()? There are lot of "allow_spin" checks
> > > > which make it easy to get lost.
> > > 
> > > Detecting if it's NMI might be okay, but IIUC re-entrancy requirement
> > > not only comes from NMI but also from attaching bpf programs to
> > > kernel functions, something like:
> > > 
> > > "Run a BPF program whenever queue_delayed_work() is called,
> > >  ... and the BPF program somehow frees memory via kfree_rcu_nolock()".
> > > 
> > > Then, by the time the kernel calls queue_delayed_work() while holding
> > > krcp->lock, it run the BPF program and calls kfree_rcu_nolock(),
> > > it is not allowed to spin on krcp->lock.
> > > 
> > > 
> > > > As i see you maintain llist and the idea is simply to re-enter to the
> > > > kvfree_rcu() again with allow-spin=true, since then it will be "normal"
> > > > context.
> > > 
> > > It tries to acquire the lock and add it to krcp->head, but if somebody
> > > is already holding the lock, it re-runs kvfree_rcu() with irq work.
> > > 
> >
> > Check no_spin on entry, if true, llist_add, queue-irq-work. Re-enter.
> 
> That is much simpler! Actually, I tried this way during the initial
> implementation. I like its simplicity.
> 
> But I wasn't sure about performance implications of the approach
> and switched to current implementation.
> 
> It'd be nice to hear Alexei's thoughts on this; I think he'd have some
> insights on performance aspect of this, as we have something similar
> in slab (defer_free).
> 
> > You might need to set-up interval to prevent frequent bouncing.
> 
> You mean an interval to wait after queueing the work, before it gets
> processed, right?
> 
Something like that. Not ping a scheduler as soon as we added an object
to be freed after GP.

--
Uladzislau Rezki
