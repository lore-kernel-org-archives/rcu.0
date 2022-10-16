Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F804C4167B
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 16:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJPQXt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJPQXn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:43 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2153C8C5
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:40 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id m6so5404736qkm.4
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLBYpsFEJKnpduUs5aM0LOOoZhLo8S1nCnZi0UB2KAw=;
        b=RCMpa87j4Yk0l/K9GgHa918zJweD8ZC5bp6tXAzXf9jjm4FbawEWZfd0h0FYrpS2i7
         yTr2WMUUyIdKn8yUCbTs9Ah2xlZvlZGv18SQK4/OmJP03NvxlLLMMPZ8ceelFIdf6GXh
         A8tr2UU67BYyh2oPlk70FXcxeCsfLoCpdnitU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLBYpsFEJKnpduUs5aM0LOOoZhLo8S1nCnZi0UB2KAw=;
        b=O2u+LrvWJlZPshiWqLMZ19IEz2fUrZ295nBbpuhx13Liq8X5SCB2s2tHPK5ayFzRIy
         uEXtPTHAaHmJM6jBfEzjeGRcaUG3qptwEIo3oDTM65BEoDNWKQlAbqmo4v46CVX+llKF
         tXOw06rqxsqWbkpOHV1sL07jkaINtczUMpOYoPf1hauWF3KpZwnEv6JC2iOB/wFmknbA
         cB6uLZAQB4OAQf1WN7D0wDXfn6I6y5ZRwGN2Lhrz4QcQ+aA94Fx5zOLkmR+G6yBWns9E
         aBkiBhSVPZobeXy/1Os3y5ZYJ/KFLuPDNaflI9lbjTTk1Fwu48zVtGK/u/5FNx/dpeNp
         HILA==
X-Gm-Message-State: ACrzQf07UMdxWzUmvDpEoahMqeRtXS9JC9e0oCH8G8T5O6OnCu8GcbuK
        I9GtkTLKXe+7h8g4kYAmIECS24/Z3AjHbg==
X-Google-Smtp-Source: AMsMyM6oKZNkW+lsqqD+/KejvN0kOxMvHA99ZEAeVvMkLUwAWgf3t22vn41GX6P/UIeQWTpBQk3zAg==
X-Received: by 2002:a05:620a:2618:b0:6ea:908:120e with SMTP id z24-20020a05620a261800b006ea0908120emr4939543qko.645.1665937419224;
        Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:38 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 07/13] rcu/sync: Use call_rcu_flush() instead of call_rcu
Date:   Sun, 16 Oct 2022 16:22:59 +0000
Message-Id: <20221016162305.2489629-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
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
2.38.0.413.g74048e4d9e-goog

