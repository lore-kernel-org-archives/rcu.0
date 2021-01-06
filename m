Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C426C43331
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A2A23120
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 17:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAFR0u (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 12:26:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbhAFR0u (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 12:26:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E94A2312F;
        Wed,  6 Jan 2021 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953969;
        bh=TpV1KvTwFO6/AZQxpu2Jh2lB2uw/usMegny02ip9HFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XC2W/DskWX/0illWERG92jhfMlNmj55Ll3seGGjdDTxGtCZvyt1R5n+BxRa3ap59C
         AMpz7FAIzGBZ8sac7meyTPJUUcEy1jirwTwMPz/dBJuhrE2CxbWHpJO1vfVtp2ZJcN
         8aGUZjRQk3ypQZDB/EMWl6qLnKq3nSorzYvhL1hhSYnQvQQLdexW724k8ubGDLH3zt
         QmU48KSlHD992Neu5/Dld9CXnh9ib7BFIQrYHYNdOW/yXgrEuPJGKox3qu2WhYTg6k
         lqgVQQzaGnB8KFX1nwiZY19J++0ZJ9EjbQBW9DvX0UFJBZEo502Jebs8nPqY1RM1mg
         oX6cIuIKQmS1Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/20] torture: Make kvm.sh "--dryrun sched" summarize number of batches
Date:   Wed,  6 Jan 2021 09:25:49 -0800
Message-Id: <20210106172607.22816-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Knowing the number of batches that kvm.sh will split a run into allows
estimation of the duration of a test, give or take the number of builds.
This commit therefore adds a line of output to "--dryrun sched" that
gives the number of batches that will be run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index bd07df7..1078be1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -536,6 +536,8 @@ then
 	egrep 'Start batch|Starting build\.' $T/script |
 		grep -v ">>" |
 		sed -e 's/:.*$//' -e 's/^echo //'
+	nbatches="`grep 'Start batch' $T/script | grep -v ">>" | wc -l`"
+	echo Total number of batches: $nbatches
 	exit 0
 else
 	# Not a dryrun, so run the script.
-- 
2.9.5

