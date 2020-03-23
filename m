Return-Path: <SRS0=+8aq=5I=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739BAC54FCE
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA38206F9
	for <rcu@archiver.kernel.org>; Mon, 23 Mar 2020 11:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5R2vU6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgCWLgk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:36:40 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35213 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgCWLgj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 23 Mar 2020 07:36:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id u12so14152594ljo.2;
        Mon, 23 Mar 2020 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GU+XkzCORh6tm0Vt+4y4UlmhdyRi5QBd9PG4J+axnaY=;
        b=I5R2vU6Zxau8RuDcdKIeAhb0MOQXNDobGCbYYC3tkzZHjf97xSNF0vkrebftt3glJl
         Jkrrdej0X1ApjbouiK4E0MXlG2oPQFpXl6GMvsrT0aqFH8+oXSRCQXtAhKP8c88R1B2I
         522fusTH2U3kBaCwbDGQgN23A3hMvnI1c+OrgDnkkLS6lvEQwdTXCDFk0J4HMbrxigO5
         DAy2XehtjWaIq8H7EbSmRO0poeN0tH2WabE1pg97H3m5bhO0MCcD4mePhB5Cx9L+r1dX
         xCElHXigSd8fMjAhsvJlySnOvNmF39RShU4L8hB3AI/lRTlLjhD9euf+ANWxmoxEi7jF
         kMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GU+XkzCORh6tm0Vt+4y4UlmhdyRi5QBd9PG4J+axnaY=;
        b=uYy8kqpINmgwu702ksR3VOvO5m0sWz/0vUK0GeEKt22FHS3Dbg+yrVI4aHkC2a5orQ
         licJPBzNLh7AXk/2O6TF0QLjH3dVvqQwqkrXUlg+xSQigQQbRAHDRZ1+2x0eT+u1lc2b
         5aLzCjaLADu0RfhxgUey4Q3uwJi3x2b3jCabQFMh7dmrRa7fyeFLxxMUKbY+PKN77aLP
         ZzISvVT7kpgkSXH88KOs3+Xke7WqB2ZYo4tVFoaDo3zYao90u6VH19RITe8AvoHgizI1
         3Mz4f5oyYUMc4BWbOowEkhToIA9q1abXslZQYobDmitNBisLApaAlqZjO6G/o4KOPNP9
         7IJw==
X-Gm-Message-State: ANhLgQ29AyK3/GC3lqNRlpfXcfj0HizzkZG8WY0PqftiPAasl2YrK4Ct
        Ae2A5dCpwIIguHBrZutG50fA6oUKYlA=
X-Google-Smtp-Source: ADFU+vtpoW5Bi8bQzhXtXLHSN1XTnNF8vMNa3luBePvQJNHfv/0eiv2lRD+A/n15kdSKwfgSfrWHIA==
X-Received: by 2002:a2e:8595:: with SMTP id b21mr13177553lji.184.1584963396632;
        Mon, 23 Mar 2020 04:36:36 -0700 (PDT)
Received: from localhost.localdomain (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id r23sm8079268lfi.89.2020.03.23.04.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 04:36:36 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH 5/7] rcu/tiny: move kvfree_call_rcu() out of header
Date:   Mon, 23 Mar 2020 12:36:19 +0100
Message-Id: <20200323113621.12048-6-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323113621.12048-1-urezki@gmail.com>
References: <20200323113621.12048-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Move inlined kvfree_call_rcu() function out of the
header file. This step is a preparation for head-lees
support.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 include/linux/rcutiny.h | 6 +-----
 kernel/rcu/tiny.c       | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 4cae3dd77173..3a879a2e0268 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,11 +34,7 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index aa897c3f2e92..508c82faa45c 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -177,6 +177,12 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
-- 
2.20.1

