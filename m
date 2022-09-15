Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D375C6FA82
	for <rcu@archiver.kernel.org>; Thu, 15 Sep 2022 00:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiIOAOg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Sep 2022 20:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiIOAOg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Sep 2022 20:14:36 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C43883
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 17:14:34 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id f13so7905183qkk.6
        for <rcu@vger.kernel.org>; Wed, 14 Sep 2022 17:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A1vsCw7qsSbg6LG6s3lCEoHneJ7sDD1rTCb2gsMBhiI=;
        b=PVl0MtbuC8jP0UnDsRzD+DryiQcwfi3cdRxo1mYiLGB8fjmQS20KFseigIWbxllokR
         COcSb6OcEDsD5gucsUYep4hzLW6CW/pF7H6hf7a7LE9R+G6dJUVv+ekd/+7NxLMJCCVL
         4QUu2IzMbm6D2kPkwWMzqte+24i+TJwQtpCTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A1vsCw7qsSbg6LG6s3lCEoHneJ7sDD1rTCb2gsMBhiI=;
        b=mVkbHbT+/01NGq2L4EW1XDjVF4GrF9Tl/YbIoZDuiq+IK2nZ7voJA+hcYCZgt5vFa3
         LvwV/Q1rMlIONdWoa6xR8gvTD8HQ6rJPVlS7WV1+cyUP+p3CHg8FMrEv1Cmh/PqhIx9c
         I0QeQxZeqVlZEag7hLsks8iS24ls8omz04O0WmOwwwNRfIqfs1L4tNj2a/UZ4vSHYTEz
         5BHnsn5MOphhrfuDxJY/v45AcTjwcnblxpH1GV4y8wKyj2OiZEiwRnkn2Ul/PFZXprgA
         2TkfkU4g3OL695qBhT7vJ6Wltjnnc5KyVMF2jsTaor3fkYFkv6k6hAtZOGl5zDDpl0z3
         SXYg==
X-Gm-Message-State: ACgBeo17C/NLQwBDRlOEVTSN9eIdaczycAiajiuoGJAm8wQ1k9WIOj/N
        z5KGGl6hoTFZaYWcZAPm4IiFnRf/GDRYVQMXAyQ=
X-Google-Smtp-Source: AA6agR7skx+qmUrnXxbC9eolRQX/E9WCYME4MPsQJ6mEMoqK9nsQdr33ypJE00CInZ5jxffolQVMlw==
X-Received: by 2002:a05:620a:454e:b0:6ce:3c11:24ad with SMTP id u14-20020a05620a454e00b006ce3c1124admr13034044qkp.606.1663200873386;
        Wed, 14 Sep 2022 17:14:33 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006bbb07ebd83sm2872422qkb.108.2022.09.14.17.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:14:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH rcu/next 1/3] rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
Date:   Thu, 15 Sep 2022 00:14:17 +0000
Message-Id: <20220915001419.55617-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220915001419.55617-1-joel@joelfernandes.org>
References: <20220915001419.55617-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
may help avoid load tearing due to concurrent access, KCSAN
issues, and preserve sanity of people reading the mask in tracing.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ca21ac0f064..5ec97e3f7468 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2106,7 +2106,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
-	blkd = !!(rnp->qsmask & rdp->grpmask);
+	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
 			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
-- 
2.37.2.789.g6183377224-goog

