Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD9C2BB85
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FFF2076D
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586972015;
	bh=15gYlNw04FVyZSj5Ko62CfL9r+JJcyc0eFb5yZQ+evg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IPKSD98T2WlT3wgfDCN1sxiQh2JwwqvG4r2ikW/sfnv6WGpiv1v0BeePrQXHOsQnX
	 iMP89s0cSzIQzOqCYgMDDrtvBOjN/INbSYQOHCRJkM3naSCOsxNm1LzV6GexTkST5b
	 dcz6FHIRsgGsLjcyPLprMbqb17UzksoOB/usuoZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411312AbgDORdZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:33:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411122AbgDORbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E058208FE;
        Wed, 15 Apr 2020 17:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971865;
        bh=15gYlNw04FVyZSj5Ko62CfL9r+JJcyc0eFb5yZQ+evg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1V51dcQgbMPMLiG4o9JDWpiEzAnsYtt83wa6ggg8Zgb9LydluFSK5rbhjuNWGTXUn
         UcRFwMehb+FpQ5IHGA1bVOkA7rkrmBzRBp381BMHK2p0EPrt73zxeO3ksG+kGcz4pr
         HEElPtO/6+Nh4/4P007KYAwfqWkEnZoj0Ao8lIzs=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 12/18] torture: Eliminate duplicate #CHECK# from ConfigFragment
Date:   Wed, 15 Apr 2020 10:30:54 -0700
Message-Id: <20200415173100.9927-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The #CHECK# directives that can be present in CFcommon and in the
rcutorture scenario Kconfig files are both copied to ConfigFragment
and grepped out of the two directive files and added to ConfigFragment.
This commit therefore removes the redundant "grep" commands and takes
advantage of the consequent opportunity to simplify redirection.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index e035230..74da059 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -44,19 +44,17 @@ then
 fi
 echo ' ---' `date`: Starting build
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
-touch $resdir/ConfigFragment.input $resdir/ConfigFragment
+touch $resdir/ConfigFragment.input
 if test -r "$config_dir/CFcommon"
 then
 	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
 	cat < $config_dir/CFcommon >> $resdir/ConfigFragment.input
 	config_override.sh $config_dir/CFcommon $config_template > $T/Kc1
-	grep '#CHECK#' $config_dir/CFcommon >> $resdir/ConfigFragment
 else
 	cp $config_template $T/Kc1
 fi
 echo " --- $config_template" >> $resdir/ConfigFragment.input
 cat $config_template >> $resdir/ConfigFragment.input
-grep '#CHECK#' $config_template >> $resdir/ConfigFragment
 if test -n "$TORTURE_KCONFIG_ARG"
 then
 	echo $TORTURE_KCONFIG_ARG | tr -s " " "\012" > $T/cmdline
@@ -67,7 +65,7 @@ then
 else
 	cp $T/Kc1 $T/Kc2
 fi
-cat $T/Kc2 >> $resdir/ConfigFragment
+cat $T/Kc2 > $resdir/ConfigFragment
 
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" -a -f $base_resdir/bzImage -a -f $base_resdir/vmlinux
-- 
2.9.5

