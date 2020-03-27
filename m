Return-Path: <SRS0=KYXL=5M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B22C2D0EE
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27762072F
	for <rcu@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnSxsxJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgC0VY2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43575 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgC0VY1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id m11so7359380wrx.10;
        Fri, 27 Mar 2020 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oI5D0YXqK9ZgIbRmCkwUrf790yb4frzgCUGa0p7twfM=;
        b=fnSxsxJPJczTGw2uS+6OEn/aQr8ytsEbnRz9pM/1qTU6g/0Oqg0vgSsOu66kUEt8Wm
         2RwEKnJEVGEF/fBnrL4Mje1cysHGcxqMIv9jgeDWT5DNL+TxSe/JFuq4/ZnZSc2QzUdb
         fxZY9VeiMvfrlBYMoGstB3lklzKqVAXL7lXXKf1Uwc6UGB4udXnkODQdZUeR61psfVw6
         E1/y3d3tD9afaMeO4yNkjs3QqhSBq9o1/dLRy7ici+92b6MYizvHdqCXwn0j4W1SFrUw
         eXP1I0+SF/Wl8e/4XpP9bTana57/WPJ3XEw1GUQYtBL70g21DLR5hqWKrne1gb+hWkMU
         emUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oI5D0YXqK9ZgIbRmCkwUrf790yb4frzgCUGa0p7twfM=;
        b=I2S5aDGwytMDCeriBnr5OxO/GuPCFawlspA7gQD4+eOfdv/jflOypr76r99LbcYbKg
         B4flUn9dtYX829Mp4m8n8T6W46CuUSQZP46l2Dx1BZaiGlO8TXv5hiRTeLvfkwBOPupE
         Mfyb9ZKaMhXqUbicG1RjqtSmBdmoEwS55rKXmiGjdyLbnMuedGl6tdUEHl3qL6qzqdfF
         gBXlnrHKtyWLo4T6V/kJh6NGu+cLK3Yjhxfn4kqko0pjuwRDAHWrbOm1BxrWOETwVpB6
         y2gO8wdlEgLaqcieZSTVFMNEKP/KwDUm4/vbPe2keevWyY3/epXxoEbIeVnMaR/RKtp3
         We9A==
X-Gm-Message-State: ANhLgQ2+5rK/N6kotkxjxvG1k22DqsxhTR39luFfddxV/jvHn8TKvWG6
        t3Xcs+bd4V1ygqtJwNesRw==
X-Google-Smtp-Source: ADFU+vu7dBJNaL8ARFfODOVqGmkMaeUBdQUh0DCx6dsVUbL0hnjIG870s3bSG+bTQYoE5Uv+BJdTiA==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr1452221wre.167.1585344265854;
        Fri, 27 Mar 2020 14:24:25 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:25 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        rcu@vger.kernel.org (open list:READ-COPY UPDATE (RCU)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 06/10] rcu: Replace assigned pointer ret value by corresponding boolean value
Date:   Fri, 27 Mar 2020 21:23:53 +0000
Message-Id: <20200327212358.5752-7-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Coccinelle reports warnings at rcu_read_lock_held_common()

WARNING: Assignment of 0/1 to bool variable

To fix this,
the assigned  pointer ret values are replaced by corresponding boolean value.
Given that ret is a pointer of bool type

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/update.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 6c4b862f57d6..24fb64fd1a1a 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -98,15 +98,15 @@ module_param(rcu_normal_after_boot, int, 0);
 static bool rcu_read_lock_held_common(bool *ret)
 {
 	if (!debug_lockdep_rcu_enabled()) {
-		*ret = 1;
+		*ret = true;
 		return true;
 	}
 	if (!rcu_is_watching()) {
-		*ret = 0;
+		*ret = false;
 		return true;
 	}
 	if (!rcu_lockdep_current_cpu_online()) {
-		*ret = 0;
+		*ret = false;
 		return true;
 	}
 	return false;
-- 
2.25.1

