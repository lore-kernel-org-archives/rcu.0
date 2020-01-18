Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0ECC32771
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 20:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB86324683
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 20:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="iD4eCwBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgARUML (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:12:11 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39245 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgARUML (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 18 Jan 2020 15:12:11 -0500
Received: by mail-pj1-f67.google.com with SMTP id e11so5051960pjt.4
        for <rcu@vger.kernel.org>; Sat, 18 Jan 2020 12:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M9GeZJ2OKRa7dQTXFiLf9OjDaY9WapNmWJyN1TnZQ3c=;
        b=iD4eCwBsFcMscmzfZTKkrgPmfP+zATbHdXrwLcueZ/C6bdUZFpk1HNasY82Btb8OLe
         dDa2wcOvkqxCnyvwAfUAuXoFQBsaXO8CzkKdZ+2n1KHq0bP9MAc4OOwF3NizLQQXmPhl
         8FBoK7ZosDTTdQa9lF7k+sZx74n4UInT/cSOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M9GeZJ2OKRa7dQTXFiLf9OjDaY9WapNmWJyN1TnZQ3c=;
        b=SlPus0JuFnS8gGXPX4INsL3dBwTphhYI4ZC/FdwmAV5EM5n6WvMZ8OiQyFUJ3A0EkA
         6nU+xWNNsdAEeZo+5p4eRTC8NFwRyMKEyzJVUVFrEf/GfpYZRrTmb5Y4xL8eppOZfx4w
         3+STR48AVtGoQf+tP37o0a3DQRMiuh/vsK9Ef2OyvyRt7rUyPJRjpm+kRQ+vKukPSvxD
         WulvF86bnQAXVTYu+quSulUaUxT4dtWL/uI+oAZf91LlcCK3Ej30mpcFkVkU3vJNBzJl
         X1ZRUaVFx11XjNMMSz6GIIAXgesX/DFvJ0+40bfRK+l2npi81q/Q5RpjruYwqWAUj9e9
         sTkA==
X-Gm-Message-State: APjAAAUr24NAITYJihM+qGlSNtHua1WGj1vEqtcSfD7MHKfTFNRqk7Vu
        DDKracrasGcobLi9Xv2RCjYUBA==
X-Google-Smtp-Source: APXvYqyvNwhOWFGPvuaApEFwetZMQEX14Bjx7iYZRZc9RG7yP6bOQSd1dw2pv39YdLkqffH9ZBPTTA==
X-Received: by 2002:a17:90b:11d7:: with SMTP id gv23mr14091833pjb.94.1579378330476;
        Sat, 18 Jan 2020 12:12:10 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b1sm23813411pfp.44.2020.01.18.12.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 12:12:09 -0800 (PST)
Date:   Sat, 18 Jan 2020 15:12:08 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118201208.GC244899@google.com>
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
 <20200118021049.GC211665@google.com>
 <20200118042826.GR2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118042826.GR2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 08:28:26PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 17, 2020 at 09:10:49PM -0500, Joel Fernandes wrote:
