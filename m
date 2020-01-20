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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BCCC32771
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9812D2253D
	for <rcu@archiver.kernel.org>; Mon, 20 Jan 2020 22:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYWeJot3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgATWmc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:42:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38238 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATWmc (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jan 2020 17:42:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so1197585wrh.5;
        Mon, 20 Jan 2020 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0L3ToNp7LhY3DK3xO1yTKSXSDNycL2deH/HtxcERgk=;
        b=JYWeJot3cp4ClogdkR63OFM9MaU5lJoKPtL4gmFQq7cynXP4BrVvWuBwtH31k2S3hT
         /dJCSvM36AGIA+5ItSmMTfO6lfFLJ+4LeXZUl73IrvIkNV62FspmwAt0qJi+sKmDTcDs
         0iTFA9usUVqDmxLwPH5sKi+PYD5UfxdwRs0HCHyjweywx4SqRUVoI7Q3c3BskAbod/xi
         X2M+T8kVJI2OoD+IrZmpz0dlu2cHqFPJqbfNjqxhkxhPeuYcUmIT/uvS1+v14ewcpYE4
         leO1xRvCe+vqehxQdP6qkM3lAHbJE4wYmi3Yrh5ekC6umWDDBKCnkuk+mzgv95vl5Nnh
         Nb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g0L3ToNp7LhY3DK3xO1yTKSXSDNycL2deH/HtxcERgk=;
        b=re5HULqppVfRrMDunoVMDcZcin7qKp8yQmpV8C9N4GdRFQf6JfcaoHZj+fQuU52HR3
         r2XrSue9fBuWsDPcHYULzKn8YkrH2ozurp1Aznl5zemOk1j1exA82R+hiti0CmGZmtrW
         JiVfcCCvHHSQCrJodLOO0I4FwXqy7l6vrW87pWG1eNlidPsPgk/04YCIp7ZFuqSRs0GL
         h000ijo/GMfEw8Okka7q//664D37kCtnugIHpXSYRvfGlNRZu94xvkwH0tNZF+eN+0jH
         pkgcNMiEfeudY1bnMHflehJDS6e2WlT4P+UGUHdfUUKOcorY4JMiQBqDbyikAHzKaT8B
         rgWg==
X-Gm-Message-State: APjAAAXjt0/PesaOReZby3uP5L8fczb8xUYbB/HXQ6d05uN2BrK5uZcg
        s3XJ4zTlF51bmerEeJG9TQ==
X-Google-Smtp-Source: APXvYqxIuRCApE90IE5cyPzRo77BUNVxgJBNExAodDIeqAAidIIl9N5HHLYRAyw7ZCjYeqKWU4KjsA==
X-Received: by 2002:adf:f244:: with SMTP id b4mr1594079wrp.88.1579560149640;
        Mon, 20 Jan 2020 14:42:29 -0800 (PST)
Received: from ninjahost.lan (host-92-15-170-165.as43234.net. [92.15.170.165])
        by smtp.googlemail.com with ESMTPSA id s3sm1082055wmh.25.2020.01.20.14.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:42:29 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     paulmck@kernel.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        joel@joelfernandes.org, rcu@vger.kernel.org, iangshanlai@gmail.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 4/5] rcu: Add missing annotation for rcu_nocb_bypass_lock()
Date:   Mon, 20 Jan 2020 22:42:15 +0000
Message-Id: <20200120224215.51740-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sparse reports warning at rcu_nocb_bypass_lock()

|warning: context imbalance in rcu_nocb_bypass_lock() - wrong count at exit

To fix this, an __acquires(&rdp->nocb_bypass_lock) is added.
Given that rcu_nocb_bypass_lock() does actually
call raw_spin_lock(&rdp->nocb_bypass_lock)
in case raw_spin_trylock(&rdp->nocb_bypass_lock) fails.
This not only fixes the warning
but also improves on the readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fa08d55f7040..7689e649b674 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1510,6 +1510,7 @@ module_param(nocb_nobypass_lim_per_jiffy, int, 0);
  * flag the contention.
  */
 static void rcu_nocb_bypass_lock(struct rcu_data *rdp)
+	__acquires(&rdp->nocb_bypass_lock)
 {
 	lockdep_assert_irqs_disabled();
 	if (raw_spin_trylock(&rdp->nocb_bypass_lock))
-- 
2.24.1

