Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D61E2847
	for <rcu@vger.kernel.org>; Wed,  5 Mar 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741167054; cv=none; b=mjk5SEt4sOizXSBdXNq4hqxbjPA6TGn4FTDjY4XR4iZmrQLb6y2gg0MLHmVX4WHM05obL15rLB4VM2OXWkqwTSIO/5Ei3NYctDG/2Q/eQ5rw3MPPZDNJHnoksu6QPY+WOFhaLupc/oZfg4pw/PCNby4WoY85ai1wGOsAehdXvnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741167054; c=relaxed/simple;
	bh=xgx4HSZDU7n/xVf5G1afLCQtvXJis/y/WjW4xj7HkDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBIGeKXwa7hhYsjnYZunhivbn77Xb2gRdHqi/YRsbyuGGI7Bi69htzIyoPXOrXGViWtN8nFtGBsHKq54tLtwC00COwAeWNIrgL4R2K9pOP3BFGEFXbI6dZzZ70kvSBqCPeLBfX3W6uyQ68ae+p84VNIXNuRySUhEs8oJp5hfOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtVF92gc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtVF92gc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741167052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8EJTkbR9th9cE9/5Rwb1aADNZHqX2tCQgBbpYJugojw=;
	b=VtVF92gcZLD3E6DJQgo/ZOL9OQqZsZGjJCtxSldvoTc5vtY2rpibcKDeWRjTclhShAFV3W
	ePihATykfKiFOJYuNtewuNyADVH0ePWJ7d0nF+EXxW3uMT/b5V9T61rcmY/oMPQVX4A9Td
	YOv39t0nmDNiXQ6+TanItzGfkiW2afM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-aMJhw9CkM7mzMuTRGN_Dag-1; Wed, 05 Mar 2025 04:30:41 -0500
X-MC-Unique: aMJhw9CkM7mzMuTRGN_Dag-1
X-Mimecast-MFC-AGG-ID: aMJhw9CkM7mzMuTRGN_Dag_1741167040
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8c4f5f3b4so81934406d6.1
        for <rcu@vger.kernel.org>; Wed, 05 Mar 2025 01:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741167040; x=1741771840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EJTkbR9th9cE9/5Rwb1aADNZHqX2tCQgBbpYJugojw=;
        b=kdmKVFjBp61NcBkNsrxvP9drwZQB8M11VbRQxDevfZkcivgWt6h/7lqeZe6dugZ7i6
         Vd5LZuYA6ggVQJQ5mjp3jF/fPEZaelMdfd+Qsd9l8ovZoXD7r8llVk+hdURKpG8u8gXC
         Tqt112zidwBEiCkavwzupQhfWOzT/lUuKM1nFaPrO8xD/ZN1ZDc4CyENahmhp9EoBpi5
         KqSol2a0i9QOnqLtaZxea6RvlfvBRAQNaHKv3Xc+eFRvzzfvNtpHZsCSuVAiUPrsM476
         aU2X08qBWcCgAKP3wW70wQeeS9sAPXfZee6cqxJ1qWRK+wDLINOrG0h5Jfbc0dSS36UM
         Ql4A==
X-Forwarded-Encrypted: i=1; AJvYcCWmKfYnog/lvJydo6JM0IaSe6hVUCruPdze8CFlPIa3Eudcp5ZC2WF8fSiD2JYcgtcnJBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyw8yiMEUqJ0QSPgp3EJXyVJNqeEs0Vk00CitCWyI+w1rmcbXP
	R1V5ZJ5yvF7UaLYAwU5Ig7NHou7zkmy+xLuoIWrjsJ/9g/54M/VDAvXoEWSxOJzH3dvIDOani6f
	Rb8+w7UwPzS56IsWpaBBRa4abOImyChoRUD9EnDSSO3ZaBslASw==