> > On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
> > > On Fri, Jan 17, 2020 at 05:18:04PM -0500, Joel Fernandes wrote:
> > > > On Fri, Jan 17, 2020 at 04:58:14PM -0500, Joel Fernandes wrote:
> > > > > Hi,
> > > > > Me and Daniel were poking around with RCU_BOOST. I wrote a kernel module to
> > > > > test it a bit and I don't see the boost happening (thanks to Daniel for idea
> > > > > of writing a module). Haven't debugged it more yet. Will look more tomorrow.
> > > > > But below is the kernel module code and it prints a FAIL message to kernel
> > > > > logs in a few seconds.
> > > > > 
> > > > > I see the reader thread not getting CPU for several seconds. RCU_BOOST_DELAY
> > > > > is set to 500.
> > > > > 
> > > > > Thoughts?
> > > > 
> > > > So this could be because I did not start a grace period which is quite silly.
> > > > I am sorry about that. I will add another thread to start grace periods as
> > > > well and let you know if I still see a problem.
> > > 
> > > In addition, the RCU_READER_DELAY isn't long enough to trigger RCU priority
> > > boosting.  And RCU_BLOCKER_DELAY would be, except that I am not seeing
> > > an RCU read-side critical section surrounding it.
> > 
> > I was assuming that only the thread being preempted needs an RCU read-side
> > critical section. That preempted section would inherit the priority of the
> > thread preempting it (the blocking thread). So the blocking thread would not
> > need a read-side critical section, it just would need to be higher priority
> > than the thread it is preempting and preempt it long enough to trigger the
> > boosting.
> > 
> > Did I miss something?
> 
> Yes.  That is not how RCU priority boosting works.
> 
> What happens instead is that a set of rcub kthreads (one per leaf
> rcu_node structure) run at the SCHED_FIFO priority specified by the
> rcutree.kthread_prio kernel-boot parameter (as does the grace-period
> kthread when RCU priority boosting is enabled).  When the grace-period
> kthread decides that boosting is needed, it awakens the relevant rcub
> kthread.  The rcub kthread initializes an rt_mutex into a state where
> it appears to be held by the task that has been too long in an RCU
> read-side critical section, then acquires the lock.  The lock-based
> priority-boosting mechanism kicks in at that point.  (I heard this
> approach from tglx.)

Thanks for the details. It makes sense to me.

> And I missed something as well, namely that everything is bound to the
> same CPU in your test.  But did you remember to set rcutree.kthread_prio
> to greater than 60?  It defaults to 1 when RCU priority boosting is
> enabled, which isn't going to do much to a prio-50 SCHED_FIFO task,
> let alone a prio-60 SCHED_FIFO task.

Yes indeed this was the issue. I set rcutree.kthread_prio to 90 and see the
test passing now. Below is the updated test code for archival.

But wouldn't this be an issue unless rcu.kthread_prio is set the MAX_RT_PRIO
or some high number? Because otherwise there could always be threads that
don't get boosted.

> > > But rcutorture already has tests for RCU priority boosting.  Or are those
> > > failing in some way?
> > > 
> > > Either way, it is good to see interest in RCU priority boosting.  ;-)
> > 
> > The interest is purely academic and curiousity-driven at this point ;-).
> 
> Fair enough!
> 
> > Speaking of which why is the config not default-enabled and would it not be a
> > good thing to enable everywhere or there some who dislike it?
> 
> It is enabled by default in the -rt kernel.  It has been some time since
> I proposed enabling it by default in mainline, but the last time that
> proposal was not well received.  My approach is to wait until it becomes
> a problem in mainline, and if it does, propose making it the default in
> mainline.

It could also be some problem that no one has root caused to a lack of
boosting?  ;-)

> Except that I haven't heard of any such problems, so I have made no
> such proposal.

Makes sense.

> > Another thought is for RCU_BOOST systems to reduce the threshold of
> > triggering boost dynamically if the system is at the risk of running out of
> > memory.
> 
> Agreed, and that is in fact the purpose of the check of rcu_state.cbovld
> in rcu_initiate_boost().  And why we need to get the number of
> outstanding kfree_rcu() blocks fed into the computation leading up to
> rcu_state.cbovld.  ;-)

Oh, I see this new code. I will study it and look into it more. Agreed on the
feeding of kfree_rcu() blocks and/or memory pressure information into the
computations leading up to cbovld.

thanks,

 - Joel

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] Kernel module to test RCU_BOOST

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 drivers/misc/Makefile |   2 +-
 drivers/misc/ptest.c  | 141 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/ptest.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c1860d35dc7e..ba34957dff26 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for misc devices that really don't fit anywhere else.
 #
-
+obj-m += ptest.o
 obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 obj-$(CONFIG_IBMVMC)		+= ibmvmc.o
 obj-$(CONFIG_AD525X_DPOT)	+= ad525x_dpot.o
