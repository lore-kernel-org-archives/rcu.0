Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533616;
	b=0AA05NgeWq9Znw3xjaTwjXr2MfaYPWueh0xO+e7OyWJr5r8p3OzkGSIahGre3V7Uditz
	 bPCUHbT0QHwcN72w4j0kMTlqRogVw2McQ+lUWbdWLi/bd/YRFSbjY+TXV1rzhoTtbZ2oB
	 pUYvaj+X5+brZkXQ2pXkHayGslxamxpfWQJpmFLBZmpI+eADsACCDA1LU4gfJLKnYxiIi
	 Mio2nihAWFtDm8x5goNnZTQcrkR6dv99N3jZMzCOqHypeiq15qAqgDgyRTuc8eDVMXI+c
	 9/X5n0uj9NnqargpdLQzdMAzI0MEsztWqIaK4guw+0hUOte7wFJcAXPwXUwbYlZ3pkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533616;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Scanned-By;
	bh=iOPu+6NiMDC/b3ju45EqsPsXdKCHiL1eY1o26WitY9s=;
	b=w3ENhCUzYBtLvktXbtXt6+y1x7pDmyvA/jZyuKyQ44S3Sse4diBC2vfvQ+3Vu0HaXQtP
	 60njUnY02pboM0L4BOcDxG+yAqxFSrR8zn2RYhdMnzBW1j1wycaV105cC213pzvY0ykeZ
	 SabH1ASTC76QC00tv/w0omsjiR4WMQCZPyrC1+fzXVsxUm6kj6eOFzZiSqO8wssTDxx+W
	 s2mD62P+or8eaDecbHx90totwKh75cARSRlj38U6B4jwMXyN6ro4PNhbkEGAmQlhD04mj
	 ff8+CVdYP2n9XUwZbeZx9epCWwlRqUNYM8q2b/W0+oGDn7wmkZz+BP09caqE19NP/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hBIuBsWQ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2F0606A323
	for <rcu@vger.kernel.org>; Tue, 24 Nov 2026 15:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D2F0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hBIuBsWQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795533615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iOPu+6NiMDC/b3ju45EqsPsXdKCHiL1eY1o26WitY9s=;
	b=hBIuBsWQ9nosSJ+ly4Dx0qt4cMlvvPnEksIVk/SnsbpqXWLvx79xXpubPKfHLBS1iJ6E4i
	eHj306OtGz2gdeVqKZDr1qVXw2keA6X2DUH+xlbSNF8DUQJnDCVbOdll9xFEJ1KfNlYJ6o
	xF/w8YLop9o/wiG/qU2y4fx3+llzpoQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-399-htAi2dU3ObOwTYEJTuqWmQ-1; Tue,
 24 Nov 2026 15:20:09 +0000
X-MC-Unique: htAi2dU3ObOwTYEJTuqWmQ-1
X-Mimecast-MFC-AGG-ID: htAi2dU3ObOwTYEJTuqWmQ_1795533605
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF5B119774EE;
	Tue, 24 Nov 2026 15:20:04 +0000 (UTC)
Received: from pauld.westford.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 538E71800551;
	Tue, 24 Nov 2026 15:19:58 +0000 (UTC)
Date: Tue, 24 Nov 2026 10:19:55 -0500
From: Phil Auld <pauld@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
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
Subject: Re: [PATCH v4 3/6] sched: Add sysfs files for the per-CPU
 fair_server knobs
Message-ID: <20261124151955.GA1855213@pauld.westford.csb>
References: <20261123-sched_dl-v4-0-d523e4d960d3@linutronix.de>
 <20261123-sched_dl-v4-3-d523e4d960d3@linutronix.de>
 <awVDG-ABOvj7zGRg@jlelli-thinkpadt14gen4.remote.csb>
 <20261124080833.0I9HFgtf@linutronix.de>
 <awVgALGuilf2FMsT@jlelli-thinkpadt14gen4.remote.csb>
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
In-Reply-To: <awVgALGuilf2FMsT@jlelli-thinkpadt14gen4.remote.csb>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Nov 24, 2026 at 10:59:28AM +0100 Juri Lelli wrote:
> On 24/11/26 09:08, Sebastian Andrzej Siewior wrote:
> > On 2026-11-24 08:56:11 [+0100], Juri Lelli wrote:
> > > Hello,
> > > 
> > > On 23/11/26 14:41, Sebastian Andrzej Siewior wrote:
> > > > The fair_server exposes the runtime and period knobs per-CPU in the
> > > > debugfs folder. The debugfs interface is not a stable ABI.
> > > > Make the /sys/kernel/debug/sched/fair_server/cpu*/{period|runtime} knobs
> > > > available as /sys/kernel/sched/cpuX/{fair_server_period|fair_server_runtime}.
> > > > 
> > > > It adds a struct kobject to the rq and exposes only those two. The
> > > > per-runqueue folder is named `cpu' rather than `rq' since it might be
> > > > more intuitive to the user than `rq' or `runqueue'.
> > > > 
> > > > The set logic is pulled from the debugfs folder but it is still shared.
> > > > That debugfs logic could be removed (after providing the same for
> > > > ext-server) or symlinked for a while.
> > > 
> > > ...
> > > 
> > > > +static ssize_t rq_fair_server_runtime_show(struct kobject *kobj, struct kobj_attribute *attr,
> > > > +					   char *buf)
> > > > +{
> > > > +	struct rq *rq = kobj_to_rq(kobj);
> > > > +	struct sched_dl_entity *dl_se;
> > > > +
> > > > +	dl_se = &rq->fair_server;
> > > > +
> > > > +	return sysfs_emit(buf, "%llu\n", dl_se->dl_runtime);
> > > > +}
> > > 
> > > Since these files are new and meant to replace debugfs, how about using
> > > ns everywhere (you partly commented about it in the cover letter), as
> > > sched_attr and the dl_server parameters already do, with the unit in the
> > > name? I.e. fair_server_{runtime,period}_ns here and
> > > dl_{runtime,period}_ns in 2/6, with only the procfs compatibility path
> > > converting from us. Right now /sys/kernel/sched/ has dl_*_us in us next
> > > to cpuX/fair_server_* in ns without a suffix.
> > 
> > I can do both in ns (or us depending what is easier/ more useful). Let
> > me update that then.
> 
> Mind that it would be nice to hear from others in this thread before I
> make you do changes that others might not agree with. :)
>

I did notice the lack of units on the fair files.  I'd certainly go along
with adding the _ns to those at least. I don't have a strong preference
about them both being the same unit if they are properly named.

It probably makes sense but I leave it to people who know dl better to
say if sub-us configuration makes sense.


Cheers,
Phil

-- 

