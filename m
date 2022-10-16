Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47690C4332F
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 16:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJPQYb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJPQXt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C7E3E777
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id s17so4220079qkj.12
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEECeHAL+4jB0ct1Miev7aIBczUJQZG4eKLvCmwiPRs=;
        b=vycGQD6tA80I0QDKMFJTpotcypYOCSzuyXbA3dDGZ+CQ3qQXHGtK09Uyu/ySS6wEgz
         R1JZoCZzhHxNamY1N5+s+ejOngl986X9jX9JUINf4V7BiHU5I2RKenhW+E7rJP5jWT0i
         Uq4tY4W2tzoj5+A+DEuaoGo1/Ikue+EBnX/nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEECeHAL+4jB0ct1Miev7aIBczUJQZG4eKLvCmwiPRs=;
        b=3AeojSQaCb1QzPbnzqmI++bTTgK0ZuBx/5SMM4x0SDcPBEaGNMaJ5ZQ43tLFzf4kKF
         6/0+RFJePlhfRqjmIE3munbSzE7yO5yXNfULysMhHQTvS1Es6DMAWm/3gwA37Y6n7c1O
         vsK/540MrO7CgTXdcge720UfoI1xJ24cglUpBEkYx0DI0r/Rr/pPgKkCF1d1ERLufEAy
         b3ePmY34J6AhWQ5Ed8u7fVLKNA8VpTWjFvQhtpbjIAYsbYOMypl5lTzdJ8Je7CfIElpO
         HhRnJMvT6lajBmOkTifmhCV52PRK8rvCTxPD6o6otRbC/SHdfTmY0qCyFhUUff42TnlM
         haxA==
X-Gm-Message-State: ACrzQf3o+ni+vXLxwcSWoeitPrGtI8nFQGwaqzxNMPfWo0UQU4oWRGbK
        fFTNK9nVHcL4Gu4vGBeL1W17eECtf8unEg==
X-Google-Smtp-Source: AMsMyM6MJvpR4qN9Qf8W9sEmrAa31zNShOitpR3AR8H6469FrfXoVDD9kmtONXlTehG2QxLw02YKcA==
X-Received: by 2002:a05:620a:e:b0:6ee:86e5:66f8 with SMTP id j14-20020a05620a000e00b006ee86e566f8mr5013762qki.163.1665937419752;
        Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:39 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 08/13] rcu/rcuscale: Use call_rcu_flush() for async reader test
Date:   Sun, 16 Oct 2022 16:23:00 +0000
Message-Id: <20221016162305.2489629-9-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
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
index bbdcac1804ec..0385e9b12399 100644
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
2.38.0.413.g74048e4d9e-goog

