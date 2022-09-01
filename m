Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F800ECAAD2
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbiIAWSn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiIAWSK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0DC5B061
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:18:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id g14so210094qto.11
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TrK5dOUuJ472Va/MQxlZM4Ul27mMRNSxArIaJwpPfZg=;
        b=TUcC0u4QM5Ny9KLvPnrxQITVTokuBxEATE/WsQfbGYFGD9PpxIg9MJCiMdUCQf7Laq
         X6rikyqdDpvNk6vlDW0YVq5/0S8OJYELbrNlakftwrW0WN0AsYlxa096qY1FJJBELlxI
         jL2uVxkUi+pIbxFoV4OaGYaWTNiex9ahiveZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TrK5dOUuJ472Va/MQxlZM4Ul27mMRNSxArIaJwpPfZg=;
        b=CirCsO0NJbQZZFpl+2S00ouBrLUf23c7x2xt5Y8XK42KXVXImspZqamTb8xXSZxDOr
         KWYmZ6o/OmjjQ38vwOaSSXfQGy+gUNJCbbY3J35YglGNHWN6URBqAmLMJlQQ87q31dge
         wgqEoGtgW2cVSNbD3EUewTrbD0PPkPZH4Vvawhx2hoRZNNxA6PLl/sO9CdKT6sszlqNz
         EXaUhLxw5L4e5dQ8e1m2ynVXBtYFpDK8vX8pdDq9Wip7/pcrOU/OOIwwJANjIRGPz2jz
         R05u/g7pLtjKPxNWJQyKaOcB78ugIj8OLx0Q/2DtjWrLJShFpA1Y4jGkr7XsfAbcboLV
         Tw3w==
X-Gm-Message-State: ACgBeo0CVCv8jjEk5ghjX++CCXec5WC3/zyMzjZnVHmfNQuA2CFqtH51
        tVQyLtvSRgw7hjMT7KSFK66WHUTIZanDjg==
X-Google-Smtp-Source: AA6agR4uiuD53PR2JnbYvQYDsN+ofsO7SW63BGOkp2t0qORapVEs6g6ATsIcI2VvrBk+/fuLb48KeQ==
X-Received: by 2002:a05:622a:53:b0:344:6f46:9b16 with SMTP id y19-20020a05622a005300b003446f469b16mr26319627qtw.664.1662070685785;
        Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:05 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 12/18] cred: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:14 +0000
Message-Id: <20220901221720.1105021-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
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
index e10c15f51c1f..c7cb2e3ac73a 100644
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
2.37.2.789.g6183377224-goog

