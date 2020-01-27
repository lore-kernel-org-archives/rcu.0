Return-Path: <SRS0=q3PZ=3Q=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50346C2D0DB
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 14:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22559214D8
	for <rcu@archiver.kernel.org>; Mon, 27 Jan 2020 14:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="hx8zSgYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgA0ODs (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:03:48 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:52422 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726303AbgA0ODr (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 27 Jan 2020 09:03:47 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 6BF4A2E0EDF;
        Mon, 27 Jan 2020 17:03:43 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id G2o98yfOOm-3fOqsLr4;
        Mon, 27 Jan 2020 17:03:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580133823; bh=KKTEWvBENBmKulqkjptnI+eIc8uLsBTs0/9Pgf0qjCc=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=hx8zSgYxJsO2QVCMNSJc6nZ17mU0vz0kus7DVPLIbWpyQ7fLRG7AUIbCb/4UEFuvZ
         KG0fSsdGmey0nwYaa7srVvJ6C2rJ1wZpKKZOHyjvPQ9YgY+r1e6fSDpWd6Wl3FDl5E
         5axHSd/+RoOA8m9aNWJutELNRoeQQbut1ZR3Yq1Y=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id mmmAlesbL8-3eWqn46v;
        Mon, 27 Jan 2020 17:03:40 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 1/3] kernel: rename taint flag TAINT_SOFTLOCKUP into
 TAINT_LOCKUP
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Mon, 27 Jan 2020 17:03:40 +0300
Message-ID: <158013382063.1528.13355932625960922673.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Any lockup or stall detector notifies about unexpected lack of progress.
It's better to know about these splats at investigating further problems.

Right now only softlockup watchdog leaves own taint flag.
Let's generalize it and set at any kind of detected lockup.

This patch removes 'soft' from its name and descriptions.
User visible letter stays the same: 'L'.

Next patch wires TAINT_LOCKUP into other kinds of lockup detectors.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Link: https://lore.kernel.org/lkml/157503370645.8187.6335564487789994134.stgit@buzz/ (v1)
---
 Documentation/admin-guide/sysctl/kernel.rst   |    2 +-
 Documentation/admin-guide/tainted-kernels.rst |    4 ++--
 include/linux/kernel.h                        |    2 +-
 kernel/panic.c                                |    2 +-
 kernel/watchdog.c                             |    2 +-
 tools/debugging/kernel-chktaint               |    2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee..8456c8ed0ca5 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1084,7 +1084,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
   2048  `(I)`  workaround for bug in platform firmware applied
   4096  `(O)`  externally-built ("out-of-tree") module was loaded
   8192  `(E)`  unsigned module was loaded
- 16384  `(L)`  soft lockup occurred
+ 16384  `(L)`  lockup occurred
  32768  `(K)`  kernel has been live patched
  65536  `(X)`  Auxiliary taint, defined and used by for distros
 131072  `(T)`  The kernel was built with the struct randomization plugin
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 71e9184a9079..55d45211cb41 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -96,7 +96,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  11  _/I    2048  workaround for bug in platform firmware applied
  12  _/O    4096  externally-built ("out-of-tree") module was loaded
  13  _/E    8192  unsigned module was loaded
- 14  _/L   16384  soft lockup occurred
+ 14  _/L   16384  lockup occurred
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
@@ -152,7 +152,7 @@ More detailed explanation for tainting
  13) ``E`` if an unsigned module has been loaded in a kernel supporting
      module signature.
 
- 14) ``L`` if a soft lockup has previously occurred on the system.
+ 14) ``L`` if a lockup has previously occurred on the system.
 
  15) ``K`` if the kernel has been live patched.
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d9db2a14f44..3554456b2d40 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -584,7 +584,7 @@ extern enum system_states {
 #define TAINT_FIRMWARE_WORKAROUND	11
 #define TAINT_OOT_MODULE		12
 #define TAINT_UNSIGNED_MODULE		13
-#define TAINT_SOFTLOCKUP		14
+#define TAINT_LOCKUP			14
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..a0ea0c6992b9 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -372,7 +372,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_FIRMWARE_WORKAROUND ]	= { 'I', ' ', false },
 	[ TAINT_OOT_MODULE ]		= { 'O', ' ', true },
 	[ TAINT_UNSIGNED_MODULE ]	= { 'E', ' ', true },
-	[ TAINT_SOFTLOCKUP ]		= { 'L', ' ', false },
+	[ TAINT_LOCKUP ]		= { 'L', ' ', false },
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334ef0971..d60b195708f7 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -466,7 +466,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			smp_mb__after_atomic();
 		}
 
-		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
+		add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
 		__this_cpu_write(soft_watchdog_warn, true);
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 2240cb56e6e5..9f24719d8c80 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -168,7 +168,7 @@ if [ `expr $T % 2` -eq 0 ]; then
 	addout " "
 else
 	addout "L"
-	echo " * soft lockup occurred (#14)"
+	echo " * lockup occurred (#14)"
 fi
 
 T=`expr $T / 2`

