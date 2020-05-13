Return-Path: <SRS0=iD7o=63=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76264C433E1
	for <rcu@archiver.kernel.org>; Wed, 13 May 2020 21:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D56220693
	for <rcu@archiver.kernel.org>; Wed, 13 May 2020 21:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LekmvqEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgEMVq4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 13 May 2020 17:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729988AbgEMVqu (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 13 May 2020 17:46:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E6C061A0F;
        Wed, 13 May 2020 14:46:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so1269087wre.13;
        Wed, 13 May 2020 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x7qfOFMEOKghZEcX71PCTwgo1XxvppOm/912/nC3M4w=;
        b=LekmvqEeT7CWFd+FwUdPd3q2gBtje/kStARbBm7frB7NS5yaQgKFNy0IuuNIi1dHwF
         fDT+7xUPTKJZmIl9+2vMGLDZzxr5d9ypWVGYxAawanTdP9ZCXyX7pFmC346kIeaEAQjT
         KUQLfeFLNppUox+V3SUxoSbwEdxMATcBrwkYYdl7zu9GMqjASU3UMgsNns3iNLosPpKa
         eJRMpqF/Xjv28Tjb9tsJTm4uwZIdcJxZcOgofgUpZTfDsbpF+t/WqyDygWYb4J9o/Psk
         zvynEB97S09SHpKTT/zHMCyblgAqNOp9a4kBVw9Mqk7Vnvu/tnVTVw1Y1e4mSwHDZPTk
         OI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x7qfOFMEOKghZEcX71PCTwgo1XxvppOm/912/nC3M4w=;
        b=NC4TRKrDaRbY1jSTvfvo6JdGDzCXIspIIWhc+JE+rA1YXDXYVe2Ok63WHlQ2QWzsTz
         fs+8k+RtVpmc8jl5s7Vewsd0fnQHAqg9NJXU6V5cTWJrVYpM2e5I/GHxm1hRwDhq2YjA
         cdYxkt3a3iDCaNlym88Pq9FRHe4Wsx02F+jIebdC/Ms9AfPeuaiA4mIVWirrhZWPPsCi
         wHorli0lxo6OHBZRJSBfC+gUid6Nl6+3OTIPpEerkqVfN3W3gF1Q5w2KTvf3cOvG03MB
         ebn0ETcqxCgNOjTsUpNkFNjkF/IBZ7jfGZ3CVWx9OCk2j0iOj6zsAJaHvgwjEgD1tOY4
         EGNg==
X-Gm-Message-State: AOAM530gU0rVUjybJ9XzLYj1XRWCC8sj9jJ7fhzXLEtO3usjI2m9ald+
        m63+RdlEA6RyeaxNKwfNP/Q=
X-Google-Smtp-Source: ABdhPJyhzyhCGx2Cl8Yj4V9mytYwksNLzoK7ZBRAORJJ7ctb+CQVFtZJueuqBS6HuhgT0C1BnCwuNw==
X-Received: by 2002:a05:6000:128b:: with SMTP id f11mr1518962wrx.227.1589406409289;
        Wed, 13 May 2020 14:46:49 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:48 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: [PATCH 11/11] rcu: constify sysrq_key_op
Date:   Wed, 13 May 2020 22:43:51 +0100
Message-Id: <20200513214351.2138580-11-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

With earlier commits, the API no longer discards the const-ness of the
sysrq_key_op. As such we can add the notation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 kernel/rcu/tree_stall.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6afd20f..4e6ed7b91f59 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -729,7 +729,7 @@ static void sysrq_show_rcu(int key)
 	show_rcu_gp_kthreads();
 }
 
-static struct sysrq_key_op sysrq_rcudump_op = {
+static const struct sysrq_key_op sysrq_rcudump_op = {
 	.handler = sysrq_show_rcu,
 	.help_msg = "show-rcu(y)",
 	.action_msg = "Show RCU tree",
-- 
2.25.1

