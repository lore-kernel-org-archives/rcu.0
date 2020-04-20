Return-Path: <SRS0=AG5q=6E=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565C1C54FD0
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35013206F6
	for <rcu@archiver.kernel.org>; Mon, 20 Apr 2020 15:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QXhjMscJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgDTPjF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbgDTPjC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Apr 2020 11:39:02 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF196C061A0C
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:39:01 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c16so8847238qtv.1
        for <rcu@vger.kernel.org>; Mon, 20 Apr 2020 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcc0Wlav0FsTVJwVQ2AzBgPdfSD4p+1T7p29iEMrsoA=;
        b=QXhjMscJLEN1Xb7/cRhdNbtsc/FTLmDNHUqXblfXO+STa/oRDtChQgBRItNEcP3eNn
         1Wh24G9Wu1Nl6cdTVGWxZnJTp27TCv2bkujDGXmhMsvRIin/WNCgvNzVlLdT1JCDYlS6
         hhMgZlC6UQvY5QRZakDyzZWOaYP9x1frn2V1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcc0Wlav0FsTVJwVQ2AzBgPdfSD4p+1T7p29iEMrsoA=;
        b=ECHHT4dznRMsD9v3Tm4x/IGgZoo6VFX2W5A821K5/yPW9Nab8qfC5ESn5qRMkVxW/s
         2AMHjf+a/hLub4wx2ALKlfRJIpWzdaBXFJK1tWo4Ujp1hZXUtkeqeI0D0Ml+5pqDzNNF
         S9aor6k1bDadkAVP8ZksMPU9mEt+CZ9gkozRWReOf87MBTNnwVfXlTZINq+NXEYa/U7L
         8BTZnoxuRu/nhKATq3JsU8lSeptzo9xQRIkJMD4vEX1LXKRt9VANWVmd41EBjBmysPh8
         v81FVXEtPulTeFpXSpGA5SV4bV38BKx1maqYKPVMiMWTAODRdYvisEiDYQ+eSIWwyBgK
         ICrA==
X-Gm-Message-State: AGi0PuZD/IJOqETGfk/iyCekQ5iuEVAxV0Jx0gwjLYAuWvq/MaWODB1t
        2CUBY8V3jEvCc1oqYXNlb72gtA==
X-Google-Smtp-Source: APiQypIPDukJ93IS4iW0yXmsvSzB3DJRdlglu/CEk9JLy+UI3nLbWM+Ln2cWb3eT1ITT86TzrWgiCA==
X-Received: by 2002:ac8:5256:: with SMTP id y22mr15799428qtn.321.1587397140926;
        Mon, 20 Apr 2020 08:39:00 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v16sm765453qkf.80.2020.04.20.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:39:00 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH rcu/dev -fixes 3/4] rcu/tree: Avoid using xchg() in kfree_call_rcu_add_ptr_to_bulk()
Date:   Mon, 20 Apr 2020 11:38:36 -0400
Message-Id: <20200420153837.194532-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420153837.194532-1-joel@joelfernandes.org>
References: <20200420153837.194532-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

There is no need to use xchg(), the access is serialized by krcp->lock.
The xchg() function adds some atomic barriers which remain hidden in
x86's disassembly but are visible on ARM for instance.

Replace xchg() with a load + store.

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cd61649e1b001..f6eb3aee0935e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3088,7 +3088,8 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 	/* Check if a new block is required. */
 	if (!krcp->bhead ||
 			krcp->bhead->nr_records == KFREE_BULK_MAX_ENTR) {
-		bnode = xchg(&krcp->bcached, NULL);
+		bnode = krcp->bcached;
+		krcp->bcached = NULL;
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

