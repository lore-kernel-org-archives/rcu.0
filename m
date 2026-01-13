Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1453815C4;
	Tue, 13 Jan 2026 09:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768294925; cv=none; b=mUzYmVwM6ZWfA/kGZF/KFF/gVTEFWGkgRT0N6oK3eps4W+WcyZySWDqMn6Vx5w7Uuw4pKV8jjo2KSYJ2huo7VfaMYs1WiTRAFF97SF21kJ+X9xxIVv7wsb84yXiK2RK2kv10ueOWaOc+nzeaC6qydVH9mVUnvyu81kB9jHUceUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768294925; c=relaxed/simple;
	bh=Ugg9kO1kvmwNnImkmKOJMylsk6+u3gNSh5S7RYd+XIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR7d/chKR1YomBSCZMTn/KgsyHsV5DmS7Gy/+wXq9Janl7DoYpde/yLgl6UgPg5a5M7GqT0K+eQwCYF0XQWm9qt2ZDBK+4xXYpFO/lxzMaQD29nOPmWteNYNdjRREXn1W2zDkDyMMJHaWmLcuCYUUPyVXXrK7sqwPMjyqxxEGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d1OYgvaF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d1OYgvaF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=VYL+MLZo7wXx+3J80b+IAPbUOtbDczlAc9UO0ugMEvg=; b=d1OYgvaFJxByjSGEUVoKMNGPQK
	bxFn8Sm66E+37f1oDZeCFdYDpWI+b8mCNCaKoGu8QmiJ9/DK+HSROXjpmsC+3k7wi8t8mx+1u4qc7
	jFHS/8QWPoKbCcqDel/ToZgs6LlSFwUhyuk+DZV+EON7bhv+f1jmb0WR8Ngi2W8OYj5SSkpKTeqU4
	+6aR15eKDVxi95kJhyhSJnpyNrl0wbg5TFDAp0JBhb/EJxrmuwsH++yW1iXzsv1StU6sbikETIju5
	CgpWUKJgf0vgPLdc1yZFkojQ/L5l5cUX6sJ+ggJJUim+S2t6EOLm2yfwH1weXG21Jbk0PEsoCeoBj
	yLdjIiGg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfaHi-00000004Tw5-29Bd;
	Tue, 13 Jan 2026 09:01:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 524D6302FA1; Tue, 13 Jan 2026 10:01:53 +0100 (CET)
Date: Tue, 13 Jan 2026 10:01:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@kernel.org,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com, josh@joshtriplett.org, boqun.feng@gmail.com,
	urezki@gmail.com, rostedt@goodmis.org, tglx@linutronix.de,
	sshegde@linux.ibm.com, srikar@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during CPU hotplug
 operations
Message-ID: <20260113090153.GS830755@noisy.programming.kicks-ass.net>
References: <20260112094332.66006-2-vishalc@linux.ibm.com>
 <20260112142440.GN830755@noisy.programming.kicks-ass.net>
 <aWU21GJBx5WC0Gwv@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWU21GJBx5WC0Gwv@linux.ibm.com>

On Mon, Jan 12, 2026 at 11:30:52PM +0530, Vishal Chourasia wrote:
> Hello Peter,
> 
> 
> 
> On Mon, Jan 12, 2026 at 03:24:40PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 12, 2026 at 03:13:33PM +0530, Vishal Chourasia wrote:
> > > Bulk CPU hotplug operations—such as switching SMT modes across all
> > > cores—require hotplugging multiple CPUs in rapid succession. On large
> > > systems, this process takes significant time, increasing as the number
> > > of CPUs grows, leading to substantial delays on high-core-count
> > > machines. Analysis [1] reveals that the majority of this time is spent
> > > waiting for synchronize_rcu().
> > > 
> > > Expedite synchronize_rcu() during the hotplug path to accelerate the
> > > operation. Since CPU hotplug is a user-initiated administrative task,
> > > it should complete as quickly as possible.
> > > 
> > > Performance data on a PPC64 system with 400 CPUs:
> > > 
> > > + ppc64_cpu --smt=1 (SMT8 to SMT1)
> > > Before: real 1m14.792s
> > > After:  real 0m03.205s  # ~23x improvement
> > > 
> > > + ppc64_cpu --smt=8 (SMT1 to SMT8)
> > > Before: real 2m27.695s
> > > After:  real 0m02.510s  # ~58x improvement
> > > 
> > 
> > But who cares? Its not like you'd *ever* do this, right?
> Users dynamically adjust SMT modes to optimize performance of the
> workload being run. And, yes it doesn't happen too often, but when it
> does, on machines with (>= 1920 CPUs) it takes more than 20 mins to
> finish.

Users cannot change this, it is root only.

Having to change SMT mode per workload seems quite insane; but whatever.

If you do have to put RCU hooks anywhere; I'd much rather see them in
cpuhp_smt_{en,dis}able(), such that they only affect the batch hotplug
case, rather than everything using cpus_write_lock().

Also note that there is a case to be made to optimize this batch hotplug
case; for one it makes no sense to take cpus_write_lock() over and over
and over again; if you can pull that out, just like it already lifted
cpu_maps_update_begin(), this would help.

And Joel has a point, in that it might make sense for RCU to behave
'better' under these conditions.


