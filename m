Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD4218BC0F;
	Thu,  9 Jan 2025 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442039; cv=none; b=J2MzItHoH0STJgYXetSv/NwULFMcHmBRxgaLGtTvIAOZ9lmc33f1XRL3lX8pwRv6ab3eRUYX0m1nZpiSn+gu/1f9CyK3mQkP8WVUTbguyGIJahUbRpQmwjq4opSb6fSGhFbAaiTikZPQnMSYDk4F+wXOYKfo1l60lHUds8r1y3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442039; c=relaxed/simple;
	bh=WhFv0u8O0AhQ1Udm/s9bO+WpSwWsAqIahkUwU6hTSD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NP5l8dlL0e6KpCJuTUL14RteWbLmBWrHI26fCFvdHnTchbX/XrlqUtf09wQtVX04E5i84k6oDE3T7zbf9OJI890EFU10SdooWnDHYHwu2AmNghGeIlJf22zfRgvRQI95qeSnLCFOixU0obV3sZjPqzi7n3tvGWS8uJfp2VAVoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGqrIrcH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGqrIrcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB54C4CED6;
	Thu,  9 Jan 2025 17:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736442039;
	bh=WhFv0u8O0AhQ1Udm/s9bO+WpSwWsAqIahkUwU6hTSD4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZGqrIrcHhNVtyCk+GPqnX7qRvE/ckTxAjQMb8jEEumutlaY5mjE4f7ROxwiSc2RIJ
	 qyY2YBgw+/QmZ3s8TYvvynW1L5Th0dL6doL6S+NBd/Kk//Pgr6YWe1cb8zFI07Cp/1
	 I9ACpiGu9xDGl1+d0KH0dRGwh5NBRAq7s8zmwaEXF2xO/68YPfYGia/CFfGmQC1esm
	 u9crUJ8GolGcjihArB2eSqLLEBy0p8odxAqdVowfgB3ySx002plmoxiTJfZApflWvx
	 o/+tRhKniHouD3Zx4GWkiLVJQuFphQZo5+/EbdiaXPL9Ao3YUDBPUBigUM8Wt1kXvE
	 Z9kTEpVKDyxMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 047DDCE0DD2; Thu,  9 Jan 2025 09:00:39 -0800 (PST)
Date: Thu, 9 Jan 2025 09:00:39 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: David Reaver <me@davidreaver.com>, Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krister Johansen <kjlx@templeofstupid.com>
Subject: Re: [PATCH] checkpatch: Remove migrated RCU APIs from deprecated_apis
Message-ID: <ba29b345-563b-43ce-a42a-134e3d09d550@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250108192456.47871-1-me@davidreaver.com>
 <ae3a285f61f087aed7aa0355d8ca6025994d4119.camel@perches.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3a285f61f087aed7aa0355d8ca6025994d4119.camel@perches.com>

On Thu, Jan 09, 2025 at 07:56:51AM -0800, Joe Perches wrote:
> On Wed, 2025-01-08 at 11:24 -0800, David Reaver wrote:
> > The deprecated_apis map was created in [1] so checkpatch would flag
> > deprecated RCU APIs. These deprecated APIs have since been removed from the
> > kernel. This patch removes them from this map so checkpatch doesn't waste
> > time looking for them, and so readers of checkpatch looking for deprecated
> > APIs don't waste time searching for them.
> 
> Acked-by: Joe Perches <joe@perches.com>
> 
> Maybe remove the references from rcupdateup.h one day too.

Good point, please see below.

Some instances remain in Documentation/RCU/RTFP.txt, but these are needed
to record the history.

							Thanx, Paul

------------------------------------------------------------------------

commit a8280286a6425f26785aeedfe9b209a65ca1d6fd
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Jan 9 08:52:15 2025 -0800

    rcu: Remove references to old grace-period-wait primitives
    
    The rcu_barrier_sched(), synchronize_sched(), and synchronize_rcu_bh()
    RCU API members have been gone for many years.  This commit therefore
    removes non-historical instances of them.
    
    Reported-by: Joe Perches <joe@perches.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 6da7f66da2a80..12a7b059654f7 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -329,10 +329,7 @@ Answer:
 	was first added back in 2005.  This is because on_each_cpu()
 	disables preemption, which acted as an RCU read-side critical
 	section, thus preventing CPU 0's grace period from completing
-	until on_each_cpu() had dealt with all of the CPUs.  However,
-	with the advent of preemptible RCU, rcu_barrier() no longer
-	waited on nonpreemptible regions of code in preemptible kernels,
-	that being the job of the new rcu_barrier_sched() function.
+	until on_each_cpu() had dealt with all of the CPUs.
 
 	However, with the RCU flavor consolidation around v4.20, this
 	possibility was once again ruled out, because the consolidated
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 6672e55deeaa4..9b05db8ff0619 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -800,11 +800,9 @@ do {									      \
  * sections, invocation of the corresponding RCU callback is deferred
  * until after the all the other CPUs exit their critical sections.
  *
- * In v5.0 and later kernels, synchronize_rcu() and call_rcu() also
- * wait for regions of code with preemption disabled, including regions of
- * code with interrupts or softirqs disabled.  In pre-v5.0 kernels, which
- * define synchronize_sched(), only code enclosed within rcu_read_lock()
- * and rcu_read_unlock() are guaranteed to be waited for.
+ * Both synchronize_rcu() and call_rcu() also wait for regions of code
+ * with preemption disabled, including regions of code with interrupts or
+ * softirqs disabled.
  *
  * Note, however, that RCU callbacks are permitted to run concurrently
  * with new RCU read-side critical sections.  One way that this can happen
@@ -859,11 +857,10 @@ static __always_inline void rcu_read_lock(void)
  * rcu_read_unlock() - marks the end of an RCU read-side critical section.
  *
  * In almost all situations, rcu_read_unlock() is immune from deadlock.
- * In recent kernels that have consolidated synchronize_sched() and
- * synchronize_rcu_bh() into synchronize_rcu(), this deadlock immunity
- * also extends to the scheduler's runqueue and priority-inheritance
- * spinlocks, courtesy of the quiescent-state deferral that is carried
- * out when rcu_read_unlock() is invoked with interrupts disabled.
+ * This deadlock immunity also extends to the scheduler's runqueue
+ * and priority-inheritance spinlocks, courtesy of the quiescent-state
+ * deferral that is carried out when rcu_read_unlock() is invoked with
+ * interrupts disabled.
  *
  * See rcu_read_lock() for more information.
  */
