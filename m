Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA1CC55178
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCF72073A
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620096;
	bh=lLGfA2SCpZe6xMhECsAnbj+bQlSrzmGYITVjdGbCa7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C690GhGvO3ITFhsL0MQvjPyQI7olO4ATGWtTudMrfNCHG0RgVZwpw65IOkcCKLpTF
	 xiBp2bnK1q8zHEfJWXVvUrOTwRzW/vw28eBxkOrVNcsatA47iOQA9xvpIBx1qXb6Kx
	 qjomIb6YW7Q2pygxY1EYERIvMlEH+b8YmLc0pK1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbgKEXrd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732814AbgKEXrc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:32 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E70972224F;
        Thu,  5 Nov 2020 23:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620052;
        bh=lLGfA2SCpZe6xMhECsAnbj+bQlSrzmGYITVjdGbCa7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qx5JFlxQjKr7Tn1BV/i+myy/BZ5YdFT5k5u3mZtv2BLm4NNQh7xNR30tMglHBW7Px
         /W0tTnHBZnSJPeGOJiDLeK9ov5U+Lw1O6R8mxEhBOIv5VgaaxEIiY2gChwGDjgHK+D
         4uyrWFgt58ulIodqqf0GEMp/Ekz9897EXr3W6LuA=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 28/28] tools/rcutorture: Fix BUG parsing of console.log
Date:   Thu,  5 Nov 2020 15:47:19 -0800
Message-Id: <20201105234719.23307-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

For the rcutorture test summary log file console.log of virtual machines is
parsed. When a console.log contains "DEBUG", BUG counter is incremented
because regular expression does not handle to ignore DEBUG.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/parse-console.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index e033380..263b1be 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -133,7 +133,7 @@ then
 	then
 		summary="$summary  Warnings: $n_warn"
 	fi
-	n_bugs=`egrep -c 'BUG|Oops:' $file`
+	n_bugs=`egrep -c '\bBUG|Oops:' $file`
 	if test "$n_bugs" -ne 0
 	then
 		summary="$summary  Bugs: $n_bugs"
-- 
2.9.5

