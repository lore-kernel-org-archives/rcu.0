Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514282;
	b=yAO5obrYi3bDM6oetZfFcF0GMkmvGqYJ4G7O31IdC0xctnodNcENnW5JZgEhhhkGNOtp
	 hW/410urN7wBKqokhARGrypWrYQ50Zs1BfDnxV8TEl+DCEvU/tScEFDAZTh8A3PDCsjGR
	 neZsnRThc2o8/jkDNjZAgkVDadK+mGc7Ajo3iMx0McX//UlJmIKhxvyOhrcij3ycFlqo8
	 HpC2sTRoP3cO2YyxgIJeJ96kT5aMimzZJW4Y0mBqOgQIMa3puNPEHIMN+riZn62xzCISD
	 W+5/J+gNBJGcKa4o1IoAiv5SN/jCETs67tzIsD0HVPpr4Kk5z173bH0ifcB0+U2zHbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514282;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O7+zzAT/4xNi4DFU6pAU7iVms8gCVVFUE+GIPCzfB70=;
	b=3gkTSCBqD8tOkzgQuh0+sUTpB3+MyXYJaGEvX0t6Zu1BUMZXC82qkf81DGZV7cDziPTO
	 izjqyh+ste17TpvfpvpMgioAMz1lDyGVQN6e0O5TQeKEsyr1w9fdoYqizR2ngxKTKqfxC
	 UVnNQBJiZEuCDvDXWU4v+81TxLM36qAt79bMNh/Xo1fB8ZDrMl67UWgVEvvtt+YMhrseG
	 QvWU2Z2FinMaYDSsTJEbXlh0TNiF0aSvalGQqgAfsjaH3tevZXV4GyOKNYiVFeCkOdBjo
	 SlKFBZUVaUgyAqHWxc9/cHkDUsLLAHZGJYAl40vP19qBsISN1HysHfoJTVGZMB7/8nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxPWA0Q9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pnfssEWE;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6669E606A32A
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 09:58:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6669E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MxPWA0Q9;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pnfssEWE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795514281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7+zzAT/4xNi4DFU6pAU7iVms8gCVVFUE+GIPCzfB70=;
	b=MxPWA0Q9SwYqIAPgyCGt4m+ljZ/BXaFkaHz8o8jxhh+kIlIqPi5A0P8fbx9AIy8O8i+ru0
	d34N45aOy5bVYjKR1hNCQy5/YPRWYuANATyhfBWndyzQ2A71ClqHswYMiUOxZxs3rxEEsg
	XvNGv918LSaR8kM1t3MSZINlNPuBspc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-cE_V-DWYNCCESLI1SfZctw-1; Tue, 24 Nov 2026 09:57:59 +0000
X-MC-Unique: cE_V-DWYNCCESLI1SfZctw-1
X-Mimecast-MFC-AGG-ID: cE_V-DWYNCCESLI1SfZctw_1795514278
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so2927413f8f.1
        for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 01:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795514278; x=1796119078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O7+zzAT/4xNi4DFU6pAU7iVms8gCVVFUE+GIPCzfB70=;
        b=pnfssEWEpZCgwzgeD54MxECzqUXeEltWQ5WLO9R/ICS3R3mTXVEtiximiqpXXjjdEq
         DRGo4AdE/KKU6TWcL5d1GzuWIILUOZkPUVvD9WwtSFWU9QwSAtpTDubLU8xNs9oAf4Gh
         4GEm3+U/sl4DFhkT9Ylh8mkMkWORyxl8043aPCyNjp3pE+12zS2OVIDorWx6awltCJmL
         Y+E8ELAna8eF1otXS0WeYkWbi4UNjhVvrxo5Z6CANDqhNmXOoKhHmjb9Y/5mzLMfDSto
         Ey6f5iCp565xW7Ew+adKSGo9p0vdfJz3ZfPZL0ZF1RQCDD7kYTon66YLHAqkO8LxCBZ7
         Mfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514278; x=1796119078;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7+zzAT/4xNi4DFU6pAU7iVms8gCVVFUE+GIPCzfB70=;
        b=1y4vsZ35YzrBYs5CdJHPvfzDiiY/fFxw0DYpjpQZIprD5CxwDOSCA2drha5lX0PBPR
         180G3aRyeu75DULyd2z3DOoVFZP7H07ImWsICMcXyJXVaEj5ZRGnuNGzH7QWtR8JI8iu
         KOBwuVbIWELmdCHKUAzS2se1oVJ9pga93JC26S1cIKw1YG4dguQsCMNb2rnfm2Ra2x0t
         UMtCcpxHsiayVQaXX2nqp/XRIwVKR5O4OCLP0++XdBEUcnH3UNHs9j8mnB7esZf7R+wt
         VzkRo1OU7MN7NoZqEV9MsA9xIukvA0fsw56B2hK1m/gxNMCkGv8TOF8OJvPmBrSa17xR
         Ac2g==
