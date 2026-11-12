Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495683;
	b=nwelUEXF1hpl5vBTlXpQNuoXbveQalLAgdHJ0dE84tnukaKoQxrg+kaXT+O3V57C/5Dr
	 OzWW0piK8OU02elTocFSPz29VKu+FHlKaWRsKDOxqSBALFrHlwSEnfn0gBlfhqbIw1AFP
	 4F+vJpvWMkdlaiEDGa/OiXaedkfFoSWpQVrz7QNjjwCfCFnJ9RTgoZk2+28GUfBOuoyuM
	 zl7QuorqgTvA+oqBjxBBcN6+5+TvED67Upy/Q1RSo0MMS8VAs6+PEf1kdhcJdB71BtuzE
	 LvoWijk5sdlih9dQS2XBjOiWNnFhgUOL1wq4p3gfYeQvwCWWDvPGgJKR2t+OL23yepg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495683;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M/6u10agl+rdRWY13WawdsYLlQi9SJfLtYTamWTVA+8=;
	b=GkU5LSvHGxUJ/HP0YhUmGuL/Y1rp0Dbz24qD7FmaQC8tp819mH3tKK/+2xG/aazsbbuh
	 C0RGE9cMxwXZDwHDPo+XTSWKTlJ/9Gu/S9OPaxHSVZoHYNv9Hf0WddlCJ5Xd8Icv4CLEE
	 9YmbAwmdjDJb0mLH/YLOW6/Bl2MHxeZcsxPxIehbZdqD2cYHTCd2gBG8ZueQ/PWrt3yC/
	 uYYs43851Ya/iLxo3nR5M83vArqr8bHj+uznV9jIL/U6g+An6f6m1sw4vHt6jz0usvLiR
	 lbhHVe3DaDdfTAV7MPaM+LlmL//GAU6nVSSSbkO8jD2zVGGNCgm3NQk5X+sqtuaRotw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d3snHsyT;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RTr+R4Yb;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDFF606A321
	for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 15:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FDFF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=d3snHsyT;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RTr+R4Yb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794495682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M/6u10agl+rdRWY13WawdsYLlQi9SJfLtYTamWTVA+8=;
	b=d3snHsyTPUCshWv4tDEDtyknHWwD6Ifyn0U3ytTGwIKTosz9PSHM5iIiAsXcZA1X+eZQ7f
	kUno/DAPlCDiPsbFSercLuUai24lBjAWzdXoKCfnKX4OPqOHf9CL6ugjng7/050g7dILDg
	qsQOgoB77ukhMGVUuCT4rUqgN+l/p+c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-u7R-yxqBPmO-8o4t9Rk4hQ-1; Thu, 12 Nov 2026 10:01:12 -0500
X-MC-Unique: u7R-yxqBPmO-8o4t9Rk4hQ-1
X-Mimecast-MFC-AGG-ID: u7R-yxqBPmO-8o4t9Rk4hQ_1794495671
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so35770455e9.1
        for <rcu@vger.kernel.org>; Thu, 12 Nov 2026 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794495671; x=1795100471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M/6u10agl+rdRWY13WawdsYLlQi9SJfLtYTamWTVA+8=;
        b=RTr+R4YbUtPb0bJdv9nKHbt5s927vcuRHj8Qc+OgK1pDd+OkXz/XRTdRh+Lp+nae6T
         l8lJ53T4GUVn9XOVe0bCKpyjw3CnwmmmXHp08IWNvpnkN1WmIOQnOrXGswdpYoBnfqCQ
         y9gE7rnEsVVfnKIv64XUWDMmG6izvPpfn4bFNPpiC+7qjOELvlLNSzLS3gpb9Lq/um6S
         O9f8JkDe7Wxx0Wh+ahSYpy3z8bupNQZI4JCTSBKci4+I5ulr0MP7RAQiXvnYM2O3UolY
         85zasF1WCLyu6xoC8IR+3v+DI32L7sVan4s8dZ2r1WSI33icXbBNVYFWTfbbmw6GYvmh
         pkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794495671; x=1795100471;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/6u10agl+rdRWY13WawdsYLlQi9SJfLtYTamWTVA+8=;
        b=vwABGMYYVdD/cCTGpvSSgdq0axRAGzNTY3fUqEZ7pPYUV+PNeNiebD3aOTZA6Ziihe
         8cSFu0W5XgTE9jodU2gI6xmogYb2eAG7D107JyZOzsJB0JwNqRxno9sUqMyK0oGwNeWy
         29DPxfiy7R44a/1i/lPh0WsQAQ7BJJf3NSYexyE4PSqLp8ZqQoKMo9Ab0uNrsyKPlMHX
         K0Ol9hIbeUWGegB7tHu4zYbUJKLPaMRHdeqzCDAvePULWLlZXt1iFVA+A3cZkXjaqb/F
         ZtuLaJvS27NLREmNQ0DW39K6yUkQZt+0+fNs1iltLUXbkanv+oJCIDfoG1w1CNLp6nOM
         0Q9w==
