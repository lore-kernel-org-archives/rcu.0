Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766C6C6FA82
	for <rcu@archiver.kernel.org>; Sat, 17 Sep 2022 16:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIQQmh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 17 Sep 2022 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIQQmg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 17 Sep 2022 12:42:36 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC682F393
        for <rcu@vger.kernel.org>; Sat, 17 Sep 2022 09:42:33 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id m9so18934807qvv.7
        for <rcu@vger.kernel.org>; Sat, 17 Sep 2022 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YtXTLA3M+nWqodgxztJaMgLvSRyU03TOMEk16miDVSg=;
        b=ShOLZGx75Ii8OwDydiUuECJDaVrzXu7dm1LvXWu1uMAHXy8OWxy3+sY1KgJKUVy9sc
         lJGUEgu7gVKBhWs0Wz0ZhBtUO3JLjqMoq0kpgajDLoDILUKTL2HipbaT+ktS1fFKI787
         zPzc24o/oNUffNEGEUH9lEkxMlvjJIA+zFR6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YtXTLA3M+nWqodgxztJaMgLvSRyU03TOMEk16miDVSg=;
        b=iahv5tWXuFvKFYy+HAE3DNFdDykQ4GVbLGlQG0fCfUuFVyhH65IPipl0YCuZItZFsm
         9vYdfJWmE06JCkISiAOVw6y+BrrehATBSTzwIb7OJgzZnw/z4h3jLe4HRVNnIAHXPliR
         VHS+8jU0X52P5LR0Q4ImPH25cSOnaPl+o1MQtQ9TO/+ai1HDUvR8MYfCpBZJUa1Slvpu
         7+oU17uWHaqh8WKl6KbpjQFxwyK8OLkMPyz4K1TwV1iubOPtLxk079laAN5yquRHVrX3
         IigkK11AD1dsMUceyjxvyg+G9RhkMGrc9s3t7gmiTmLRuaGszKjzfkZwLFj17w20HIfP
         8QiQ==
X-Gm-Message-State: ACrzQf1YvunS7vWVXw3h4bQIxsmM4nrm0J7hcvgDPVccC+zLpzn8kWPR
        8MSEx2cXvUdUGOxjs2dRz1fPJ2CwVlLQbA==
X-Google-Smtp-Source: AMsMyM4IYHlTU6MQt7EpgMPbONgN5h3lvYXkOHlxQ4yG2OYh9ORFH9JAXc2T1IMbliGqy+f9+mm10Q==
X-Received: by 2002:a05:6214:1d21:b0:4ad:1361:befa with SMTP id f1-20020a0562141d2100b004ad1361befamr6419573qvd.111.1663432952613;
        Sat, 17 Sep 2022 09:42:32 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id q31-20020a05620a2a5f00b006bb0e5ca4bbsm9479239qkp.85.2022.09.17.09.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 09:42:32 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH rcu/next 1/3] rcu/tree: Use READ_ONCE() for lockless read of rnp->qsmask
Date:   Sat, 17 Sep 2022 16:41:58 +0000
Message-Id: <20220917164200.511783-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220917164200.511783-1-joel@joelfernandes.org>
References: <20220917164200.511783-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
may help avoid load tearing due to concurrent access, KCSAN
issues, and preserve sanity of people reading the mask in tracing.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
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
2.37.3.968.ga6b4b080e4-goog

