Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E7C433F5
	for <rcu@archiver.kernel.org>; Tue,  4 Oct 2022 02:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJDCm5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Oct 2022 22:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJDCm1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Oct 2022 22:42:27 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A9023142
        for <rcu@vger.kernel.org>; Mon,  3 Oct 2022 19:42:26 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id w2so7472491qtv.9
        for <rcu@vger.kernel.org>; Mon, 03 Oct 2022 19:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=B/BzB/7t/zinmDkfHiX1ubMpJVCYgc+DxJaULzkgt9Q=;
        b=TqxqIekDJP7tMHpsM1y2nF6521dmq/uKSZA99tbjnhvAFP8ffOS3P8Se+TvjOQf4hc
         CZc66NJHADCpJu1Lhzf64asoYeGOmfneZ/rD5XjA0RhZX2a7c5Kp37QD1PJaFFTgWKtH
         8XGaepdWvrReLBEJJrKMddxKHghzH1XMnv/No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=B/BzB/7t/zinmDkfHiX1ubMpJVCYgc+DxJaULzkgt9Q=;
        b=smVk/xo+B/l+mFnRi9fK0u2roNKTZFz3ggIe8mnulRQxcMZ2+ClnR0OnPylzeIwTnt
         1olLqQ3O+65YrWwJiRy1zSiRCsBYT09CU4sOHapLToulMY7TeuAKqA2vUwkpONn/IaJl
         3c402CNMhSYL3+QflRgwK8flaRpy3OiPpU74kd44SaE8DgTOmSyvnWWFUAqcIaEzx6vY
         bgr6UCg5oPjJt3b5AyRXh/+PoFqeIi3V+yfd8w3EvADRp+MVC26LcGHmT/6ytHlGV90/
         zweBZ8rTMblk14n0VzzbeRkKc6lcPGCZIxiAg6IavMyHx0oBub0DDCAnDPSez/4fP0IB
         7giw==
X-Gm-Message-State: ACrzQf2VMN/2LZje+JBlRZK3IUJttZK55r9OzAkrRQG9SUl+rQa6R0Rk
        K+TrxRUKCPQy3DQYbQs/aqGsTmJIMj5aww==
X-Google-Smtp-Source: AMsMyM7YdJ+JXyCoIRK/AJcvzHRX/I3y1eRLizNmEhZtRP6RR1lZvBWy810YZeBDwTpa7OGf8oc+2w==
X-Received: by 2002:a05:622a:451:b0:35d:5b19:b8f with SMTP id o17-20020a05622a045100b0035d5b190b8fmr18392640qtx.620.1664851345604;
        Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id 1-20020ac85901000000b0035cf5edefa6sm11793875qty.56.2022.10.03.19.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 19:42:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v7 08/11] rcu/rcuscale: Use call_rcu_flush() for async reader test
Date:   Tue,  4 Oct 2022 02:41:54 +0000
Message-Id: <20221004024157.2470238-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221004024157.2470238-1-joel@joelfernandes.org>
References: <20221004024157.2470238-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

rcuscale uses call_rcu() to queue async readers. With recent changes to
save power, the test will have fewer async readers in flight. Use the
call_rcu_flush() API instead to revert to the old behavior.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcuscale.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 027b7c1e7613..21453a919c31 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -176,7 +176,7 @@ static struct rcu_scale_ops rcu_ops = {
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed,
-	.async		= call_rcu,
+	.async		= call_rcu_flush,
 	.gp_barrier	= rcu_barrier,
 	.sync		= synchronize_rcu,
 	.exp_sync	= synchronize_rcu_expedited,
-- 
2.38.0.rc1.362.ged0d419d3c-goog

