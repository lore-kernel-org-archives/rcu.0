Return-Path: <SRS0=upIL=VI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03DDC742A2
	for <rcu@archiver.kernel.org>; Thu, 11 Jul 2019 23:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B532D2171F
	for <rcu@archiver.kernel.org>; Thu, 11 Jul 2019 23:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="POP2I6vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbfGKXoX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Jul 2019 19:44:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42736 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfGKXoX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Jul 2019 19:44:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3450861pff.9
        for <rcu@vger.kernel.org>; Thu, 11 Jul 2019 16:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GuW47+ITVwlHRyFWoit77iH8wSxBVV56wbG/AJ8g+A=;
        b=POP2I6vcsX7mrpLNszrDZ3jHjn5JeGjYvt0TIBarOc+TTSSHTMCxN8ZJl3umrbGe13
         LL/K6XJbcw8liWBMr5VJm7tJsyYXkpeSHOo93Z5cFDVSa8Vym2EQZ+vSjFXjz8J4Wkoy
         ABgjJP8Cfel0JsMbqaLz7L8BjEej7RSdpehss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GuW47+ITVwlHRyFWoit77iH8wSxBVV56wbG/AJ8g+A=;
        b=oe68Ae7jt2ldA1aJ3ivWwMG8G7RDwwPcQyFRLmK/j9jF1t9FHZ/Kpm85NwtQmKAHC8
         LEvN7U+6utZ3zWAzdy94FDWMtXDUsM1K7Fahsy8Y+0AyVchWD2c9H21yCvls5SRAXHlu
         4fWlAWHYWtEPf7I2f3VH1ziDoPd8PqGsbAX7PKSqhazf9Irn7BgzOGv47f+6yXNDA+SA
         TK6ZbVn76eW5JnvV8gNMhhMe1rfzfMXG83OYMxie7vol6LOzHQGDrI8M09wkASKYMfT+
         +v+JER+mlEim/WuGW755+9XdT9XFbJvpN93orbPonUwShxU2lOiM9YjRYjCc2yTdx1QU
         nwYA==
X-Gm-Message-State: APjAAAXa18tZO6B/jGYJ5Wf6gI71tm8qIoFNpd1WS3hTe+awpMiCxVN1
        PKYbk/huASalQDjVttDX0cc=
X-Google-Smtp-Source: APXvYqwL3radJMAbdECmS/G+TOrWXAIf4q3T6x0oa7czoYNYGbVr9jTCwdHXMM+5nal4G43CSaqnjQ==
X-Received: by 2002:a63:3f48:: with SMTP id m69mr7029829pga.17.1562888662320;
        Thu, 11 Jul 2019 16:44:22 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t10sm6163450pjr.13.2019.07.11.16.44.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 16:44:21 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Borislav Petkov <bp@alien8.de>, c0d1n61at3@gmail.com,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        kernel-hardening@lists.openwall.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neilb@suse.com, netdev@vger.kernel.org, oleg@redhat.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Pavel Machek <pavel@ucw.cz>, peterz@infradead.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH v1 2/6] ipv4: add lockdep condition to fix for_each_entry
Date:   Thu, 11 Jul 2019 19:43:57 -0400
Message-Id: <20190711234401.220336-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190711234401.220336-1-joel@joelfernandes.org>
References: <20190711234401.220336-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/ipv4/fib_frontend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index b298255f6fdb..ef7c9f8e8682 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -127,7 +127,8 @@ struct fib_table *fib_get_table(struct net *net, u32 id)
 	h = id & (FIB_TABLE_HASHSZ - 1);
 
 	head = &net->ipv4.fib_table_hash[h];
-	hlist_for_each_entry_rcu(tb, head, tb_hlist) {
+	hlist_for_each_entry_rcu(tb, head, tb_hlist,
+				 lockdep_rtnl_is_held()) {
 		if (tb->tb_id == id)
 			return tb;
 	}
-- 
2.22.0.410.gd8fdbe21b5-goog