X-Gm-Gg: ASbGncuPumSCz1He2EvCsI2UPy6FkexON9qcbyI+F6aJU43a/XPy4vpTrUF9IobUd0F
	vTkdLgHqLnjpzuX+29sFOvqZBfARRjUx2hI6z3p3Y4iT3y86qzc5JUWRrBl9KVsY30S6Z4mbV8+
	6G3f+ZSW2x07E6FziHsLLZLsPsTNSzp3NJy0NadEo0emQOlzGibaK5oRzPKXzZVvPx4f+y27osV
	n6ZARHmY81vOMh+6A2FvuYDz/4lC5NLleTBoEOFRVt3FsG8Qs1oJsQOMw8P64Ck73LY2lgbgPSx
	Q0214u2RhMO4y3nkLiujJI93j0w9rSLWh04KAV8AzOX3ooTNKsTi5q2zke6wbS3r09A8NUmVW0m
	NwRA8
X-Received: by 2002:a0c:bf50:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e8ed7f1cc5mr6413566d6.32.1741167040315;
        Wed, 05 Mar 2025 01:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2KuetL5whCKoVGhof0MgQhHtXZOk/kgPtLg/+HfbSSzrYEBXTfgD8UUbLB7L4/6q+S+EFVg==
X-Received: by 2002:a0c:bf50:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e8ed7f1cc5mr6413326d6.32.1741167040054;
        Wed, 05 Mar 2025 01:30:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976eb173sm77524666d6.118.2025.03.05.01.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 01:30:38 -0800 (PST)
Date: Wed, 5 Mar 2025 09:30:33 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, paulmck@kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH RFC] sched: Disable DL server if sysctl_sched_rt_runtime
 is -1
Message-ID: <Z8gZuaAavG42unZb@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304200116.2210119-1-joelagnelf@nvidia.com>
 <20250304150632.3fde716c@gandalf.local.home>
 <20250304234744.GA2283516@joelnvbox>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304234744.GA2283516@joelnvbox>

Hi Joel,

On 04/03/25 18:47, Joel Fernandes wrote:
> On Tue, Mar 04, 2025 at 03:06:32PM -0500, Steven Rostedt wrote:
> > On Tue,  4 Mar 2025 15:01:16 -0500
> > Joel Fernandes <joelagnelf@nvidia.com> wrote:
> > 
> > > Currently, RCU boost testing in rcutorture is broken because it relies on
> > > having RT throttling disabled. This means the test will always pass (or
> > > rarely fail). This occurs because recently, RT throttling was replaced
> > > by DL server which boosts CFS tasks even when rcutorture tried to
> > > disable throttling (see rcu_torture_disable_rt_throttle()).
> > > 
> > > Therefore this patch prevents DL server from starting when RC torture
> > > sets the sysctl_sched_rt_runtime to -1.
> > > 
> > > With this patch, boosting in TREE09 fails more than 50% of boost attempts
> > > making the test more useful.
> > > 
> > > Also add a check of this to task_non_contending() because otherwise it
> > > throws a warning (in the case when DL server was already started before
> > > rcutorture started).
> > > 
> > 
> > Hmm, I wonder if dl_server caused a regression. That is, disabling rt
> > throttling should allow RT tasks to starve anything it wants. And some RT
> > applications rely on this.
> > 
> > Should this include a Fixes and Cc stable?
> 
> Yeah that makes sense to me, I'll include the Fixes tag in the v2.

Not entirely sure we want to link the (legacy?) sched_rt_runtime
interface to DL server, as it has its own new interface at

/sys/kernel/debug/sched/fair_server/cpuX/*

Admittedly thought the latter is a debug interface, which is not ideal.

I was thinking we might want/need to add a kernel cmdline parameter to
tweak DL server parameters at boot (and possibly disable it), but it is
indeed less flexible than an interface tweakable at runtime.

If we end up using sched_rt_runtime (and _period) to tweak DL server I
believe we should make sure changes are consistent with the debug
interface at least.

Peter, what do you think?

Thanks,
Juri

