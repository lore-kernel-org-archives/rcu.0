Return-Path: <SRS0=nxXf=6M=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C4DC83000
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F67206F0
	for <rcu@archiver.kernel.org>; Tue, 28 Apr 2020 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUSGgt+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1U7d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726764AbgD1U7c (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 28 Apr 2020 16:59:32 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576C5C03C1AC;
        Tue, 28 Apr 2020 13:59:32 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so238403ljg.5;
        Tue, 28 Apr 2020 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VbhSWD62l8JNzTfQeyAoSUlyMJCSOqg1BrQPjTRkMk4=;
        b=lUSGgt+CcioWbfGLfJs6ugC+Qsrh1jSAzKgYq+RqTEJ21PFv8tQASSylCGa3PsVbnY
         Qbu76q5eTVYVtQnCst4OOtW3BlwytMXJWb+FeiUODQpsMPCiLZgDtu394oLx3qGFh7ro
         CUV0dDmlU2XxAMYHQI4Iaz5+oMKXtr10rhPCmkBZRvY5UTTkNFQPY9dtPCQASLAKSgpw
         k79dHaNBrymsYKNqoM41Bh4gmnO22eY5dnHBGtSZ2n8G2cPbYpP+IP3MuBpoa2Vbj82P
         SRpq3tfsb9HM1/p3VUJqqfJs4WInmGwQPVyQhTibtyUcbpA1vCW1XkZURvjniAH8QJSV
         JoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VbhSWD62l8JNzTfQeyAoSUlyMJCSOqg1BrQPjTRkMk4=;
        b=FF7luBItHwJ9WCFio7q/pdd963cYwotKbOh56CGAlavzvSnUmQ6ZAxfJt/MTrzeE3s
         rMUZ/gG3pbyMMCeR25rbP0P8RxYuQTameJubdrQ3IU2Gfh0NMW5J+ga6oGtTANkUzif4
         EMJ9YzusEUVSpMh0lkaA4HLi5SiQmqojgmxV7GfbjRrGZFo+BFyf2fcK4Q8L7PY2KrJK
         KI4mH5xAGTVqt/AzyJB83DnWz8Efp9iVoyKvAbAb9fh5y1HOFRvQ34EmcfTlL2OEm2dC
         emUHGZNthnxnqr+SWXR10NRwn7V/7EjRIyDJc4c4wsykewWkLMwTjUSsNsT2N8O9ope+
         15iA==
X-Gm-Message-State: AGi0Publ9NWQv6HsEJ1f2rg1yK8KFkU8ZHa8YSN6RDfzHHSVE89a3fAz
        NUOcexUzdBEeyjmXn1q2P/HBTSoXyRkuNg==
X-Google-Smtp-Source: APiQypKKGOVXhlmChW4BhBJ3iFPhuFW9qb1gS4bvnz1pm04t1mdMolucRbZxXE4S2RJ5qLuMNAg/SQ==
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr18386730ljo.167.1588107570458;
        Tue, 28 Apr 2020 13:59:30 -0700 (PDT)
Received: from pc638.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id z21sm295483ljh.42.2020.04.28.13.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 13:59:26 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 02/24] rcu/tree: Skip entry into the page allocator for PREEMPT_RT
Date:   Tue, 28 Apr 2020 22:58:41 +0200
Message-Id: <20200428205903.61704-3-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428205903.61704-1-urezki@gmail.com>
References: <20200428205903.61704-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

To keep kfree_rcu() path working on raw non-preemptible sections,
prevent the optional entry into the allocator as it uses sleeping locks.
In fact, even if the caller of kfree_rcu() is preemptible, this path
still is not, as krcp->lock is a raw spinlock as done in previous
patches. With additional page pre-allocation in the works, hitting this
return is going to be much less likely soon so just prevent it for now
so that PREEMPT_RT does not break. Note that page allocation here is an
optimization and skipping it still makes kfree_rcu() work.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cf68d3d9f5b8..cd61649e1b00 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3092,6 +3092,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
 		if (!bnode) {
 			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
 
+			/*
+			 * To keep this path working on raw non-preemptible
+			 * sections, prevent the optional entry into the
+			 * allocator as it uses sleeping locks. In fact, even
+			 * if the caller of kfree_rcu() is preemptible, this
+			 * path still is not, as krcp->lock is a raw spinlock.
+			 * With additional page pre-allocation in the works,
+			 * hitting this return is going to be much less likely.
+			 */
+			if (IS_ENABLED(CONFIG_PREEMPT_RT))
+				return false;
+
 			bnode = (struct kfree_rcu_bulk_data *)
 				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		}
-- 
2.20.1

