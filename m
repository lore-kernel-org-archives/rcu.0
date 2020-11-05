Return-Path: <SRS0=5ltB=EL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2570FC55178
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D4720756
	for <rcu@archiver.kernel.org>; Thu,  5 Nov 2020 23:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604620105;
	bh=JaeZmEkvWhTvLV4KAaSbVrOYTR4dRZ2rPQvxLOIPiI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eeXwQYvdk5sdnAIU4Nwt3IYhr7xaOLdmNdL1Zc9586ABKhVaVfnfmhfOBUlg/VEZQ
	 Lo6k3v2VoasdKqGlMzaUXU1/8s/SltZ+lTOGf/T09xKmRwsGPNv9rSnvHiJwqvyfsx
	 b9H6ESPHMXB6ipOzjQY+GAD26cfmdMFbhK0CP4TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732744AbgKEXrb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Nov 2020 18:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732795AbgKEXrb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:31 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 978F42224D;
        Thu,  5 Nov 2020 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620050;
        bh=JaeZmEkvWhTvLV4KAaSbVrOYTR4dRZ2rPQvxLOIPiI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XKdZRCuYdKW8uOcbXCm7otStqaAwk6fsB9pzq8lD0JlVmJpV0KYqo8wm87S1lw56X
         f/R4FM2HAZgBHhRISJrLQoVI+E+mqwKz1xH2/pdtWxh7ZVknyw5MKXU8/8pjgJO3ql
         RRi6Obn7YwVnlTOe3/AzuMwgpuGXhIvRRTUdNPGw=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Samuel Hernandez <sam.hernandez.amador@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 25/28] rcutorture/nolibc: Fix a typo in header file
Date:   Thu,  5 Nov 2020 15:47:16 -0800
Message-Id: <20201105234719.23307-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Samuel Hernandez <sam.hernandez.amador@gmail.com>

This fixes a typo. Before this, the AT_FDCWD macro would be defined
regardless of whether or not it's been defined before.

Signed-off-by: Samuel Hernandez <sam.hernandez.amador@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2551e9b..d6d2623 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -231,7 +231,7 @@ struct rusage {
 #define DT_SOCK   12
 
 /* all the *at functions */
-#ifndef AT_FDWCD
+#ifndef AT_FDCWD
 #define AT_FDCWD             -100
 #endif
 
-- 
2.9.5

