Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5561FC6377B
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3737261246
	for <rcu@archiver.kernel.org>; Wed, 21 Jul 2021 20:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhGUTzp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhGUTzo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 21 Jul 2021 15:55:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9FFD60725;
        Wed, 21 Jul 2021 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899781;
        bh=RwBedTrYcOnwlP0cCxXb/mWY9SfZub7o9Ob9Dv9SnHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zj0GgZm2gXhKBZvXrxKOIjPZHozfVlSlp8rWUgjmg3c4DR2bvqjQ/mRe3eZd5rQKL
         Q33gAHhudTg3TNhbz5tFgeitEF0qnmgO/WIL+TZZvAIVrgIjc8/scReSz+T+SfAF0d
         tS8UXc3xioIe+6bbKhP32yfi290zJK5sJ6NoftdfT5NHyVy6sZeJ30ySlfOakrApPM
         7+dpjulpKiTfsyqwCfyLCSbIozPG1BWSft978PhdnpRDbAgk23j1tegiZdMoktZNys
         /KJIx7zWiC+yaJw7WV7Z0o/CJ0Hx52Juz3uOyzSGR2WD1muAJai6JLFCUWmJNRvdG/
         Wb7chMlU7QQgQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B80AD5C0A03; Wed, 21 Jul 2021 13:36:20 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 2/2] tools/nolibc: Implement msleep()
Date:   Wed, 21 Jul 2021 13:36:19 -0700
Message-Id: <20210721203619.3373350-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721203600.GA3360826@paulmck-ThinkPad-P17-Gen-1>
References: <20210721203600.GA3360826@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

Allow users to implement shorter delays than a full second by implementing
msleep().

Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 13c194aeaf3f0..3430667b0d241 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -2243,6 +2243,19 @@ unsigned int sleep(unsigned int seconds)
 		return 0;
 }
 
+static __attribute__((unused))
+int msleep(unsigned int msecs)
+{
+	struct timeval my_timeval = { msecs / 1000, (msecs % 1000) * 1000 };
+
+	if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
+		return (my_timeval.tv_sec * 1000) +
+			(my_timeval.tv_usec / 1000) +
+			!!(my_timeval.tv_usec % 1000);
+	else
+		return 0;
+}
+
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
 {
-- 
2.31.1.189.g2e36527f23

