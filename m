Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139D7C3F6B0
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351437AbiHSUtT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351479AbiHSUtN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:13 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ECBB72A9
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m17so4196100qvv.7
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QdCIKbuW1jeO5q/TYvf2HOrVzS0Qp3Smb7xunCfM3lw=;
        b=gZWOZnoLCqwLKrKaGSGgINgLYm0kJJl2I1xZ7YC9qS5ho5NKETZldVKc2T7wzBc/kp
         yd6ok2kyEYDIjRHEjDjt15Fv74oPiGbRhRQs9i2uwCc3ht75pNtI4f8Oq7ZlJwX6zRgN
         DPkRRkCeMhK6O9SpU8FGtY0iTjVskeu3BkgOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QdCIKbuW1jeO5q/TYvf2HOrVzS0Qp3Smb7xunCfM3lw=;
        b=z8wg6eDMijuwNf0SrXDF6VW6Xze12ifIzVDDmo1+WRUSrdSolvajZQFaLsAmGLcG/b
         sZt4pljJ2HxB+TrohCZmqMV4UzJoSXGA7X0vw3pWkZFNZqzJ8MSHl50IqmdCUDSR3GLd
         XcbJNl26tTDzvgf4atR0EcTnK+mHXq3zuanFtgWbwdeYcpFLOEftoYV6GwW81NiVJyFh
         /QvpKG7eYEPrKtRcipjM5bKFQR4xKI7eCc975qW7IC5aO7q9/zDBQBfB43LusWcEdCxj
         n+HEt+piyF1NHdiR2WT7i4H4UVD07uxmUkjBsad/hu467+9m8c09ieNLvE1NLeCgFxQD
         t/xg==
X-Gm-Message-State: ACgBeo3OICY2SLyE172cg0e/Qt7yRv/To7GW9o19TAAx1kMKweu9IPHM
        Q/8dY9AxqZeANt4YbsBaev6xZQ==
X-Google-Smtp-Source: AA6agR58m90yo1MdsoByPiyi9pH1L0gd07IBChVP/o41vOm26QOn/tNeRaWYQBthPaSJibA3a0skDA==
X-Received: by 2002:a05:6214:411e:b0:476:858d:b2c3 with SMTP id kc30-20020a056214411e00b00476858db2c3mr8024858qvb.22.1660942149084;
        Fri, 19 Aug 2022 13:49:09 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006b9a89d408csm4377123qko.100.2022.08.19.13.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        paulmck@kernel.org,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, vineeth@bitbyteword.org
Subject: [PATCH v4 07/14] cred: Move call_rcu() to call_rcu_lazy()
Date:   Fri, 19 Aug 2022 20:48:50 +0000
Message-Id: <20220819204857.3066329-8-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
In-Reply-To: <20220819204857.3066329-1-joel@joelfernandes.org>
References: <20220819204857.3066329-1-joel@joelfernandes.org>
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
2.37.2.609.g9ff673ca1a-goog