X-Forwarded-Encrypted: i=1; AL+hErHkubjg7wPiPOEUoUM1n+kKBNdcgfjzVDDLifIWLZnNu/Je3ODepO67O+Ja7bjVnknzaSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rzLslBxu/50N+3iIxQS8KJJ2sWdbMaunhVUM/kkGecsKXJ3zI
	YfSyiNiXnYPIewvlIoQVTF68JSkH3MUsPxvWnNVa01zpilbdJ0T0nwd3Cqd6BCBRJx/hYGm/FTn
	pbNQ27UevtrbULXevcJN3b95JLRjV2+ljjzyEntKaFzZj/1ie2Kd2sQ==
X-Gm-Gg: AZFdTZc67p/2YjoJyiU38238PQ3k4PR/aaH6RnBWPfLqBdSwSM7OGWmhXI1eUAPeMTm
	EjdYodTwLfh3P2sEsNT8ZA0I3Q5nchlUFuNOSBMYRhF97ZhFbJ6Aybr34/f96ALsXFd3Q7QVZFs
	+xDQutcQceNlBO+HGym2sysqsev0I36UrFsBUNC5eLaBytg4oYmRJ0R//ytK8Q+cVlAm9qYtC72
	lzvPRC/UDugbigFLk6Ri+yx4IVSDPNuKHqeGsq3rOVUNqZBrQMoLu1jgpLzXSpiqOuH/5NoYmd8
	QK3rNNAmYAAeeZDTTfEdwlq9hBHVl1Fu54kwXaKe/MqFk/OW7ZCn7VCLY2XCJ5HD7jb8/55V7K5
	je8tc5xNq/sdoZygoRexXAk6MfRFTYEpZUnkwhFHpUoNVzevsLPHDImza8x27W0YuWDYFncfZPR
	q4is0=
X-Received: by 2002:a05:6000:2887:b0:4b3:e5d7:215a with SMTP id ffacd0b85a97d-4b3e5d72317mr9981384f8f.24.1795514278110;
        Tue, 24 Nov 2026 01:57:58 -0800 (PST)
X-Received: by 2002:a05:6000:2887:b0:4b3:e5d7:215a with SMTP id ffacd0b85a97d-4b3e5d72317mr9981344f8f.24.1795514277737;
        Tue, 24 Nov 2026 01:57:57 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dcf9sm26865584f8f.32.2026.11.24.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:57:57 -0800 (PST)
Date: Tue, 24 Nov 2026 10:57:54 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
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
	"Paul E. McKenney" <paulmck@kernel.org>,
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
	Qais Yousef <qyousef@layalina.io>,
	John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH v4 2/6] sched: Move DL's admission control to sysfs
Message-ID: <awVfotZsGc8S_aB0@jlelli-thinkpadt14gen4.remote.csb>
References: <20261123-sched_dl-v4-0-d523e4d960d3@linutronix.de>
 <20261123-sched_dl-v4-2-d523e4d960d3@linutronix.de>
 <awU9KmFsbiyvbcOr@jlelli-thinkpadt14gen4.remote.csb>
 <20261124075332.nZysJRfS@linutronix.de>
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
In-Reply-To: <20261124075332.nZysJRfS@linutronix.de>

On 24/11/26 08:53, Sebastian Andrzej Siewior wrote:
> On 2026-11-24 08:30:50 [+0100], Juri Lelli wrote:
> > Hello,
> 
> Hi,
> 
> > On 23/11/26 14:41, Sebastian Andrzej Siewior wrote:
> > 
> > ...
> > 
> > > @@ -2882,26 +2881,18 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
> > >  		if (ret)
> > >  			goto undo;
> > >  
> > > -		ret = sched_dl_global_validate();
> > > +		ret = sched_dl_try_boundary(sysctl_sched_rt_runtime,
> > > +					    sysctl_sched_rt_period);
> > >  		if (ret)
> > >  			goto undo;
> > > -
> > > -		sched_dl_do_global();
> > 
> > Nothing updates sysctl_sched_rt_{period,runtime} when the sysfs files
> > are written, but this always passes both, so a procfs write of one knob
> > resets the other to its stale sysctl value? E.g. write 2000000 to
> > dl_period_us, then -1 to sched_rt_runtime_us: admission control is
> > disabled as expected, but sysctl_sched_rt_period is still 1000000 and
> > the period is back to 1s.
> 
> You want this working both ways?

Want is definitely too strong of a word. :)

> I assumed you use the proc interface because you don't know better. The
> warning makes you aware that the throttling knobs and DL knobs moved to
> sysfs. The DL bits are mirror to the sysfs interface in case you ignore
> the warning and keep using proc.
> If you move to using sysfs then everything is fine. From here, going
> back to proc looks odd.

Odd indeed, but I wondered if it might happen that a sysadmin configures
things properly using the new interface and some time later, say, an old
application that hasn't switched yet to the new interface resets/tweaks
using the old interface?

