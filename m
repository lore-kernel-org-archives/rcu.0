Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE2EC433E2
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFCA20842
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872717;
	bh=p3AXeB+VOEIX1532PITIGWynvghXPAsUq+RRT6GbDv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBMmmzWt0dOQhjoopVJ7YplbXtlZ/qEve0DYPflZcmESLc2msTMdy1yhpl1/GDOqt
	 gfDLKQWVH0ffwKr61+si1LqJ1ep/ClrgS53WFXeyJkN8fZFOsSYe7EtsKDWqXJ9iky
	 PBq3120EUxcRL2rzbIHU0NMbT3qCjYJNfZmZmBKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbgFWAih (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbgFWAh5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A902137B;
        Tue, 23 Jun 2020 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872677;
        bh=p3AXeB+VOEIX1532PITIGWynvghXPAsUq+RRT6GbDv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCf3ywLixTvLSK63to03mfAKo3/FFbl6Y4zOmoaBW10blwxnmXgdQXVvrg47lp2SG
         qyP/Hpckp2dkriYdLNluw3pmvyl5UEDeHzy+X/CUYNzO9e73HP3FMcUJxfY/NTY9ri
         SJifybKJVc/VjGBqQpaCtTu9hOw0Xoiz47M1ehjE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/23] torture: Correctly summarize build-only runs
Date:   Mon, 22 Jun 2020 17:37:45 -0700
Message-Id: <20200623003752.26872-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, kvm-recheck.sh complains that qemu failed for --buildonly
runs, which is sort of true given that qemu can hardly succeed if not
invoked in the first place.  Nevertheless, this commit swaps the order
of checks in kvm-recheck.sh so that --buildonly runs will be summarized
more straightforwardly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 2261aa6..357899c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -56,15 +56,15 @@ do
 				cat $i/Warnings
 			fi
 		else
-			if test -f "$i/qemu-cmd"
-			then
-				print_bug qemu failed
-				echo "   $i"
-			elif test -f "$i/buildonly"
+			if test -f "$i/buildonly"
 			then
 				echo Build-only run, no boot/test
 				configcheck.sh $i/.config $i/ConfigFragment
 				parse-build.sh $i/Make.out $configfile
+			elif test -f "$i/qemu-cmd"
+			then
+				print_bug qemu failed
+				echo "   $i"
 			else
 				print_bug Build failed
 				echo "   $i"
-- 
2.9.5

