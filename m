Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EE0C7EE32
	for <rcu@archiver.kernel.org>; Fri,  3 Mar 2023 21:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjCCVjN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Mar 2023 16:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjCCVjH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Mar 2023 16:39:07 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D874C13
        for <rcu@vger.kernel.org>; Fri,  3 Mar 2023 13:39:01 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d7so4440836qtr.12
        for <rcu@vger.kernel.org>; Fri, 03 Mar 2023 13:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677879540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZBqbWgHugu/GnRzpPvn7DxcaGfZfuTK+s2+Sb3Qrso=;
        b=KJnNlffsNi4iZcHyTuaZmINvsu5p9H7urMKDMssRreAhc14lEW0TN47RGQF1RCsR6A
         SgthzzHEJQAQ+UP4PAxpLOBAanKA/M3TOspp47ppymmUO2Jc5QGfN+LrK2AZenMd3ZL6
         XiW5cnWyyti4FjQYeCnuNr6Qrc/mGTesaalKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677879540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZBqbWgHugu/GnRzpPvn7DxcaGfZfuTK+s2+Sb3Qrso=;
        b=mZaxwfGTLxCKLOlPG1vJW6kc1zACzKtaeTtkUQc83RoZG6XE6145B5yk8AGZNdxDVz
         SP3dxHhDiYeXIXveXipHR8sLl/f9UHWydW3QEurnyHKwpqMBJ4pBxcZI9Z4D7kELZzct
         rPkNWAt9Z2LsMUqD5Wy81arAghiKIUH521prSM1dC2OW2QQtiZGuASbqOPsNik34TNAG
         ihvvIkyCL9xEqPKpN1O4HQWQVUVdl/GAXIY/A78zw3Uw2OSIZFadCZd5IHZbA2wTrrdv
         ViLaPKi4YS+WkVBBPJIDxL8dq3/7b9pF03JbK0Sly+sENqcmu25aQFBltvnmWV8AKGQM
         3Zlw==
X-Gm-Message-State: AO0yUKV7ti2UDW0OLeacxKnV1+Wit9zYGuAdNqZGyNTW6uhqJUyIpK2z
        Z8amRUvl0MFpdIXDyVE/KUvtkQ==
X-Google-Smtp-Source: AK7set+lAlUBF6IdgCqlHt4jaKJ6KnckJv2Ds+chLo812O6QY6I0q+16QLcS6j8Qmu55VufmZS0I8A==
X-Received: by 2002:a05:622a:102:b0:3bd:11a5:c114 with SMTP id u2-20020a05622a010200b003bd11a5c114mr5034392qtw.63.1677879540077;
        Fri, 03 Mar 2023 13:39:00 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f9-20020ac840c9000000b003b869f71eedsm2449737qtm.66.2023.03.03.13.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:38:59 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, urezki@gmail.com
Subject: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Date:   Fri,  3 Mar 2023 21:38:51 +0000
Message-Id: <20230303213851.2090365-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On many systems, a great deal of boot (in userspace) happens after the
kernel thinks the boot has completed. It is difficult to determine if
the system has really booted from the kernel side. Some features like
lazy-RCU can risk slowing down boot time if, say, a callback has been
added that the boot synchronously depends on. Further expedited callbacks
can get unexpedited way earlier than it should be, thus slowing down
boot (as shown in the data below).

For these reasons, this commit adds a config option
'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter rcupdate.boot_end_delay.
Userspace can also make RCU's view of the system as booted, by writing the
time in milliseconds to: /sys/module/rcupdate/parameters/rcu_boot_end_delay
Or even just writing a value of 0 to this sysfs node.
However, under no circumstance will the boot be allowed to end earlier
than just before init is launched.

The default value of CONFIG_RCU_BOOT_END_DELAY is chosen as 15s. This
suites ChromeOS and also a PREEMPT_RT system below very well, which need
no config or parameter changes, and just a simple application of this patch. A
system designer can also choose a specific value here to keep RCU from marking
boot completion.  As noted earlier, RCU's perspective of the system as booted
will not be marker until at least rcu_boot_end_delay milliseconds have passed
or an update is made via writing a small value (or 0) in milliseconds to:
/sys/module/rcupdate/parameters/rcu_boot_end_delay.

