Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629711D5147;
	Mon, 19 Jan 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823021; cv=none; b=k4PKRR+oTLqL6XOnZPgXfgLAWpFIxyKkcPDqsehDxS0es/5IhSXHkqtnF2iC3NhRUKEMig3Vc0RGfKP1kESFiL0z7V3KpK3iP6DhYUiZyKLsO6ceQlibcK7l11lP9AFtqiwTn3nz5HM+c49j4KYk8u6RV3D7wBr5fz4TdycsIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823021; c=relaxed/simple;
	bh=mimI2YD4kOqe8Pj6C5NTyUVR6ADfmYJs0vYKuGvekXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSSmTC9OiXiEfE44lwKHQ6SUkGq1LN6Be/W+s/32vHRc6z26Sj1X1M512xILOgmz0xZDwK7gsFwUsPrb2D/3PjWu9oE8tu03TbX2qs12VluXfJhFPBk+vB1pEmNPLD/8IMD7zbHdQzkqSoxq1IeJRIAhvare2EjynNNF0XNdRRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=byLb5sEI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byLb5sEI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FUewS8QbfWh+aEB0vex/4CyBedsuVBr10xneEJ5Etjc=; b=byLb5sEIdBeTrb7oOodUndpMnF
	MXDgqkmfBdNC4GWAQ8P+mofmhjyb7gJ2O7nsJ1zdXsY3UghlnLRR0u4HvwgHi6ZaYHUtQBsMR4TDI
	BaZB9/ZWTGjxf0NeWLbgkcLe1CxultcfJ6RqE+cmf82cr6ce1hIYnL34F622uX7YnIxY6wwXusrRu
	8+Qrr0j8zbsnqC6+cFKj4eERVBg6fLQ9upXtveme3cJONw8RM8nAysfDnLg5F6SjXhFtT8zIDNYGC
	wdF+IjjTHPurV7P18MzlZZDEWMx2mISPb6h0Kklt0HGTdTf6hxACysbXBfwWwsat/Le46pQ82m4p2
	dpmQavQg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhnfS-0000000BzS4-2ZGy;
	Mon, 19 Jan 2026 11:43:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9ADEF300754; Mon, 19 Jan 2026 12:43:33 +0100 (CET)
Date: Mon, 19 Jan 2026 12:43:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: boqun.feng@gmail.com, frederic@kernel.org, joelagnelf@nvidia.com,
	josh@joshtriplett.org, linux-kernel@vger.kernel.org,
	neeraj.upadhyay@kernel.org, paulmck@kernel.org, rcu@vger.kernel.org,
	rostedt@goodmis.org, srikar@linux.ibm.com, sshegde@linux.ibm.com,
	tglx@linutronix.de, urezki@gmail.com, samir@linux.ibm.com
Subject: Re: [PATCH] cpuhp: Expedite synchronize_rcu during SMT switch
Message-ID: <20260119114333.GI1890602@noisy.programming.kicks-ass.net>
References: <20260113090153.GS830755@noisy.programming.kicks-ass.net>
 <20260119104739.439799-2-vishalc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119104739.439799-2-vishalc@linux.ibm.com>

On Mon, Jan 19, 2026 at 04:17:40PM +0530, Vishal Chourasia wrote:
> Expedite synchronize_rcu() during the cpuhp_smt_[enable|disable] path to
> accelerate the operation.
> 
> Bulk CPU hotplug operations—such as switching SMT modes across all
> cores—require hotplugging multiple CPUs in rapid succession. On large
> systems, this process takes significant time, increasing as the number
> of CPUs to hotplug during SMT switch grows, leading to substantial
> delays on high-core-count machines. Analysis [1] reveals that the
> majority of this time is spent waiting for synchronize_rcu().
> 

You seem to have left out all the useful bits from your changelog again
:/

Anyway, ISTR Joel posted a patch hoisting a lock; it was a icky, but not
something we can't live with either.

Also, memory got jogged and I think something like the below will remove
2/3 of your rcu woes as well.

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 8df2d773fe3b..1365c19444b2 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2669,6 +2669,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_sync_enter(&cpu_hotplug_lock.rss);
 	for_each_online_cpu(cpu) {
 		if (topology_is_primary_thread(cpu))
 			continue;
@@ -2698,6 +2699,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	}
 	if (!ret)
 		cpu_smt_control = ctrlval;
+	rcu_sync_exit(&cpu_hotplug_lock.rss);
 	cpu_maps_update_done();
 	return ret;
 }
@@ -2715,6 +2717,7 @@ int cpuhp_smt_enable(void)
 	int cpu, ret = 0;
 
 	cpu_maps_update_begin();
+	rcu_sync_enter(&cpu_hotplug_lock.rss);
 	cpu_smt_control = CPU_SMT_ENABLED;
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
@@ -2728,6 +2731,7 @@ int cpuhp_smt_enable(void)
 		/* See comment in cpuhp_smt_disable() */
 		cpuhp_online_cpu_device(cpu);
 	}
+	rcu_sync_exit(&cpu_hotplug_lock.rss);
 	cpu_maps_update_done();
 	return ret;
 }
