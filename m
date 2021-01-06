Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415C7C4332B
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C9902312C
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbhAFR1A (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:27:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:36138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbhAFR0u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA84223136;
        Wed,  6 Jan 2021 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953970;
        bh=NYBaTTovHcgJwtB96ur1N2LJBLR8KSPZ/3VA85S4Kjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxNtS+RhFk0JFoHMIzlLHRD16jGRx21dR6FL+rNiAtqgb1wqat+4l1STj5IQqQ0eS
         5ueJPxiIIjk5BdMKXKKGCrecsDWHWR99TctaNDDxF6i0OvVkI/DQ7MDeg5kB+ACxkR
         E3muxN6aujV7Bp5MtwWFok71t3HYf6fNuoxbygyCITwuKCNVr7dfcoeSGrVFbleCwj
         fywRjicVBZFvkRbf2U7hOS7nF2kSTe5d/Kr1JZ+wOZRmIgnPusv+1dU4X8oZtN94E6
         t/CvBOCpPOo/VKXW/Y16auRVtievt2/NJ03wDnAPlZNMng/g61kHEtQYXkU4Un65za
         upuUdCHwIQY9Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 04/20] torture: Allow kvm.sh --datestamp to specify subdirectories
Date:   Wed,  6 Jan 2021 09:25:51 -0800
Message-Id: <20210106172607.22816-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Scripts like kvm-check-branches.sh group runs under a single directory
in resdir in order to allow easier retrospective analysis.  However, they
do this by letting kvm.sh create a directory as usual and then moving it
after the run.  This can be very confusing when looking at the results
while kvm-check-branches.sh is running.  This commit therefore enables
--datestamp to hand subdirectories to kvm.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 55a18a9..0a9211a 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -113,7 +113,7 @@ do
 		shift
 		;;
 	--datestamp)
-		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[^/]*$' '^--'
+		checkarg --datestamp "(relative pathname)" "$#" "$2" '^[a-zA-Z0-9._-/]*$' '^--'
 		ds=$2
 		shift
 		;;
@@ -375,7 +375,7 @@ if ! test -e $resdir
 then
 	mkdir -p "$resdir" || :
 fi
-mkdir $resdir/$ds
+mkdir -p $resdir/$ds
 TORTURE_RESDIR="$resdir/$ds"; export TORTURE_RESDIR
 TORTURE_STOPFILE="$resdir/$ds/STOP"; export TORTURE_STOPFILE
 echo Results directory: $resdir/$ds
-- 
2.9.5

