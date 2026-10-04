Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F4360EF0;
	Sun,  4 Oct 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791111886; cv=none; b=kjGTQPYwUEHt7Mw1H51AlD6Sg8YO9cVtvNIQ78w4qLJdV3e4PpeXqE0tapb1v2Ff/Ry9QgNiOf/cFm330gGQh0NiVdnYs/XrTnG/Ie7yiUVy9OMuKO4jGdDfcexN8B4UdnAf6fymXfLkxp5YvXOTjMxTaXLiHEQKgWuSVSE3mJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791111886; c=relaxed/simple;
	bh=QkS36lT2/ARWqllUrBVAkHmGiUuZ2AmL/orAH/cOQmE=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=VrQ6oScndvtw4/0hlNUeWx0cxxzAhuoIar3m2xtMr2MRSNOf1c3JJRvocZ7NV45nVMAl6yCnvAO86Ua5N1186jUWyzJFGmgMa6sxZeodlaNmC9ECb0KuOvS6X3mM37SzcQuBPXviB1R/rC49NHTYHw6GMZ6+rRAAmM9xOqjUdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Li7OLEd0; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=yvIF73G0; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Li7OLEd0";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="yvIF73G0"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791111876; bh=ZPXkDvbverD65+VZDpfPi4B
	HF52YeSScp8NFDj2cQIo=; b=Li7OLEd0KzHlfRlkfj7jlHig+zVY5q3AoxvrA2/v7EWX4boYzT
	SjOMs2Ql+u0LpnakfVDK1Qjaq5Uvazd9Sd9px4X/XKL6OXdrkWwOPltYtb+H8IwyYuPxlSQxhZ5
	VyT+c9wxiiQD6tPLulkVZQ9hLiW507LmMxnuyYnwuoE0NzzryjgZFbtHzWD3eIJFPUq5UaX7AEo
	QRdGQROP75uphOlQydg/DtrCeMQqmxrLDj3Uu/x0YyW2DJnRsgaWSE0w9z7ibF/jVZAiy1hVYjs
	Qrs0YuyFshpKsC5yiUnlSeZXGZFjKCFwbvsH1hWBV4YAGSsvibJXbssr9xkUQ6r69oA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1791111876; bh=ZPXkDvbverD65+VZDpfPi4B
	HF52YeSScp8NFDj2cQIo=; b=yvIF73G0PBMhUlanYn9yW/yBdw6bK76mp5QeLUlCNJoGVygWSz
	G+Su+AbrLZ4pNAW6O20qE0XkMGKXauLP8CCg==;
Date: Sun, 04 Oct 2026 12:04:35 +0100
From: Bradley Morgan <brads@mainlining.org>
To: shenxiaogll@gmail.com
CC: boqun@kernel.org, corbet@lwn.net, frederic@kernel.org, jiangshanlai@gmail.com,
 joelagnelf@nvidia.com, josh@joshtriplett.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 neeraj.upadhyay@kernel.org, paulmck@kernel.org, qiang.zhang@linux.dev,
 rcu@vger.kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
 skhan@linuxfoundation.org, urezki@gmail.com
Subject: Re: [PATCH] rcu: Enable runtime reset of the RCU stall panic count
In-Reply-To: <20261004-rcu-v1-1-3799a44367f1@gmail.com>
Message-ID: <7D1519BB-3576-4BAA-B08A-89F4D775A15D@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 4 October 2026 02:14:25 BST, Cunlong Li <shenxiaogll@gmail.com> wrote:
>The kernel.panic_on_rcu_stall and kernel.max_rcu_stall_to_panic sysctls
>count RCU CPU stalls since system boot, and invoke panic() once
>max_rcu_stall_to_panic stalls have elapsed.  This count is never reset,
>so stalls caused by transient incidents keep consuming the budget of a
>long-running system, and a later unrelated stall can immediately
>trigger panic() instead of allowing the intended fresh window of
>stalls.
>
>This commit therefore introduces the kernel.rcu_stall_panic_count
>sysctl.  Reading this file reports the number of stalls counted so far,
>and writing 0 to it resets the count.  This allows the cumulative stall
>history to be cleared after an incident has been resolved, and also
>allows userspace to clear the count periodically, so that panic() is
>only triggered by a burst of stalls occurring within a short period.
>

Hi, LGTM!


Reviewed-by: Bradley Morgan <brads@mainlining.org>