X-Forwarded-Encrypted: i=1; AL+hErH6tchhTCYTf9tIE8+WxpICtfL/QGCugE7aKfZzNK9gxmtu4frck6mco7cFNRNo+3HYgcU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qChNOXKTy/4WouSZM7j8KC1N1EkVXxfyI0l43R9f2DJ5da/54
	96DFeuYJAJW3UqIMQFiH2E/OZtk8iR4O+7HCsPHNr3Q2At6brYUvtEVmNTmPEJntd/Wl65S20aT
	TEwjAeS1J+7C5qCfIG+OJDBJl/0MAwQtCD/rd5D21wLCxTWx7lsh9vA==
X-Gm-Gg: AYBFou23wdik6vPJ6Bq4EnLqAYw9PkN5iRG5TYLDWQZEDPcbQ+eJ0E6eWZHtjWFaiQN
	w/bJdwU/w7L2ceU+SqmT6ebssMeOPKZIA02JbxNqgSTct6j8msjtPWwlDYb8zLmrBrL2/boJ2Te
	C6phvmwGIoVzkIHfWj+7Usvbam1FbPmSqAr8WWo6Ay0YXhgENMGZ9xH1D/WNrdL2OdyJiqp9Ljs
	DDx/iF5o1zMVPvTVR5UFGMXxxKxwhVgeDvAjVgcR3zPRCh2TXL34lU+LNTRN8eWu3liGXKfCP0A
	K8whYHFLYd3l692dRaSyvo/wempTy4M/dkHTc8AUdzpjO7F41i3PM9bv7e5XCIMrm5BUH9O+c1g
	SFZfsmj+N0URugHyyKuZK8ynmh2O94pJAXmj/XIVAiqz/ho04ZQz0OToB47tUiJyKerRRTSY/Yu
	xgghU=
X-Received: by 2002:a05:600c:6819:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4ba0935f880mr100717665e9.13.1794495670952;
        Thu, 12 Nov 2026 07:01:10 -0800 (PST)
X-Received: by 2002:a05:600c:6819:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4ba0935f880mr100717275e9.13.1794495670509;
        Thu, 12 Nov 2026 07:01:10 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba08ddd467sm110908625e9.0.2026.11.12.07.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:01:09 -0800 (PST)
Date: Thu, 12 Nov 2026 16:01:06 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	luca abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yurand2000@gmail.com>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Davidlohr Bueso <dave@stgolabs.net>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: Re: [PATCH v2 0/7] sched: RT throttling cleanup and a bit of
 documentation
Message-ID: <avXUstjABxdTZaxM@jlelli-thinkpadt14gen4.remote.csb>
References: <20261110-sched_dl-v2-0-cc9399f7aeb1@linutronix.de>
 <c2bf89ce-b9de-43cf-839b-395d28b2275c@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bf89ce-b9de-43cf-839b-395d28b2275c@paulmck-laptop>

Hello,

On 10/11/26 11:56, Paul E. McKenney wrote:
> On Tue, Nov 10, 2026 at 06:34:42PM +0100, Sebastian Andrzej Siewior wrote:
> > People used to disable the RT throttling mechanism by writing -1 to
> > /proc/sys/kernel/sched_rt_runtime_us. Since v6.12 they can still do this
> > but they don't disable RT throttling anymore. Instead this throttling
> > mechanism has been taken over by the fair_server which can be configured
> > via debugfs.
> > This is not really documented by a hint appeared a few cycles later in
> > Documentation/scheduler/sched-rt-group.rst. This can be found once you
> > know what you are looking for because this document describes the RT
> > group scheduling (CONFIG_RT_GROUP_SCHED). The fair_server is used even
> > without it.
> > The then there is global DL resource control which also shares this
> > file proc file (which is stuck if CONFIG_RT_GROUP_SCHED is enabled).
> 
> Nice, thank you!
> 
> Unfortunately but unsurprisingly, this gets the same divide-by-zero
> issue reported (belatedly) on the earlier series:
> 
> https://lore.kernel.org/all/e58e48c3-ac62-40cd-b5d3-2de87db12496@paulmck-laptop/
> 

I wonder if this fixes is

https://lore.kernel.org/lkml/20261108185406.1549770-6-mathieu.desnoyers@efficios.com/

Thanks,
Juri

