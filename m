Return-Path: <SRS0=lUfD=3G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2503BC33C9E
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 21:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEE52192A
	for <rcu@archiver.kernel.org>; Fri, 17 Jan 2020 21:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f+ZN3T8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAQV6R (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:58:17 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42506 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgAQV6R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 16:58:17 -0500
Received: by mail-pl1-f182.google.com with SMTP id p9so10385090plk.9
        for <rcu@vger.kernel.org>; Fri, 17 Jan 2020 13:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4pwxRMfHKkvfUuxj0Wv6Q0iTZH7NE9H4fcYmmHdrFlk=;
        b=f+ZN3T8t6Ksm2PEnT2ycl56ygQ5lYrUzekmZLhfYXjqXqBiKb1Btge0IJLEcNhYaLY
         ES01/6kTEym5JdpxiMMehe7rpVj+zldQse8ul4odtgyduiQYFMMy3Gl+qKw3eMv+1wUQ
         4T7rW9TcIahnoTexY/md2BfsdY1XxtoQBl/TQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4pwxRMfHKkvfUuxj0Wv6Q0iTZH7NE9H4fcYmmHdrFlk=;
        b=ajoD2OmyoCbHLuEOevxjxPDVNX+tPkH/yvhpUPaNzl35dgNbuqdy16zbWd3k/iKyfP
         6TTJQGGvm18ZY5NfW7VN3HHa+vtX/QwA9P3xxe8dpRWEW8bx2jgz5Qo59LiICYHdjxZS
         Pdw0xVsooW0WuLTEWfrvlQw0fLgSeYqFWjoQKdnedbt6MRNwsVF/bH+5J4Q9aa7SPlKL
         LXhgfEiTwFW0mqxpBGFAHFENwryR5c9N3kj6HVZLFiwCFxOKh+hSiA40o6lpC/eF2EDO
         QyPHio+irjnVZOiGNv4A0H2uz1pGM6rnT59o+X8/5juhd9FkV5uKj3tIpQ85lgHm8F7w
         AZ+g==
X-Gm-Message-State: APjAAAXLJz/zh9ZRH8iHQX29nM+ty/E7a2ULee5xhs82nqIbhWPbPAz6
        EXEpa7GT45QP3Go1FbXwzsyDOrZRHVQ=
X-Google-Smtp-Source: APXvYqyE5bgLMq1KYOSAsrBKITIr2g84DlTArm1vVxVEN0Q3HtjzbYjPGk+KKpZ1DMQYEyj5MnORiw==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr1328673plp.252.1579298296473;
        Fri, 17 Jan 2020 13:58:16 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r8sm6121901pjo.22.2020.01.17.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:58:15 -0800 (PST)
Date:   Fri, 17 Jan 2020 16:58:14 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org, paulmck@kernel.org, rostedt@goodmis.org,
        bristot@redhat.com
Subject: RCU_BOOST not working for me
Message-ID: <20200117215814.GB206250@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
Me and Daniel were poking around with RCU_BOOST. I wrote a kernel module to
test it a bit and I don't see the boost happening (thanks to Daniel for idea
of writing a module). Haven't debugged it more yet. Will look more tomorrow.
But below is the kernel module code and it prints a FAIL message to kernel
logs in a few seconds.

I see the reader thread not getting CPU for several seconds. RCU_BOOST_DELAY
is set to 500.

Thoughts?

---8<-----------------------

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
index 000000000000..76cc9524ccac
--- /dev/null
+++ b/drivers/misc/ptest.c
@@ -0,0 +1,112 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+
+#define RCU_READER_DELAY 100 //ms
+#define RCU_BLOCKER_DELAY 600 //ms
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
+static int rcu_reader(void *a)
+{
+	ktime_t start, end, reader_begin;
+	s64 delta;
+
+	reader_begin = ktime_get();
+
+	while (!kthread_should_stop() && !stop_test) {
+		start = ktime_get();
+		rcu_read_lock();
+		trace_printk("rcu_reader entering RSCS\n");
+		mdelay(RCU_READER_DELAY);
+		trace_printk("rcu_reader exiting RSCS\n");
+		rcu_read_lock();
+		end = ktime_get();
+		delta = ktime_to_ns(ktime_sub(end, start));
+
+		if (delta < 0 || (ns_to_ms(delta) > (2 * RCU_READER_DELAY))) {
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
+	struct task_struct *reader, *blocker;
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
+	wake_up_process(reader);
+
+	// Let reader run a little
+	mdelay(50);
+
+	wake_up_process(blocker);
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

