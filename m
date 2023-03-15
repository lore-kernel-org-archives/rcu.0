Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410EBC61DA4
	for <rcu@archiver.kernel.org>; Wed, 15 Mar 2023 19:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjCOTja (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjCOTj0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Mar 2023 15:39:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28506700A
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:39:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l13so17508836qtv.3
        for <rcu@vger.kernel.org>; Wed, 15 Mar 2023 12:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1678909158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H58NOkpBsborYqDlb6apVPOFULtTVVJdIxtX+vdpwc4=;
        b=C093a986XM+BY5phSly7wrGZCcmMxTiTlUfXZxpE7QnM3ZVj5e2y6nnNsgpnj1q4g3
         b6kqPR4fnmeuu41UvzmMuQxZPdQQZyQ53vE4qe5XrF40jJi2gYTkZ1sgrCn/kXrFPMt0
         uDqqMdAuP1MgwDf5FFqNt6sQOBCop356zuIeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678909158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H58NOkpBsborYqDlb6apVPOFULtTVVJdIxtX+vdpwc4=;
        b=OHIvdCMxJPZUv5+QdApRTe9/YOonu+94A4u6r7BlO28xGzKNPoJJxNgxqhZTP33uv3
         Ml4dk5GdV6vdb21GFjvec/p7tFtlFPhneg6VlpBOrB+689kopkWOVIVhuBUJWdbKK3aW
         vJyJfGjeKnUGjS37voQgD8UBJeBwHxWUgUkoOctTWEJj+lhI4XeVMGgiADVmSVOupcjW
         5953w5iau48AotAP/7ph817tpdyQ1wbyrxn/IKoXXR9Ktt3cOK2kVLo8TGf31Nya95YA
         fKak7Jd75GpkPsR/01exQbsLkkRLUUpLzy9R//vwbLNDgaItSHiL7+8lxtH+nAJ2ckfE
         ijNg==
X-Gm-Message-State: AO0yUKV4De1ZANfLtO/PdLaf4fid/7m330D14rnsqJ7ZWY93j6aKvrcu
        9NfpmX3dnVZcEoGxOy/3YlSycA==
X-Google-Smtp-Source: AK7set/66oK6XSfs52GYzh6EZaoShJeuEtQsucB4O83OGbah83EM8uB0VUPPO6XgJzFDF7lhYm8bvQ==
X-Received: by 2002:ac8:5bca:0:b0:3bf:be4b:808c with SMTP id b10-20020ac85bca000000b003bfbe4b808cmr1465528qtb.55.1678909157780;
        Wed, 15 Mar 2023 12:39:17 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b00745af48838bsm4347227qko.5.2023.03.15.12.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 12:39:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org
Subject: [PATCH 6/6] rcu: Add comment to rcu_do_batch() identifying rcuoc code path
Date:   Wed, 15 Mar 2023 19:38:51 +0000
Message-Id: <20230315193851.8598-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
In-Reply-To: <20230315193851.8598-1-joel@joelfernandes.org>
References: <20230315193851.8598-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a comment to help explain why the "else" clause of the
in_serving_softirq() "if" statement does not need to enforce a time limit.
The reason is that this "else" clause handles rcuoc kthreads that do not
block handlers for other softirq vectors.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e880c09ab59..06cc6a6ad819 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2131,6 +2131,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 				break;
 			}
 		} else {
+			// In rcuoc context, so no worries about depriving
+			// other softirq vectors of CPU cycles.
 			local_bh_enable();
 			lockdep_assert_irqs_enabled();
 			cond_resched_tasks_rcu_qs();
-- 
2.40.0.rc1.284.g88254d51c5-goog

