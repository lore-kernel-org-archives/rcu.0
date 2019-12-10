Return-Path: <SRS0=BMES=2A=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8445CC2D0B1
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527F621556
	for <rcu@archiver.kernel.org>; Tue, 10 Dec 2019 03:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575949345;
	bh=FYSuXrBnGcX5rNJrafNsBGF9FbKeaRXFZRr6RrKW6t4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UfrgERgKUB+OPEd1W2/yYBKGFGn5IuWVezxDT32n6m0N5r7e/s8ejVQ6IF/3HERoh
	 6p+ljaN/8bS2D7EOXFnAgCFONL3PvaVDoACKLzwMo2G3xZ4ETL/qdCLl7sYZzmyZsJ
	 KT2afMr+UjYUx3Zeoo7E9z5yaUpEzvU7f1lrLUfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfLJDmY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:42:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:60854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbfLJDmY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Dec 2019 22:42:24 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 372AF207FF;
        Tue, 10 Dec 2019 03:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575949343;
        bh=FYSuXrBnGcX5rNJrafNsBGF9FbKeaRXFZRr6RrKW6t4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cw663crx5NaY+PzwY4MC7sz+s5ZFgWfb/RAMWZEtGNCNgBWctYSdONb52Ez50n07q
         xkloszOeP00Lb22Uw4PzXOtuvX+B3q31kk/NcwDA1pniB81UoA0CAe12+13FA75DDs
         ai0yNqSRwr4BQveebCbXX/5rH3JujGAG9YYsQ2f0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/12] rcutorture: Add worst-case call_rcu() forward-progress results
Date:   Mon,  9 Dec 2019 19:42:10 -0800
Message-Id: <20191210034217.405-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210034119.GA32711@paulmck-ThinkPad-P72>
References: <20191210034119.GA32711@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds the worst-case results from any call_rcu()
forward-progress tests to the rcutorture test-summary output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 2a7f3f4..9d9a416 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -25,6 +25,7 @@ stopstate="`grep 'End-test grace-period state: g' $i/console.log 2> /dev/null |
 	    tail -1 | sed -e 's/^\[[ 0-9.]*] //' |
 	    awk '{ print \"[\" $1 \" \" $5 \" \" $6 \" \" $7 \"]\"; }' |
 	    tr -d '\012\015'`"
+fwdprog="`grep 'rcu_torture_fwd_prog_cr Duration' $i/console.log 2> /dev/null | sed -e 's/^\[[^]]*] //' | sort -k15nr | head -1 | awk '{ print $14 " " $15 }'`"
 if test -z "$ngps"
 then
 	echo "$configfile ------- " $stopstate
@@ -39,7 +40,7 @@ else
 			BEGIN { print ngps / dur }' < /dev/null`
 		title="$title ($ngpsps/s)"
 	fi
-	echo $title $stopstate
+	echo $title $stopstate $fwdprog
 	nclosecalls=`grep --binary-files=text 'torture: Reader Batch' $i/console.log | tail -1 | awk '{for (i=NF-8;i<=NF;i++) sum+=$i; } END {print sum}'`
 	if test -z "$nclosecalls"
 	then
-- 
2.9.5

