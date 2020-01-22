Return-Path: <SRS0=0ICO=3L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0978C2D0DB
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 17:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64CF21569
	for <rcu@archiver.kernel.org>; Wed, 22 Jan 2020 17:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiEOeaY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgAVRFA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:05:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39387 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVRFA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Jan 2020 12:05:00 -0500
Received: by mail-pf1-f195.google.com with SMTP id q10so132304pfs.6;
        Wed, 22 Jan 2020 09:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8QgKyiW0upu1Q+szE5cYtvDG9vOJuAl1OpeZnvTZVEo=;
        b=MiEOeaY9kdqB8tM2DEWTmU6WQEOBSN25csdV/dunSwN65KQayZ2vpbrRRSl12K9Jgu
         HXf86q8yhkgvpyxzQ5wvyyn6bbcqkAulGpMpU/x0X9OEwvxQRnihQCZOWHI3CoQhC/ab
         Qf5TsiHtNaSsqETuS5UXb+TdCqQgkf503b7rxEQhdKHvgCOcLym5G6AHto0rAdM74tw5
         QY1Uhxu9oMMLGRK9JBBN0WZIb2ls96L3wyHnj8n2t3JXNHSA8inI7gO6utTzlMBtm4l7
         H6YkYUWIHGzE2v9EyeUqismEmgPBQgYIWLMGp/VPvN8ivEl7lsopgw6o90oAxdUYzHzN
         3/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8QgKyiW0upu1Q+szE5cYtvDG9vOJuAl1OpeZnvTZVEo=;
        b=KAOsoFGSNaTYkd8fEzR9P6eb8qXeH2xRpqVwB4pPxg0/Ezagda1jfDfFBc/Xjw9bez
         1jRfRtjH0XayymcKjTmSwRcuhkXirCHcWAJNjuJoZB/mG6iuVfUyB20RTzewyPGUB5Js
         mA6oMnS929BLZd8qh5aqc5YkWw09VokUUQLL/FWrOGKDUbdE10tNoMnIENeGrxp6gB4m
         +jaaO+WeW7/e6t4kgdbhNu9q8cWAeV8K+7m+WUwgpOXbtGQ86HT9xEyu7AWJlDnNqmIA
         2+ur0bAn+SKcyiMbdsfRgpWLL22U7EQDk/udVZcW3vObq7n/slnTVJFAm3dYn64WB/+t
         V2UA==
X-Gm-Message-State: APjAAAVoA8GgdoV6sgOm1rDSuxBmZXrW7V8GTFKLRrbhlv9elp7PT8Fr
        dvKsq6uOZQTl1Nf/GGWQ1Q==
X-Google-Smtp-Source: APXvYqyX/P9oePdmnshAVZLFNwM9QuwuiD9JHWbvwEAoCgBTDQkKNh07krpp1ELPjLALfeQDppTOig==
X-Received: by 2002:aa7:96f9:: with SMTP id i25mr3471919pfq.161.1579712699709;
        Wed, 22 Jan 2020 09:04:59 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1eee:fc60:1df1:6c1a:3227:9ec0])
        by smtp.gmail.com with ESMTPSA id b42sm4001350pjc.27.2020.01.22.09.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 09:04:59 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH] module.h: Annotate mod_kallsyms with __rcu
Date:   Wed, 22 Jan 2020 22:34:47 +0530
Message-Id: <20200122170447.20539-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

This patch fixes the following sparse errors:

kernel/module.c:3623:9: error: incompatible types in comparison expression
kernel/module.c:4060:41: error: incompatible types in comparison expression
kernel/module.c:4203:28: error: incompatible types in comparison expression
kernel/module.c:4225:41: error: incompatible types in comparison expression

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 include/linux/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index bd165ba68617..dfdc8863e26a 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -429,7 +429,7 @@ struct module {
 
 #ifdef CONFIG_KALLSYMS
 	/* Protected by RCU and/or module_mutex: use rcu_dereference() */
-	struct mod_kallsyms *kallsyms;
+	struct mod_kallsyms __rcu *kallsyms;
 	struct mod_kallsyms core_kallsyms;
 
 	/* Section attributes */
-- 
2.17.1

