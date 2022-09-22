Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D85C6FA8B
	for <rcu@archiver.kernel.org>; Thu, 22 Sep 2022 22:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIVWBh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIVWBc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Sep 2022 18:01:32 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05815106524
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 15:01:31 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id 3so7192264qka.5
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 15:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xKb1FWV/BNF7dFbOAVH7aAIeBlfPfyRPTEu/ZS4Sqtc=;
        b=RnyQz9cyUSvE+E9yNg8BuKP3ayY1XXrWj08RP64gS1HcGnYT5NUIRDUjvu3gGiWjUV
         o1Zbw5vznDKaFeJJ5TIS25gdWVQxGknMvaW+EOMWW8Mrw9cPMyB4MMIkbhCcIW/L8WnW
         5FiFRK9OG3eWD6ot5GkUHboo9fTJIcjWNYVko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xKb1FWV/BNF7dFbOAVH7aAIeBlfPfyRPTEu/ZS4Sqtc=;
        b=nBizoFWDMmJd0SYkYoGwE56RSR6rXm62Hr52gXu6dZLYr4l8smqMRzK8EeeG7nsIpp
         vd0ksB2njJRK1EqeGTNgI8Nzk/sjzwqS5CKcUU0fmbEbUig0zth1XmF+TinehI/wsNH/
         xh1ONN8ZxdnHC9BKO8i6NogET/bRBFxxA4SIXN5WfSpffAOuu8kQuQFbDhmBqiKhq0I2
         SfKWZ4s6Vilujvpoyy08Ocr755152wkybdV+/xDTmKBnDLHVUD148UKs5yARlanADR2Y
         9yqvrm3VX0deE158CCYCIBmDZb2mIYMR+5lKxaiuZtbZe4IecblI5VWa/NTprVfXbMo8
         3/rA==
X-Gm-Message-State: ACrzQf3y6mTOUMQb3KibKVmgTHzPhQFP+x8Xp0JfACEMyU7Us+0gfMFx
        oKlKGm8GEbDzsVUXz6qmIkVzaCHherJthQ==
X-Google-Smtp-Source: AMsMyM4/Y4MStj6VIj9Ja0U0VSqEWGeY7ueLAXYF+EGSUTsY0oso40SG361nVaHoskgS1OvVwPwISA==
X-Received: by 2002:a05:620a:198a:b0:6ce:7f32:9f3f with SMTP id bm10-20020a05620a198a00b006ce7f329f3fmr3844189qkb.90.1663884089931;
        Thu, 22 Sep 2022 15:01:29 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id z12-20020ac87f8c000000b0035ba7012724sm4465833qtj.70.2022.09.22.15.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:01:29 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v6 4/4] percpu-refcount: Use call_rcu_flush() for atomic switch
Date:   Thu, 22 Sep 2022 22:01:04 +0000
Message-Id: <20220922220104.2446868-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220922220104.2446868-1-joel@joelfernandes.org>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu() changes to save power will slow down percpu refcounter
per-CPU to atomic switch path.  The primitive uses RCU when switching to
atomic mode.

The enqueued async callback wakes up waiters waiting in the
percpu_ref_switch_waitq. This will slow down the per-CPU refcount users
such as blk_pre_runtime_suspend().

Use the call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 lib/percpu-refcount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index e5c5315da274..65c58a029297 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -230,7 +230,8 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu_flush(&ref->data->rcu,
+		       percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
-- 
2.37.3.998.g577e59143f-goog

