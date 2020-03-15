Return-Path: <SRS0=wCpI=5A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BEBC10DCE
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 17:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6181206EB
	for <rcu@archiver.kernel.org>; Sun, 15 Mar 2020 17:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="i2fD1vdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgCORpH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:45:07 -0400
Received: from mail.efficios.com ([167.114.26.124]:55322 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbgCORpH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 15 Mar 2020 13:45:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 569BB25265B;
        Sun, 15 Mar 2020 13:45:06 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uBRmkdaKLqTU; Sun, 15 Mar 2020 13:45:06 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id DD62D25265A;
        Sun, 15 Mar 2020 13:45:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DD62D25265A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584294305;
        bh=TBC3tg+fQLWhANZZ+S2T6zpVClByqCGVvreSonLonsE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=i2fD1vdquDb50EMgAM85zQXLibDdtL1GV8ui6FMpF1f5IAW5Opr2O8Zk2zT98Eqfs
         mMvMgQOZMiJqN4JkS9uj/3jjf8bRJgYb4joq5rdibQQ89C2PYZdhLUYy7FPLC9WpVd
         +wVkO2oOf4w14IhZG37AADRXcd6VsCIRdMXn8vfL1cVy/CfbxTcx7QSxM1bySyVL8q
         JEqn+OK1aUzjwUsWRjrqz/3ObF4+hGoklGovatjFnecaWC28tGb7sxbF2FqTvVO1e8
         kNbDrZZJI4zWmlrSUJsjgH1FvDjYsybym991eu2TTZgNpKPKrKY2zQQjR03caCyvrX
         coR/+rvBh4fEA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bq-mjMuJjExz; Sun, 15 Mar 2020 13:45:05 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C726F253280;
        Sun, 15 Mar 2020 13:45:05 -0400 (EDT)
Date:   Sun, 15 Mar 2020 13:45:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <2062731308.28584.1584294305768.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200313154243.GU3199@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72> <20200313144145.GA31604@lenoir> <20200313154243.GU3199@paulmck-ThinkPad-P72>
Subject: Re: [PATCH RFC tip/core/rcu 0/16] Prototype RCU usable from idle,
 exception, offline
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Prototype RCU usable from idle, exception, offline
Thread-Index: a/NhvL+0Mq6sqPjESRf5g9/gd7j1wg==
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

----- On Mar 13, 2020, at 11:42 AM, paulmck paulmck@kernel.org wrote:

> On Fri, Mar 13, 2020 at 03:41:46PM +0100, Frederic Weisbecker wrote:
>> On Thu, Mar 12, 2020 at 11:16:18AM -0700, Paul E. McKenney wrote:
>> > Hello!
>> > 
>> > This series provides two variants of Tasks RCU, a rude variant inspired
>> > by Steven Rostedt's use of schedule_on_each_cpu(), and a tracing variant
>> > requested by the BPF folks and perhaps also of use for other tracing
>> > use cases.
>> > 
>> > The tracing variant has explicit read-side markers to permit finite grace
>> > periods even given in-kernel loops in PREEMPT=n builds It also protects
>> > code in the idle loop, on exception entry/exit paths, and on the various
>> > CPU-hotplug online/offline code paths, thus having protection properties
>> > similar to SRCU.  However, unlike SRCU, this variant avoids expensive
>> > instructions in the read-side primitives, thus having read-side overhead
>> > similar to that of preemptible RCU.
>> > 
>> > There are of course downsides.  The grace-period code can send IPIs to
>> > CPUs, even when those CPUs are in the idle loop or in nohz_full userspace.
>> > It is necessary to scan the full tasklist, much as for Tasks RCU.  There
>> > is a single callback queue guarded by a single lock, again, much as for
>> > Tasks RCU.  If needed, these downsides can be at least partially remedied
>> 
>> So what we trade to fix the issues we are having with tracing against extended
>> grace periods, we lose in CPU isolation. That worries me a bit as tracing can
>> be thoroughly used with nohz_full and CPU isolation.
> 
> First, disturbing nohz_full CPUs can be avoided by the sysadm simply
> refusing to remove tracepoints while sensitive applications are running
> on nohz_full CPUs.

I doubt this approach will survive real-life.

> 
> Second, for non-CPU-bound real-time programs with mostly-idle CPUs,
> I should be able to decrease the likelihood of sending IPIs pretty much
> to zero.
> 
> Or am I missing something here?

I would recommend considering the following alternative for this tracing-rcu
flavor:

- For all CPUs which are not nohz_full:
  - Implement fast RCU read-side which only requires compiler barriers,
  - Use IPIs to each of those CPUs when doing a grace period.

- For all nohz_full CPUS:
  - Dynamically detect CPUs which are nohz_full,
  - Implement slower RCU read-side with memory barriers,
  - No need to issue any IPI to those CPUs when doing the grace period.

This should cover all use-cases: staying fast for the common case, without
disturbing RT workloads.

Thoughts ?

Thanks,

Mathieu




-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
