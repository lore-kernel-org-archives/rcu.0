Return-Path: <SRS0=F17Q=CT=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB2AC43461
	for <rcu@archiver.kernel.org>; Thu, 10 Sep 2020 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B30AC21D7E
	for <rcu@archiver.kernel.org>; Thu, 10 Sep 2020 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599769263;
	bh=TVXcsgCAIE3J4CKEnU244kyeJ3WeU3LxPW676Kop+zk=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=HIacnMLmLE9zrI3xJsnsZWuy9YaPpkeVOv+JWEtYUv5zSi99QJU2T9Xdlp3evp3Rb
	 ZiZ/35+aLUs54OUcC0fnXlL4ESpEjKz/IcWjy31ZA/s8GX2ZaDUyXIu+7tnYCC0Gtf
	 Vnl3RXOAbk7orDXjylmb57K2D6kyek5xbcGsGk0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgIJUUn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgIJUUM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Sep 2020 16:20:12 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD3F20882;
        Thu, 10 Sep 2020 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599769196;
        bh=TVXcsgCAIE3J4CKEnU244kyeJ3WeU3LxPW676Kop+zk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=VA8uvxxEYcis7kulu5NUYwyPHRIboMp7ipEPsOpcXRwa9V9wl3Kp9nMhBoUnyb05f
         JxB+9rBPobHzU17oAg/tJqEh8tA8S3GgszUXpCvGmrwxZ1gzuexT33fFAezu/JSTSV
         wRU2Tf8jUTOfSoXAwKKjMZLSsfjosjqFXcJV9rcw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4BB413523080; Thu, 10 Sep 2020 13:19:56 -0700 (PDT)
Date:   Thu, 10 Sep 2020 13:19:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        jolsa@redhat.com, bpf@vger.kernel.org
Subject: [PATCH RFC tip/core/rcu 0/4] Accelerate RCU Tasks Trace updates
Message-ID: <20200910201956.GA24190@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello!

This series accelerates RCU Tasks Trace updates, reducing the average
grace-period latencies from about a second to about 20 milliseconds
on my x86 laptop.  These are benchmark numbers, based on a previously
posted patch to rcuscale.c [1] running on my x86 laptop.  The patches
in this series are as follows:

1.	Mark variables static, noted during this effort but otherwise
	unconnected.  This change has no effect, so that the average
	grace-period latency remains at 980 milliseconds.

2.	Use more aggressive polling for RCU Tasks Trace.  This polling
	starts at five-millisecond intervals instead of the prior
	100-millisecond intervals.  As before, the polling interval
	increases in duration as the grace period ages, and again as
	before is capped at one second.  This change reduces the
	average grace-period latency to about 620 milliseconds.

3.	Selectively enable more RCU Tasks Trace IPIs.  This retains
	the old behavior of suppressing IPIs for grace periods that are
	younger than 500 milliseconds for CONFIG_TASKS_TRACE_RCU_READ_MB=y
	kernels, including CONFIG_PREEMPT_RT=y kernels, but allows IPIs
	immediately on other kernels.  It is quite possible that a more
	sophisticated decision procedure will be required, and changes
	to RCU's dyntick-idle code might also be needed.  This change
	(along with the earlier ones) reduces the average grace-period
	latency to about 120 milliseconds.

4.	Shorten per-grace-period sleep for RCU Tasks Trace.  The
	current code sleeps for 100 milliseconds after the end of
	each grace period, which by itself prevents a back-to-back
	string of grace-period waits from completing faster than
	ten per second.  This patch also retains this old behavior
	for CONFIG_TASKS_TRACE_RCU_READ_MB=y (and again thus also
	for CONFIG_PREEMPT_RT=y kernels).  For other kernels, this
	post-grace-period sleep is reduced to five milliseconds.
	This change (along with the earlier ones) reduced the average
	grace-period latency to about 18 milliseconds, for an overall
	factor-of-50 reduction in latency.

Alexei Starovoitov benchmarked an earlier patch [2], producing results
that are roughly consistent with the above reduction in latency [3].

							Thanx, Paul

[1] https://lore.kernel.org/bpf/20200909193900.GK29330@paulmck-ThinkPad-P72/
[2] https://lore.kernel.org/bpf/20200910052727.GA4351@paulmck-ThinkPad-P72/
[3] https://lore.kernel.org/bpf/619554b2-4746-635e-22f3-7f0f09d97760@fb.com/

------------------------------------------------------------------------

 tasks.h |   37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)
