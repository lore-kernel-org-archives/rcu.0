Return-Path: <SRS0=zn4Z=BJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA0C433E1
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 03:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D28322CA0
	for <rcu@archiver.kernel.org>; Thu, 30 Jul 2020 03:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="W34bhE3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgG3DCf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgG3DCc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jul 2020 23:02:32 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E68C061794
        for <rcu@vger.kernel.org>; Wed, 29 Jul 2020 20:02:32 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so24354073qkg.9
        for <rcu@vger.kernel.org>; Wed, 29 Jul 2020 20:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+qtJerENl+R3lIp2sk3UvcjK8RDOhGe6ueG91tUx9Q=;
        b=W34bhE3PYvBO+cD5maoCqKLyBwxlrKfZJWJmIXlwFAmV/Zz/HUQMlX/gSME1g5Vo/S
         gYgvR98W5uiqKvcPOdD1prpaq6BIsaAi6cLqrjmM6oWG5/zx7GvEgk3apmoNCFqLHOcs
         iJy+N5iXXdZVAzJqHnyTotST3uy+ty8sJT8sQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+qtJerENl+R3lIp2sk3UvcjK8RDOhGe6ueG91tUx9Q=;
        b=qpP2C8CRM0yXviWctrk6cQU6Gz6/w3V3GZ7IpYs/0w6PJcSmYHV7KkXFhaaJtUO+YS
         6vWgKs8X10em1DjAEiQxglLjNuIh/bpVlBZaFvcBw7HM6XauEOxaDIshdvgO0m+UouPP
         /LochI8Owsja+NSAzTPEoxGWaKdKXjmCLoOy+JvbVjXjanQAUdWst7RJ/1iCTL2aJOpg
         CakQy8OHVJBV7filipfENl7aans1lpHu4cPNMSD/NSvQqbR9Vp2dxePziu8v6I3pnpmO
         qimu6RtBfHFACVXJ/l2KBhTzeoZ5YGuaGFXEF+1vLb6bqX5CzAVaKfb1rKstkkH2wWPS
         gVJg==
X-Gm-Message-State: AOAM531nrR75VGEaEodwq9kO93nOQuF5DsVfcfo86+hk0nrf42KB8FYO
        6hG2Yt2D5EbWhiXLBieQz4SPiQ==
X-Google-Smtp-Source: ABdhPJww1CYOHQZg3gqYgW/xhuEjY+TNk0Uptw6KHekHWei4FCKzbWk/J/943+pUJkiBhnACgWll2g==
X-Received: by 2002:a37:9507:: with SMTP id x7mr29285452qkd.253.1596078151592;
        Wed, 29 Jul 2020 20:02:31 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f7sm3122044qkj.32.2020.07.29.20.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 20:02:31 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] rcu/tree: Clarify comments about FQS loop reporting quiescent states
Date:   Wed, 29 Jul 2020 23:02:21 -0400
Message-Id: <20200730030221.705255-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200730030221.705255-1-joel@joelfernandes.org>
References: <20200730030221.705255-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

At least since v4.19, the FQS loop no longer reports quiescent states
unless it is a dire situation where an offlined CPU failed to report
a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
to keep the comment current.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1e51962b565b..929568ff5989 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
 
 	/*
 	 * Apply per-leaf buffered online and offline operations to the
-	 * rcu_node tree.  Note that this new grace period need not wait
-	 * for subsequent online CPUs, and that quiescent-state forcing
+	 * rcu_node tree.  Note that this new grace period need not wait for
+	 * subsequent online CPUs, and that RCU hooks in CPU offlining path
 	 * will handle subsequent offline CPUs.
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
-- 
2.28.0.rc0.142.g3c755180ce-goog

