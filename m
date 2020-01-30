Return-Path: <SRS0=LYSJ=3T=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FD1C2D0DB
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 00:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641E4206A2
	for <rcu@archiver.kernel.org>; Thu, 30 Jan 2020 00:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPg9s5tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgA3Aa0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 29 Jan 2020 19:30:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35472 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgA3AaZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 29 Jan 2020 19:30:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so2134506wmb.0;
        Wed, 29 Jan 2020 16:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXuXlcYaFybhZK1QuyNgDHIHxuFl+Ricrrn7dPKgOpU=;
        b=pPg9s5tX1/hohT72JS+QDkLFoGqmfB/XaHf6yg7/jcblENm75u/+9Sl+yQHCc94SKI
         zLoPOlxuHhG1OdbNAyXgh5FZVipwTYXOJR67wLkdcJhdoD8/QvIaBjXqHuqSixS3Iu26
         zDceuYL4PA4PoB49Iy4CfmPo4hl8wpvAo96JJ52804N5tHFzcQIXbkfzF3SYhIvl05PT
         uwX5vU9PmthXgf9rQAScrnjL5ZUS+tVbc7tCpsmbSOeTVUDFYL7iqmIoxudjdrSuU5cp
         Zpm/ARGuqHmKyn+28Ftg3oDU1T6DEkDTa0TOCJK3t50BHsROSKL78y/vjiH20JSLc8A/
         WaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXuXlcYaFybhZK1QuyNgDHIHxuFl+Ricrrn7dPKgOpU=;
        b=V7TdbAyRpEgVPVssCj3qyWYMXVEitrjdBTScua2yYbl0GWe3UvXSBOxCaYNFbcbgRj
         W+qII+Bb8XtrkPU7sbJ/lA6UA1qhZ4OsItMKegnaCx7DJwxj1FE5CXrotRRBhL747Yej
         erajWiDgxSa0o6e8mARpVB60qS5LSRlgeCKSzlbItAmIWAQK19Dt3htwB8xY1WIWKx4f
         dOTqPXegDPGKwX8xCiDsNb8d6g+lPBG1Peua6KR/pG9fIB01hxwAuAm/0C+40kR4nwiJ
         +Tsi5taw40qlJAbErekj5UPexPr+D/DrOILFzpKRjhyd9l8t7vdDBCdqcHOGVa64aQD8
         qBhg==
X-Gm-Message-State: APjAAAVrYNocQntROamIT6WDh8oGQ/uPA0z+3ZhHtvWlmIYb6WtVj3Fr
        ujVmNdmbDTef9pI0jE2ZbA==
X-Google-Smtp-Source: APXvYqyUxbLDQUOJnk4TfX1NU5mYiXT9GRYv4ft2uoUmMv/0O3z5CsV4F7GZiGd17qPKYGcUGMINyg==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr1870894wmj.170.1580344223698;
        Wed, 29 Jan 2020 16:30:23 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id f1sm4946356wro.85.2020.01.29.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 16:30:23 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, jiangshanlai@gmail.com,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        josh@joshtriplett.org, paulmck@kernel.org, rcu@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 2/2] rcu/nocb: Add missing annotation for rcu_nocb_bypass_unlock()
Date:   Thu, 30 Jan 2020 00:30:09 +0000
Message-Id: <59087bdc398a69ac743ee3e5cfa0bd26495881e3.1580337836.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1580337836.git.jbi.octave@gmail.com>
References: <0/2> <cover.1580337836.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sparse reports warning at rcu_nocb_bypass_unlock()

warning: context imbalance in rcu_nocb_bypass_unlock() - unexpected unlock

The root cause is a missing annotation of rcu_nocb_bypass_unlock()
which causes the warning.

Add the missing __releases(&rdp->nocb_bypass_lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9d21cb07d57c..8783d19a58b2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1553,6 +1553,7 @@ static bool rcu_nocb_bypass_trylock(struct rcu_data *rdp)
  * Release the specified rcu_data structure's ->nocb_bypass_lock.
  */
 static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
+	__releases(&rdp->nocb_bypass_lock)
 {
 	lockdep_assert_irqs_disabled();
 	raw_spin_unlock(&rdp->nocb_bypass_lock);
-- 
2.24.1