One side-effect of this patch is, there is a risk that a real-time workload
launched just after the kernel boots will suffer interruptions due to expedited
RCU, which previous ended just before init was launched. However, to mitigate
such an issue (however unlikely), the user should either tune
CONFIG_RCU_BOOT_END_DELAY to a smaller value than 15 seconds or write a value
of 0 to /sys/module/rcupdate/parameters/rcu_boot_end_delay, once userspace
boots, and before launching the real-time workload.

Qiuxu also noted impressive boot-time improvements with earlier version
of patch. An excerpt from the data he shared:

1) Testing environment:
    OS            : CentOS Stream 8 (non-RT OS)
    Kernel     : v6.2
    Machine : Intel Cascade Lake server (2 sockets, each with 44 logical threads)
    Qemu  args  : -cpu host -enable-kvm, -smp 88,threads=2,sockets=2, …

2) OS boot time definition:
    The time from the start of the kernel boot to the shell command line
    prompt is shown from the console. [ Different people may have
    different OS boot time definitions. ]

3) Measurement method (very rough method):
    A timer in the kernel periodically prints the boot time every 100ms.
    As soon as the shell command line prompt is shown from the console,
    we record the boot time printed by the timer, then the printed boot
    time is the OS boot time.

4) Measured OS boot time (in seconds)
   a) Measured 10 times w/o this patch:
        8.7s, 8.4s, 8.6s, 8.2s, 9.0s, 8.7s, 8.8s, 9.3s, 8.8s, 8.3s
        The average OS boot time was: ~8.7s

   b) Measure 10 times w/ this patch:
        8.5s, 8.2s, 7.6s, 8.2s, 8.7s, 8.2s, 7.8s, 8.2s, 9.3s, 8.4s
        The average OS boot time was: ~8.3s.

Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2:
	Update some comments and description.
v2->v3:
        Add sysfs param, and update with Test data.

 .../admin-guide/kernel-parameters.txt         | 12 ++++
 cc_list                                       |  8 +++
 kernel/rcu/Kconfig                            | 19 ++++++
 kernel/rcu/update.c                           | 68 ++++++++++++++++++-
 4 files changed, 106 insertions(+), 1 deletion(-)
 create mode 100644 cc_list

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2429b5e3184b..611de90d9c13 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5085,6 +5085,18 @@
 	rcutorture.verbose= [KNL]
 			Enable additional printk() statements.
 
+	rcupdate.rcu_boot_end_delay= [KNL]
+			Minimum time in milliseconds that must elapse
+			before the boot sequence can be marked complete
+			from RCU's perspective, after which RCU's behavior
+			becomes more relaxed. The default value is also
+			configurable via CONFIG_RCU_BOOT_END_DELAY.
+			Userspace can also mark the boot as completed
+			sooner by writing the time in milliseconds, say once
+			userspace considers the system as booted, to:
+			/sys/module/rcupdate/parameters/rcu_boot_end_delay
+			Or even just writing a value of 0 to this sysfs node.
+
 	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
 			Dump ftrace buffer after reporting RCU CPU
 			stall warning.
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 9071182b1284..4b5ffa36cbaf 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -217,6 +217,25 @@ config RCU_BOOST_DELAY
 
 	  Accept the default if unsure.
 
