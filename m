Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC0FC433EF
	for <rcu@archiver.kernel.org>; Thu, 12 May 2022 03:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244299AbiELDFM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 11 May 2022 23:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244489AbiELDFI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 11 May 2022 23:05:08 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB191FC2E2
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h3so3455056qtn.4
        for <rcu@vger.kernel.org>; Wed, 11 May 2022 20:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nug8nbY87iEa+XSWPZu0aU2M2l7wYnXsOW/cyW7eajY=;
        b=tfAZ5r4bh3NA6e7T//RBhRkcSq9FjWi8hDp8OY/sROlUB0RuMAFrDjdx0RzpTCsGfR
         fDRT8PvhCjT0q/Rd+J6+q2nZVSUOke/HxBiDDWJ+tEJjewYaWE7KpkvknRmQNlH8NdAN
         f4Y/RJSFvFr4sna2sKphUCPaJE/zjyK/XPqfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nug8nbY87iEa+XSWPZu0aU2M2l7wYnXsOW/cyW7eajY=;
        b=JsqblsPL4wTa04WJr+JPN0DTnF7y/UnClQElUuMg6FRxJTxbkEj0TbPzJB2Tj6nvsV
         st8dZeHPFIKmcHoqU5yPFKexW2PW+BVeRhjWXuPGWvM47/g/nIg4/FGiUNeiTOJga5hx
         PhzFeHNP+HVUmOlY6FZJx3xOvzG9NqKawPpAg2ihJs8e10jJcDYdBKDZbTIRmwnLwps/
         lQr6VDblk7JpHce/ScXLUQsGvSPOq4qmWDmD1WlGGuT41BmFDEjrWTz0pIZg+Q7coCOz
         fEhkeamzaXE34q1UDQyftyAUWci8nNLGqUIdQ65D6rTKawYyFdGapY5m+SefocdUOhX9
         i6xA==
X-Gm-Message-State: AOAM533mRNm31JJ2q5CZBbrV8WKYk8JgFOooANZIrshMjvI8/yMl7RaO
        5rnP3qbp66bz/OSFyOIG7a3/OsNO/SsXZQ==
X-Google-Smtp-Source: ABdhPJw8vCshps1jBtfrj9hugLug1THWkweJKWw53CHfGWpfw06HInnRxbTomhM8ALgtj3MfWMdPvw==
X-Received: by 2002:a05:622a:6206:b0:2f1:e40e:41b3 with SMTP id hj6-20020a05622a620600b002f1e40e41b3mr26722019qtb.196.1652324706678;
        Wed, 11 May 2022 20:05:06 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (29.46.245.35.bc.googleusercontent.com. [35.245.46.29])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2270334qkc.52.2022.05.11.20.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 20:05:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [RFC v1 08/14] net/core: Move call_rcu() to call_rcu_lazy()
Date:   Thu, 12 May 2022 03:04:36 +0000
Message-Id: <20220512030442.2530552-9-joel@joelfernandes.org>
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
 net/core/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index d16c2c9bfebd..68c240a4a0d7 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -174,7 +174,7 @@ void dst_release(struct dst_entry *dst)
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
 		if (!newrefcnt)
-			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+			call_rcu_lazy(&dst->rcu_head, dst_destroy_rcu);
 	}
 }
 EXPORT_SYMBOL(dst_release);
-- 
2.36.0.550.gb090851708-goog

