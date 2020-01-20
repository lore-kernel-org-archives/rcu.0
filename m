Return-Path: <SRS0=Bg9d=3J=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B52C32771
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC9222525
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/ONJGbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgATWlh (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:41:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45107 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATWlh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 17:41:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so1141679wrj.12;
        Mon, 20 Jan 2020 14:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDWSSJBZQa8HlVV6FvLApvQT2M9iuui0osv97v1mf5U=;
        b=V/ONJGbmkMt7TfgtnTxNyEu3qil+wkpPlU9kw0sy23a33hrFcxzNdVVENcucOE4gXo
         BGI1oIN56w8H6TbXahObOuHtyK5zt63UmJ6EFq72Suu/S7ReGPfnRRfYbLZFDrR8+9D0
         fS3AYyYGc+00zuFnt5gGRE7GVRR+2/D9g7G33n9CW92KPVYsurgOvvRy68CWkehRM56g
         sxPpa9bZ44pPzJoA7eRAz+kwDXSO8wrNesZelz5iMElEPXmPZypYRX9Ttn92rJD+M8+4
         AKcPEy5qMWIGNEwHrCLfcDIZF3RgMcs6nztVNzm3DDwuKKGZHMjiNvEP4fvaWpYFB7kb
         PyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tDWSSJBZQa8HlVV6FvLApvQT2M9iuui0osv97v1mf5U=;
        b=CXv0wsLUsVKEg/va87UYdgF1hhaVCIz9A/U2ywbFS9vk3hNNR83eAYFxH6TW4nJYuY
         etkO3A0QgyiFgGlbu4DRtXZxbhj+cwRpYiiK+Hz3w08yH3UwggTEIxY4urGTE6slt9Yf
         cJhPYxmpIC7FLPqv/XAW4C+X/y5JkZU1US5yarAZ48cr28Aby0cTEjydlJ1K/UbhO2hf
         mrfhdqgVcwqR8mfCw5m9eWtwgekc+gbl1bkoJ2BFQjjp29LLpF2uv55TPk6UbXrZ38Tj
         CwOT9IGh3pb2nHxVoWwYndNmNT2HvkkTV1Gg/Pu2CyqnUk+9CD6k/2RgkHJVJ+toNitO
         vnEA==
X-Gm-Message-State: APjAAAV+b1O4fQ1KnjUyGo7fPRCdKaWwrhSJhLo71nEX4fNqDFVs6JLL
        kcVCOqX6NwIbSNOTRPWGyg==
X-Google-Smtp-Source: APXvYqy8LPxDnidMN0QFhJIAgk1t7ivmtN5M+EQstEV0Yqap5i2TLkbjFws42RlQWPPZnY/UpEUAyg==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr1652174wru.52.1579560095301;
        Mon, 20 Jan 2020 14:41:35 -0800 (PST)
Received: from ninjahost.lan (host-92-15-170-165.as43234.net. [92.15.170.165])
        by smtp.googlemail.com with ESMTPSA id q15sm49438371wrr.11.2020.01.20.14.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:41:34 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     paulmck@kernel.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, rcu@vger.kernel.org, iangshanlai@gmail.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 2/5] rcu: Add missing annotation for exit_tasks_rcu_start()
Date:   Mon, 20 Jan 2020 22:41:26 +0000
Message-Id: <20200120224126.51615-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sparse reports a warning at exit_tasks_rcu_start(void)

|warning: context imbalance in exit_tasks_rcu_start() - wrong count at exit

To fix this, an __acquires(&tasks_rcu_exit_srcu) is added.
Given that exit_tasks_rcu_start() does actually call __srcu_read_lock().
This not only fixes the warning
but also improves on the readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 1861103662db..99f4e617116b 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -801,7 +801,7 @@ static int __init rcu_spawn_tasks_kthread(void)
 core_initcall(rcu_spawn_tasks_kthread);
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
-void exit_tasks_rcu_start(void)
+void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
 {
 	preempt_disable();
 	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
-- 
2.24.1