+config RCU_BOOT_END_DELAY
+	int "Minimum time before RCU may consider in-kernel boot as completed"
+	range 0 120000
+	default 15000
+	help
+	  Default value of the minimum time in milliseconds that must elapse
+	  before the boot sequence can be marked complete from RCU's perspective,
+	  after which RCU's behavior becomes more relaxed.
+	  Userspace can also mark the boot as completed sooner than this default
+	  by writing the time in milliseconds, say once userspace considers
+	  the system as booted, to: /sys/module/rcupdate/parameters/rcu_boot_end_delay.
+	  Or even just writing a value of 0 to this sysfs node.
+
+	  The actual delay for RCU's view of the system to be marked as booted can be
+	  higher than this value if the kernel takes a long time to initialize but it
+	  will never be smaller than this value.
+
+	  Accept the default if unsure.
+
 config RCU_EXP_KTHREAD
 	bool "Perform RCU expedited work in a real-time kthread"
 	depends on RCU_BOOST && RCU_EXPERT
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 19bf6fa3ee6a..93138c92136e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -224,18 +224,84 @@ void rcu_unexpedite_gp(void)
 }
 EXPORT_SYMBOL_GPL(rcu_unexpedite_gp);
 
+/*
+ * Minimum time in milliseconds until RCU can consider in-kernel boot as
+ * completed.  This can also be tuned at runtime to end the boot earlier, by
+ * userspace init code writing the time in milliseconds (even 0) to:
+ * /sys/module/rcupdate/parameters/rcu_boot_end_delay
+ */
+static int rcu_boot_end_delay = CONFIG_RCU_BOOT_END_DELAY;
+
 static bool rcu_boot_ended __read_mostly;
+static bool rcu_boot_end_called __read_mostly;
+static DEFINE_MUTEX(rcu_boot_end_lock);
+
+static int param_set_rcu_boot_end(const char *val, const struct kernel_param *kp)
+{
+	uint end_ms;
+	int ret = kstrtouint(val, 0, &end_ms);
+
+	if (ret)
+		return ret;
+	WRITE_ONCE(*(uint *)kp->arg, end_ms);
+
+	/*
+	 * rcu_end_inkernel_boot() should be called at least once during init
+	 * before we can allow param changes to end the boot.
+	 */
+	mutex_lock(&rcu_boot_end_lock);
+	rcu_boot_end_delay = end_ms;
+	if (!rcu_boot_ended && rcu_boot_end_called) {
+		mutex_unlock(&rcu_boot_end_lock);
+		rcu_end_inkernel_boot();
+	}
+	mutex_unlock(&rcu_boot_end_lock);
+	return ret;
+}
+
+static const struct kernel_param_ops rcu_boot_end_ops = {
+	.set = param_set_rcu_boot_end,
+	.get = param_get_uint,
+};
+module_param_cb(rcu_boot_end_delay, &rcu_boot_end_ops, &rcu_boot_end_delay, 0644);
 
 /*
- * Inform RCU of the end of the in-kernel boot sequence.
+ * Inform RCU of the end of the in-kernel boot sequence. The boot sequence will
+ * not be marked ended until at least rcu_boot_end_delay milliseconds have passed.
  */
+void rcu_end_inkernel_boot(void);
+static void rcu_boot_end_work_fn(struct work_struct *work)
+{
+	rcu_end_inkernel_boot();
+}
+static DECLARE_DELAYED_WORK(rcu_boot_end_work, rcu_boot_end_work_fn);
+
 void rcu_end_inkernel_boot(void)
 {
+	mutex_lock(&rcu_boot_end_lock);
+	rcu_boot_end_called = true;
+
+	if (rcu_boot_ended)
+		return;
+
+	if (rcu_boot_end_delay) {
+		u64 boot_ms = div_u64(ktime_get_boot_fast_ns(), 1000000UL);
+
+		if (boot_ms < rcu_boot_end_delay) {
+			schedule_delayed_work(&rcu_boot_end_work,
+					rcu_boot_end_delay - boot_ms);
+			mutex_unlock(&rcu_boot_end_lock);
+			return;
+		}
+	}
+
+	cancel_delayed_work(&rcu_boot_end_work);
 	rcu_unexpedite_gp();
 	rcu_async_relax();
 	if (rcu_normal_after_boot)
 		WRITE_ONCE(rcu_normal, 1);
 	rcu_boot_ended = true;
+	mutex_unlock(&rcu_boot_end_lock);
 }
 
 /*
-- 
2.40.0.rc0.216.gc4246ad0f0-goog
