Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3D4C433FE
	for <rcu@archiver.kernel.org>; Wed, 16 Nov 2022 01:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiKPBxP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Nov 2022 20:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKPBxO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Nov 2022 20:53:14 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C625E9D
        for <rcu@vger.kernel.org>; Tue, 15 Nov 2022 17:53:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w23so8656869ply.12
        for <rcu@vger.kernel.org>; Tue, 15 Nov 2022 17:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwuUkRB/lujYojsxd4iWSgvrqBxD7QF8RfAcxgDGTwM=;
        b=TfoFx5ilAAgoPfddEQhNcGSL77eotD5jPbvs8MHJpV22dW/2iJ7zMtf1/0QXiWK4wD
         g1VDbDGkojv0VMwEfPqsXr/WESP6qYhktZwmP/Cw7b9ehh9hD5YhHfC287kCVU1cgQfi
         lzUtR3ApPf/Xb17rpd1kjMxseqves+Ic0fgrMW43XKZ3o7nEj9I2EYsaV2cDE/TBynla
         mfe1JNRZXXiJEAucYY2qzPpCgrs3QpeaC24MFEvmiF6AtlDDah18cvyf5XUE0o+c5HE5
         rKhY9UjagItwjSBaeZK19ErC9KBUI91vhUwVG0jgky6pE/KfBd/TbQD0/SM0Vr7Pa/DP
         2u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwuUkRB/lujYojsxd4iWSgvrqBxD7QF8RfAcxgDGTwM=;
        b=Ax7dlJ6ajeSAune+mTjvljZZgED01aEmpygae+eIighdPHHIYMwPOogmxZ8OEmp7D4
         yP9FMv5YH+U29wEXpPi5n3c+BlA4vEiT3cK/+hn6tx5DhjFXvcHqyjurQufonwdnq07Y
         H87h0H5buVpeWTYrkZQt5w6cnfo+JL/YRPjIMhZq/vaitrX5wQvwRE3u1D1FPhjdrtu8
         VfMGR92pfrGm6U5KozgZHcZfzexCr58VJcr5tYTur8eDSavknvhl6snT/0kZhsAsZzka
         wFAEKPAKji/Fh9bj5ZVRKU7n0gzt5OVxZ7w3xYwok6bar9GFCxjp1gecgJHN8c9Jmr9N
         E0qQ==
X-Gm-Message-State: ANoB5pkxo3vaBDgiwKKK/9AJm3yMSFnj4PywyZenxdI+tXli80r3TWhK
        YYTvf9oVsmSruqqLWfcCJ9Qp6WMTKQ==
X-Google-Smtp-Source: AA0mqf49SjUbG+b0IXMCYvWl22DRkanCjnucpFSqgoS9a0vc0oYOuj5Dmf7vuHVqnrumUg29rmozNw==
X-Received: by 2002:a17:903:40d2:b0:186:7a1d:b6ee with SMTP id t18-20020a17090340d200b001867a1db6eemr6874957pld.67.1668563593374;
        Tue, 15 Nov 2022 17:53:13 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mg24-20020a17090b371800b002071ee97923sm234217pjb.53.2022.11.15.17.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:53:12 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     rcu@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 2/2] srcu: Fix the comparision in srcu_invl_snp_seq()
Date:   Wed, 16 Nov 2022 09:52:44 +0800
Message-Id: <20221116015244.10539-2-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221116015244.10539-1-kernelfans@gmail.com>
References: <20221116015244.10539-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

A seq contains two fields: counter and state.

SRCU_SNP_INIT_SEQ is used as invalid initial value for srcu_node GP
sequence numbers. Hence srcu_invl_snp_seq() should compare both fields
of a seq.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: rcu@vger.kernel.org
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..725c82bb0a6a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -154,7 +154,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
  */
 static inline bool srcu_invl_snp_seq(unsigned long s)
 {
-	return rcu_seq_state(s) == SRCU_SNP_INIT_SEQ;
+	return s == SRCU_SNP_INIT_SEQ;
 }
 
 /*
-- 
2.31.1

