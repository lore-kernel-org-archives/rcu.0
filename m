Return-Path: <SRS0=Avjt=AE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069AEC433E1
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D86642075A
	for <rcu@archiver.kernel.org>; Tue, 23 Jun 2020 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872754;
	bh=KJkwD6p1qCSl7EBe3fI9NMkvfieRs25n+b49quf8hic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DUyaQDk2B6or2/uzjpI1gs+NfaQ82tVnKT4uGfU/54oep1hkiyq5ePuq1sFG6WufL
	 AeKbFN6Kc+ALl2v9vxnB2f/HYKFVRnWOPQSDA9eEOEoydN7zudTER+2oW0iVwtvARq
	 VYzTpF8KNKNjVDSB/GTzTmoW6KJormL/VEM8G6e0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbgFWAjO (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731745AbgFWAhz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EFB208DB;
        Tue, 23 Jun 2020 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872675;
        bh=KJkwD6p1qCSl7EBe3fI9NMkvfieRs25n+b49quf8hic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OgSg/ZDKkEz4CkK4cNt9G8n3aO+wk4kFztAS0Wj2ax645TzFBxvDIYz2HAJuUVheO
         RE0hkCvlen3xw0UjCzfOWrZdoM0pc4O27vRmqcXmNNnQ1faVklhoBad24uNg/5yxsr
         zj2tbBoCPa5mYtIkADGVGlp/wCHiV0fBKNgpYFhY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 05/23] torture: Set configfile variable to current scenario
Date:   Mon, 22 Jun 2020 17:37:34 -0700
Message-Id: <20200623003752.26872-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The torture-test recheck logic fails to set the configfile variable to
the current scenario, so this commit properly initializes this variable.
This change isn't critical given that all errors for a given scenario
follow that scenario's heading, but it is easier on the eyes to repeat it.
And this repetition also prevents confusion as to whether a given message
goes with the previous heading or the next one.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 736f047..2261aa6 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -31,6 +31,7 @@ do
 			head -1 $resdir/log
 		fi
 		TORTURE_SUITE="`cat $i/../TORTURE_SUITE`"
+		configfile=`echo $i | sed -e 's,^.*/,,'`
 		rm -f $i/console.log.*.diags
 		kvm-recheck-${TORTURE_SUITE}.sh $i
 		if test -f "$i/qemu-retval" && test "`cat $i/qemu-retval`" -ne 0 && test "`cat $i/qemu-retval`" -ne 137
-- 
2.9.5