diff --git a/drivers/misc/ptest.c b/drivers/misc/ptest.c
new file mode 100644
index 000000000000..e5ece58e45ea
--- /dev/null
+++ b/drivers/misc/ptest.c
@@ -0,0 +1,141 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+
+#define RCU_READER_DELAY 100 //ms
+#define RCU_BLOCKER_DELAY 800 //ms
+
+/* Max delta in rcu_reader beyond which we can
+ * say boosting failed.  CONFIG_RCU_BOOST=200 in my setup plus booster wakes up
+ * after 50ms and writer wakes up 150 ms after that So the GP starts only 150ms
+ * later. To be safe, give a max of 400ms for the reader-section.
+ */
+#define RCU_READER_MAX_DELTA 400 // ms
+
+MODULE_LICENSE("GPL");
+
+struct sched_param {
+	int sched_priority;
+};
+
+int stop_test = 0;
+int test_pass = 1;
+int reader_exit = 0;
+s64 delta_fail;
+
+#define ns_to_ms(delta) (delta / 1000000ULL)
+
+static int rcu_writer(void *a)
+{
+	while (!kthread_should_stop() && !stop_test) {
+		trace_printk("starting gp\n");
+		synchronize_rcu();
+		trace_printk("ending gp\n");
+		msleep(10);
+	}
+
+	return 0;
+}
+
+static int rcu_reader(void *a)
+{
+	ktime_t start, end, reader_begin;
+	s64 delta;
+
+	reader_begin = ktime_get();
+
+	while (!kthread_should_stop() && !stop_test) {
+		rcu_read_lock();
+		trace_printk("rcu_reader entering RSCS\n");
+		start = ktime_get();
+		mdelay(RCU_READER_DELAY);
+		end = ktime_get();
+		trace_printk("rcu_reader exiting RSCS\n");
+		rcu_read_lock();
+		delta = ktime_to_ns(ktime_sub(end, start));
+
+		if (delta < 0 || (ns_to_ms(delta) > RCU_READER_MAX_DELTA)) {
+			delta_fail = delta;
+			test_pass = 0;
+			break;
+		}
+
+		// Don't let the rcu_reader() run more than 3s inorder to
+		// not starve the blocker incase reader prio > blocker prio.
+		delta = ktime_to_ns(ktime_sub(end, reader_begin));
+		if (ns_to_ms(delta) > 3000)
+			break;
+	}
+
+	stop_test = 1;
+	reader_exit = 1;
+	pr_err("Exiting reader\n");
+	return 0;
+}
+
+static int rcu_blocker(void *a)
+{
+	int loops = 5;
+
+	while (!kthread_should_stop() && loops-- && !stop_test) {
+		trace_printk("rcu_blocker entering\n");
+		mdelay(RCU_BLOCKER_DELAY);
+		trace_printk("rcu_blocker exiting\n");
+	}
+
+	pr_err("Exiting blocker\n");
+	stop_test = 1;
+
+	// Wait for reader to finish
+	while (!reader_exit)
+		schedule_timeout_uninterruptible(1);
+
+	if (test_pass)
+		pr_err("TEST PASSED\n");
+	else
+		pr_err("TEST FAILED, failing delta=%lldms\n", ns_to_ms(delta_fail));
+
+	return 0;
+}
+
+static int __init ptest_init(void){
+	struct sched_param params;
+	struct task_struct *reader, *blocker, *writer;
+
+	reader = kthread_create(rcu_reader, NULL, "reader");
+	params.sched_priority = 50;
+	sched_setscheduler(reader, SCHED_FIFO, &params);
+	kthread_bind(reader, smp_processor_id());
+
+	blocker = kthread_create(rcu_blocker, NULL, "blocker");
+	params.sched_priority = 60;
+	sched_setscheduler(blocker, SCHED_FIFO, &params);
+	kthread_bind(blocker, smp_processor_id());
+
+	writer = kthread_create(rcu_writer, NULL, "writer");
+	params.sched_priority = 70;
+	sched_setscheduler(writer, SCHED_FIFO, &params);
+	kthread_bind(writer, smp_processor_id());
+
+	wake_up_process(reader);
+
+	// Let reader run a little
+	mdelay(50);
+
+	wake_up_process(blocker);
+
+	// Let blocker run a little
+	mdelay(100);
+
+	wake_up_process(writer);
+	return 0;
+}
+
+static void __exit ptest_exit(void){
+}
+
+module_init(ptest_init);
+module_exit(ptest_exit);
-- 
2.25.0.341.g760bfbb309-goog

