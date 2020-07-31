Return-Path: <SRS0=65p9=BK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C17C433DF
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477F820656
	for <rcu@archiver.kernel.org>; Fri, 31 Jul 2020 00:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="m3roDEvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgGaAk3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgGaAk1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jul 2020 20:40:27 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F61C061574
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 17:40:27 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id s15so8983933qvv.7
        for <rcu@vger.kernel.org>; Thu, 30 Jul 2020 17:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbCcJZmt6eGN4Co8J2+ytDC8kXUiakoxhSvDXw3GNYk=;
        b=m3roDEvLZDluWMv4Jf0eK6iWRB7TE4WjwUmvl+Ztv1l8tlV3g5pqoewEx1NRGudSME
         bWnThrRj4f8XlOdkMX/Exib4j0mVJFa2bljwKeGs7+0toMNQeYwrepJ71djn7uHgLt2P
         u8cQ277PfKk6UV6kHQ3nSxlf+tB6jNBkysGHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbCcJZmt6eGN4Co8J2+ytDC8kXUiakoxhSvDXw3GNYk=;
        b=oaYRLokrOyAMVGoEE2FHBwKKivuiG25fBW9abM7vDJ78kSIvkEif1htUxpcGZejobQ
         L1XQCNzmTIrqe+UyoY7F3NPlFdOvZt3qULbwIPDQHTS/yLV4w8hWkXs1OEXOYWs388JQ
         kmNq0FSIMtUETFCFHr8oYxpkWHGaqmrTH7IU0CzDqF2EhPMLcGahiEtoVSOjDwA42Xqi
         1em1AjW1B+J1bTpzxbwr47j0duWvrz9LSnHtulVGw9ZHKLlXksCMoiHecpsjHKHCr33G
         VDhrjd7Jnj/eavZc/pmeMKrmJxg1geydgmlmKG/DjJmdkbfJmbkO9Wvq/aR3FIluYTn7
         Jo/w==
X-Gm-Message-State: AOAM532DpKmzfX3LxjySsYPLb5fGe5lpL7LGJrdX14Ss3kYRg982+RS2
        BD9VNcHisHcFKUqgbSAqJGeBtQ==
X-Google-Smtp-Source: ABdhPJx3+bhAG64u/N4H2NWZ+LadDA8xgtXti0oQIPdXAYDiaLpEVTsgkhft7YGIxruNnyBYfG6Asg==
X-Received: by 2002:a0c:c781:: with SMTP id k1mr1720225qvj.223.1596156026599;
        Thu, 30 Jul 2020 17:40:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c5sm3077320qtp.62.2020.07.30.17.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 17:40:26 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 3/3] rcu/tree: Make FQS complaining about offline CPU more aggressive
Date:   Thu, 30 Jul 2020 20:40:12 -0400
Message-Id: <20200731004012.2324147-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200731004012.2324147-1-joel@joelfernandes.org>
References: <20200731004012.2324147-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Make FQS loop consider it an immediate failure if the case of an offline CPU
reporting QS is detected, instead of a full second.

This is because rcu_report_dead() already reports quiescent states and
updates ->qsmaskinitnext under node lock.

Light testing with TREE03 and hotplug shows no warnings.

Convert the warning as well to WARN_ON_ONCE() to reduce log spam.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a621932cc385..39bdd744ba97 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1208,13 +1208,15 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 		return 1;
 	}
 
-	/* If waiting too long on an offline CPU, complain. */
-	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp)) &&
-	    time_after(jiffies, rcu_state.gp_start + HZ)) {
+	/*
+	 * Complain if an offline CPU by RCU's books has not reported QS. Node
+	 * lock is held ensuring offlining does not race here.
+	 */
+	if (!(rdp->grpmask & rcu_rnp_online_cpus(rnp))) {
 		bool onl;
 		struct rcu_node *rnp1;
 
-		WARN_ON(1);  /* Offline CPUs are supposed to report QS! */
+		WARN_ON_ONCE(1);  /* Offline CPUs are supposed to report QS! */
 		pr_info("%s: grp: %d-%d level: %d ->gp_seq %ld ->completedqs %ld\n",
 			__func__, rnp->grplo, rnp->grphi, rnp->level,
 			(long)rnp->gp_seq, (long)rnp->completedqs);
-- 
2.28.0.163.g6104cc2f0b6-goog

