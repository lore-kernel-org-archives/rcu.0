Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1D42065;
	Wed, 23 Jul 2025 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302896; cv=none; b=GwTExxy9XtuVlfTEShVGCj2HE3/gfNzfC69FTgmFwDdtfb1x3He2aGwO/bWxOvYAf34dVs+5Ai3Xb7F/s9jqxD5yx6R/dZy7tX1abjA2szoUl6LHHRxvWafBtIeaZnH8tm+kZVhU1EBV+6ELD7yxytMAqvJT9LBYSAOfTfdN8uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302896; c=relaxed/simple;
	bh=nwUbdKhwRsspymSsNXvaMFNpqpvFm3GWxuD8/E96iig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMsJSRYY3BWP5Jjh4dRwac45/7SGXucKm05RCrIKs/RCoVUTXaUJcVIPue6POjIJABAPTHTssS2yF4M1q4ZtWLlfNYrXJNFSHcsQ+b9TSi+kKXZ9Q2lT33COJW4iFFpn8KNSkk4eNGlroQVrrziKo7OnfRTymR0VFg8u+yJDx4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D52E0110F58;
	Wed, 23 Jul 2025 20:34:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 3A7E220010;
	Wed, 23 Jul 2025 20:34:49 +0000 (UTC)
Date: Wed, 23 Jul 2025 16:34:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/6] Switch __DECLARE_TRACE() to new notrace variant of
 SRCU-fast
Message-ID: <20250723163450.02bc299b@gandalf.local.home>
In-Reply-To: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
References: <45397494-544e-41c0-bf48-c66d213fce05@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3A7E220010
X-Stat-Signature: nzg1kbwmb5qhpy4itixisewhpkddkjrx
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SsEdMYVrsG5m3U60l6BeB5xDUJbFvF04=
X-HE-Tag: 1753302889-137071
X-HE-Meta: U2FsdGVkX18hzn3ui7P/M17SZO/GyLcB0stbWd/SfDbgW/r9VlL2HGOLMvAoAAjjbZhg8piUBniaeitlH6wdcNoSTy9VpRSm4tW6cAVH2WqGOdA0RwZJsylziid+DMhDTsPrypWBSfDIkxmblrDGtTjPJh2F5Ofy8AY/ZdtBvTuy4GE0v9tQ2emJ0pvGoC5vKQLtpRYsbgFWg2oD4bAgA8dyGVwYKToSlr1SmRb8zan3CAyuTp/IeLTW6Z8FmOOrdQgPW0mKGpziZI+6ns3Y1pSHbCAmR1JHtjTE1Hp7kYicM8af2Ay4hUErT0iyQzG8S+NKPLEA2eKBLtTOrIwzQnaW5XEDgiWc

On Wed, 23 Jul 2025 13:27:54 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> This triggers continues to trigger a kernel test robot report of a
> "using smp_processor_id() in preemptible" splat.  I looked for issues
> with explicit preemption disabling, and, not finding any, will next turn
> my attention to accesses to per-CPU variables.  Any and all insights
> are welcome.

Currently perf and ftrace expect the tracepoints to be called with
preemption disabled. You may need this:

diff --git a/include/trace/perf.h b/include/trace/perf.h
index a1754b73a8f5..1b7925a85966 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -71,7 +71,9 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count __attribute__((unused));				\
 	struct task_struct *__task __attribute__((unused));		\
 									\
+	preempt_disable_notrace();					\
 	do_perf_trace_##call(__data, args);				\
+	preempt_enable_notrace();					\
 }
 
 #undef DECLARE_EVENT_SYSCALL_CLASS
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4f22136fd465..0504a423ca25 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -436,7 +436,9 @@ __DECLARE_EVENT_CLASS(call, PARAMS(proto), PARAMS(args), PARAMS(tstruct), \
 static notrace void							\
 trace_event_raw_event_##call(void *__data, proto)			\
 {									\
+	preempt_disable_notrace();					\
 	do_trace_event_raw_event_##call(__data, args);			\
+	preempt_enable_notrace();					\
 }
 
 #undef DECLARE_EVENT_SYSCALL_CLASS


But please add it with the change, as there's "preempt_count" accounting to
report to the user that accounts that preemption was disabled when called.

-- Steve
