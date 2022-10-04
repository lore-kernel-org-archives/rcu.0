Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFFBC433F5
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 02:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJDCmc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiJDCm0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:26 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C18E233A8
        for <rcu@vger.kernel.org>; Mon,  3 Oct 2022 19:42:25 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x18so7685792qkn.6
        for <rcu@vger.kernel.org>; Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=p7gxr8BOzPMoIl63Waae9ssjZi2XtE67S7yBYwewcinAF/AqvnClbq17oXihpKvHQi
         /8SzODU4rEaB9L2Xt7526x1uvkkX+cJFkK2yopse5rNtnLC42UWRgbODMXZAt/nh/FQ2
         +mjgTe4d7MtTAJ/CJug4mLXOQgiCVUOeqwoho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=cyNPGKSpanWg1PBp+oFJtta8YoEUOyUADsqxsJVyYKI=;
        b=jgYnJa/KTgtbzY1znNRE1j9AhfUiYf87kp2014heJ9tN/4BblAK1Q9ZvbtFAzyke8N
         APn2MVvQcokf322nokJ3Z5lqVtiMW6yQMHlfSTlvzYKV9Q4+ObnnDycJgfAd4GnS0Csc
         9lSh14aZ+ffeBvoDbke/YKusqNAaifndZ0kvR2UuboJq/cKJRTPI+kT4LK4N4vITH3bD
         vRnyR6XRL0vfZBouuapwAhvuYUleZdNWnY9cE0gwvLt3DsAys4+wX6bvM7klQ5dVLxDo
         lvk49N10FQnaJ5N/TtP7YFIcSasByHeSBpBZDQ1gzBWDBY9LkzuA6NWm8VxHs9lD+ZTF
         +SVw==
X-Gm-Message-State: ACrzQf3hXfDUBaurjzsOpXj5yAVUUOCdkqJzr6ksoCA6j+EtZ/puGJg9
        5SiJfrkAFe7v9FdMlzUfofInWW3YCczN/g==
X-Google-Smtp-Source: AMsMyM6fCVLZqIV9NJDDecY/faq4ubFj7YCBYr92jE5ezFM/7K/NssIz4oF08sZhf7H/Aa1rVIfyow==
X-Received: by 2002:a05:620a:198a:b0:6ce:7f32:9f3f with SMTP id bm10-20020a05620a198a00b006ce7f329f3fmr15896386qkb.90.1664851344870;
        Mon, 03 Oct 2022 19:42:24 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 07/11] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Tue,  4 Oct 2022 02:41:53 +0000
Message-Id: <20221004024157.2470238-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu() changes to save power will slow down rcu sync. Use the
call_rcu_flush() API instead which reverts to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 5cefc702158f..bdce3b5d7f71 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -44,7 +44,7 @@ static void rcu_sync_func(struct rcu_head *rhp);
 
 static void rcu_sync_call(struct rcu_sync *rsp)
 {
-	call_rcu(&rsp->cb_head, rcu_sync_func);
+	call_rcu_flush(&rsp->cb_head, rcu_sync_func);
 }
 
 /**
-- 
2.38.0.rc1.362.ged0d419d3c-goog

