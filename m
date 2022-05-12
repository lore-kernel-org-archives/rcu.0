Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5883C433F5
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiELDFG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiELDFF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7BB1FC2E2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:03 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id bs17so3784519qkb.0
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZYwvc4nSRfwkY1hI9gFtWU/c+R8K3b6EhO2tYCnlpU=;
        b=aTE/unhoMaGxOUCCrBIgKbzySr3cULCQ5TAoDSL8kyEauR7AtDV8CejE+04dYhccJy
         KcH7+4QnzwLXqblklJ0ME3ugHcEpvag39UX7OoY/7U+OJ1cs0dZzafMFFJEGI+Zi7hLo
         s0LvhNHP0h18uC2G2IAFvMamoCdOi5YwY3Afg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZYwvc4nSRfwkY1hI9gFtWU/c+R8K3b6EhO2tYCnlpU=;
        b=r1ThJtZT1kmmLUrlHoKi13UQOWL964eX79zVVRAxNXmMWI9OatHolGG6A2uWBD2l2m
         sphsnr1FnYD1AuCWend9TzOFCfPNnGGKtkFdMWSAmFqeXB64DfhpKYMfPCVeic7ORr8s
         YcfyozbiBlKDAbArbsPIGAAKL9z8ISzflPr7H4C4vGBbXEJ/LjihIAgoIDYKL+EXQkqS
         3eGExxQ6QSelRcsZ8u4XW/syHBFJI3H7tvaB6Bc5h3HEwRp65cxvC3wNcLNWNMEa4rzs
         M9VBPnNydE2IaGn6YHZP846o5HxTOzjPEq63bS8AEifqqvv5+bJYfF6uCZZDElzBjjGb
         KJtw==
X-Gm-Message-State: AOAM532etLAaaFMvGvvjIhXjP9ItLuNxFdDmvEIN4UuFJK94C03wJTdR
        Gy0WBqJPtSqyDjAcGvLYVTTd3AlH/J70yg==
X-Google-Smtp-Source: ABdhPJwirgdZpfilGyH+mvunVo+eLsRAK7ZAzSvBCeQ/lqZ4EuTlJMqQ/s+5n6K6FyBEBFgMNrR33Q==
X-Received: by 2002:a37:48e:0:b0:69f:9bc8:720d with SMTP id 136-20020a37048e000000b0069f9bc8720dmr21080039qke.268.1652324702891;
        Wed, 11 May 2022 20:05:02 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:02 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 04/14] cred: Move call_rcu() to call_rcu_lazy()
Date:   Thu, 12 May 2022 03:04:32 +0000
Message-Id: <20220512030442.2530552-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/cred.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 933155c96922..f4d69d7f2763 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -150,7 +150,7 @@ void __put_cred(struct cred *cred)
 	if (cred->non_rcu)
 		put_cred_rcu(&cred->rcu);
 	else
-		call_rcu(&cred->rcu, put_cred_rcu);
+		call_rcu_lazy(&cred->rcu, put_cred_rcu);
 }
 EXPORT_SYMBOL(__put_cred);
 
-- 
2.36.0.550.gb090851708-goog