>Signed-off-by: Cunlong Li <shenxiaogll@gmail.com>
>---
> Documentation/admin-guide/sysctl/kernel.rst | 15 ++++++++++++++-
> kernel/rcu/tree_stall.h                     | 28
> ++++++++++++++++++++++++++--
> 2 files changed, 40 insertions(+), 3 deletions(-)
>
>diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>index ffea61d448eb..64fe2985e358 100644
>--- a/Documentation/admin-guide/sysctl/kernel.rst
>+++ b/Documentation/admin-guide/sysctl/kernel.rst
>@@ -959,7 +959,20 @@ max_rcu_stall_to_panic
> When ``panic_on_rcu_stall`` is set to 1, this value determines the
> number of times that RCU can stall before panic() is called.
> 
>-When ``panic_on_rcu_stall`` is set to 0, this value is has no effect.
>+When ``panic_on_rcu_stall`` is set to 0, this value has no effect.
>+
>+rcu_stall_panic_count
>+=====================
>+
>+Indicates the number of RCU CPU stalls that have been counted since
>+system boot or since the counter was reset. When ``panic_on_rcu_stall``
>+is set to 1, this count is compared against ``max_rcu_stall_to_panic``
>+to decide whether panic() should be called.
>+
>+Writing 0 to this file resets the counter to zero, which restarts the
>+``max_rcu_stall_to_panic`` window of stalls. This allows system
>+administrators to clear the cumulative stall count after an incident
>+has been resolved, without requiring a system restart.
> 
> perf_cpu_time_max_percent
> =========================
>diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
>index 091e7850ab6e..a80f03e1c7ea 100644
>--- a/kernel/rcu/tree_stall.h
>+++ b/kernel/rcu/tree_stall.h
>@@ -19,6 +19,20 @@
> /* panic() on RCU Stall sysctl. */
> static int sysctl_panic_on_rcu_stall __read_mostly;
> static int sysctl_max_rcu_stall_to_panic __read_mostly;
>+static unsigned long sysctl_rcu_stall_panic_count;
>+
>+/* Reset the RCU stall panic count when written to. */
>+static int proc_do_rcu_stall_panic_count(const struct ctl_table *table, int write,
>+					 void *buffer, size_t *lenp, loff_t *ppos)
>+{
>+	if (!write)
>+		return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
>+
>+	WRITE_ONCE(sysctl_rcu_stall_panic_count, 0);
>+	*ppos += *lenp;
>+
>+	return 0;
>+}
> 
> static const struct ctl_table rcu_stall_sysctl_table[] = {
> 	{
>@@ -39,6 +53,13 @@ static const struct ctl_table rcu_stall_sysctl_table[] = {
> 		.extra1		= SYSCTL_ONE,
> 		.extra2		= SYSCTL_INT_MAX,
> 	},
>+	{
>+		.procname	= "rcu_stall_panic_count",
>+		.data		= &sysctl_rcu_stall_panic_count,
>+		.maxlen		= sizeof(sysctl_rcu_stall_panic_count),
>+		.mode		= 0644,
>+		.proc_handler	= proc_do_rcu_stall_panic_count,
>+	},
> };
> 
> static int __init init_rcu_stall_sysctl(void)
>@@ -161,7 +182,7 @@ early_initcall(check_cpu_stall_init);
> /* If so specified via sysctl, panic, yielding cleaner stall-warning
> output. */
> static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> {
>-	static int cpu_stall;
>+	unsigned long count;
> 
> 	/*
> 	 * Attempt to kick out the BPF scheduler if it's installed and defer
>@@ -170,7 +191,10 @@ static void panic_on_rcu_stall(const struct cpumask *stalled_mask)
> 	if (scx_rcu_cpu_stall(stalled_mask))
> 		return;
> 
>-	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
>+	/* A lost RMW update only delays the panic by one stall. */
>+	count = READ_ONCE(sysctl_rcu_stall_panic_count) + 1;
>+	WRITE_ONCE(sysctl_rcu_stall_panic_count, count);
>+	if (count < (unsigned long)READ_ONCE(sysctl_max_rcu_stall_to_panic))
> 		return;
> 
> 	if (sysctl_panic_on_rcu_stall)
>
>---
>base-commit: ce1e0223d8ad4211275c82a17ed6d43ab81e13d9
>change-id: 20261003-rcu-375496d7704e
>
>Best regards,
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
