Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D07C43217
	for <rcu@archiver.kernel.org>; Tue, 19 Apr 2022 00:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiDSAKi (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 18 Apr 2022 20:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbiDSAKe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 18 Apr 2022 20:10:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2456146;
        Mon, 18 Apr 2022 17:07:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8447B81123;
        Tue, 19 Apr 2022 00:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749CFC385AD;
        Tue, 19 Apr 2022 00:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326869;
        bh=DTyMhxWth7RqAgPi1iypc1zMc6X4txtA5mNp5ZnXW0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uch6D45tphaUYJEhFZ/9zQZIHDFs9/IWjA7ZiZvJbiN30ct9qpCv7JNCFsxyVhQ7c
         f+B/9iKtRf8oE9CR6lCzDWB0omUhc5+kUoPakjImJ6xsYxlBXaqe+MZlJfMWaqABKD
         Q96XHRF5vLojpMrq3olY+Yaa8/mf5WnX8AZ0dOkTcFpzlSZkPzvnBuluqmBblGONL+
         CgY6T4/SiQqc+IJ5NLOQ5B9Gmezz8LE0h1bzFniIWb+s6BnAK611lkh0qjvYPWFDzn
         ejpP5Aypt2SIa+QgfGZ213eRnfJ3vJ7ARCMQaAqsuD5j4Tt++2ZcHy/J0e/04E60dm
         oqJlApUa1qcSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 20D395C04BD; Mon, 18 Apr 2022 17:07:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/6] torture: Add rcu_normal and rcu_expedited runs to torture.sh
Date:   Mon, 18 Apr 2022 17:07:41 -0700
Message-Id: <20220419000746.3949667-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000541.GA3949109@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Currently, the rcupdate.rcu_normal and rcupdate.rcu_expedited kernel
boot parameters are not regularly tested.  The potential addition of
polled expedited grace-period APIs increases the amount of code that is
affected by these kernel boot parameters.  This commit therefore adds a
"--do-rt" argument to torture.sh to exercise these kernel-boot options.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/torture.sh        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index bfe09e2829c8..e657a6e06417 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -54,6 +54,7 @@ do_kvfree=yes
 do_kasan=yes
 do_kcsan=no
 do_clocksourcewd=yes
+do_rt=yes
 
 # doyesno - Helper function for yes/no arguments
 function doyesno () {
@@ -82,6 +83,7 @@ usage () {
 	echo "       --do-rcuscale / --do-no-rcuscale"
 	echo "       --do-rcutorture / --do-no-rcutorture"
 	echo "       --do-refscale / --do-no-refscale"
+	echo "       --do-rt / --do-no-rt"
 	echo "       --do-scftorture / --do-no-scftorture"
 	echo "       --duration [ <minutes> | <hours>h | <days>d ]"
 	echo "       --kcsan-kmake-arg kernel-make-arguments"
@@ -118,6 +120,7 @@ do
 		do_scftorture=yes
 		do_rcuscale=yes
 		do_refscale=yes
+		do_rt=yes
 		do_kvfree=yes
 		do_kasan=yes
 		do_kcsan=yes
@@ -148,6 +151,7 @@ do
 		do_scftorture=no
 		do_rcuscale=no
 		do_refscale=no
+		do_rt=no
 		do_kvfree=no
 		do_kasan=no
 		do_kcsan=no
@@ -162,6 +166,9 @@ do
 	--do-refscale|--do-no-refscale)
 		do_refscale=`doyesno "$1" --do-refscale`
 		;;
+	--do-rt|--do-no-rt)
+		do_rt=`doyesno "$1" --do-rt`
+		;;
 	--do-scftorture|--do-no-scftorture)
 		do_scftorture=`doyesno "$1" --do-scftorture`
 		;;
@@ -354,6 +361,17 @@ then
 	torture_set "scftorture" tools/testing/selftests/rcutorture/bin/kvm.sh --torture scf --allcpus --duration "$duration_scftorture" --configs "$configs_scftorture" --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 1G --trust-make
 fi
 
+if test "$do_rt" = "yes"
+then
+	# With all post-boot grace periods forced to normal.
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_normal=1"
+	torture_set "rcurttorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+
+	# With all post-boot grace periods forced to expedited.
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcupdate.rcu_expedited=1"
+	torture_set "rcurttorture-exp" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration "$duration_rcutorture" --configs "TREE03" --trust-make
+fi
+
 if test "$do_refscale" = yes
 then
 	primlist="`grep '\.name[ 	]*=' kernel/rcu/refscale.c | sed -e 's/^[^"]*"//' -e 's/".*$//'`"
-- 
2.31.1.189.g2e36527f23

