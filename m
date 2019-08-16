Return-Path: <SRS0=HCMS=WM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F68C3A589
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 02:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF1A2086C
	for <rcu@archiver.kernel.org>; Fri, 16 Aug 2019 02:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="gdQSJruo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfHPC7c (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:59:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43358 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHPC7c (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Aug 2019 22:59:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id 4so1829907pld.10
        for <rcu@vger.kernel.org>; Thu, 15 Aug 2019 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5TOZw4aX2ouYHWL3SPiBVA6qRZbVTxguU44+pODdzqI=;
        b=gdQSJruoAM1XM+3a/CIqDvm0o6MwERJuLTfpy9OI9EGyi8eqi1yTpNYOYc1pMFygim
         Mj0B864cQw1184rdHxkBe+b5EoTA7r8bRQv+vewlFkxnjYXVlvmIUEPqYeHeaxcuY2kj
         DZeEWsiHhMJMcd0pt4KxN4CQTl7VmYJBYI89Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5TOZw4aX2ouYHWL3SPiBVA6qRZbVTxguU44+pODdzqI=;
        b=e6HYPvjEuKesQZtLekUK9qtEQHCIKJB6rqj2JYw5lKUCsh+lu6QcAleNaYSroC1VJW
         fFd3wqoBqxF4lT0wX4a8svl+wIsYXp8m0DZvitRy7fYLFyUKoL81BQKg0VAZU+wL5/CD
         Q2INVwrYPISF2tru8DUR17s6nIh+FRq1B85Y0MXhOspCYc1nMt7rK4cravWZrvD3S1tD
         ODHhkb2D35V8wKeXl4sesRyzCxDvL4m2WtANziBGxg+dUgYKzcHEzXELwhJwdWdOv/CC
         fFknu4UGsnc3dlqi8doxqjmX6I7/cTYw9cw6TSTFBeVY5ig/LxjCP7l415BpPqzAwzCv
         jHpg==
X-Gm-Message-State: APjAAAWw9v+ZOJBbhXx62svWhkd+aSwEU3tDjBoltvzY8C1wgiR8SM+h
        IsdVaSnD/uQvPZBI6agRbgz4aA==
X-Google-Smtp-Source: APXvYqzOsc28s9gVz0EkrhaSrs5/PUB6mUriwSSU1aeKlkoNXVLriuQGGqrLsSQSAAAn3wdPYB2XOg==
X-Received: by 2002:a17:902:424:: with SMTP id 33mr7238481ple.34.1565924371577;
        Thu, 15 Aug 2019 19:59:31 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id v184sm3378377pgd.34.2019.08.15.19.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 19:59:30 -0700 (PDT)
Date:   Thu, 15 Aug 2019 22:59:14 -0400
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        frederic@kernel.org
Subject: [PATCH v2 -rcu dev 2/3] rcu/tree: Fix issue where sometimes
 rcu_urgent_qs is not set on IPI
Message-ID: <20190816025914.GB242309@google.com>
References: <20190816025311.241257-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816025311.241257-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Sometimes I see rcu_urgent_qs is not set. This could be when the last
IPI was a long time ago, however, the grace period just started. Set
rcu_urgent_qs so the tick can indeed not be stopped.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 322b1b57967c..856d3c9f1955 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1091,6 +1091,7 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (tick_nohz_full_cpu(rdp->cpu) &&
 		   time_after(jiffies,
 			      READ_ONCE(rdp->last_fqs_resched) + jtsq * 3)) {
+		WRITE_ONCE(*ruqp, true);
 		resched_cpu(rdp->cpu);
 		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
 	}
-- 
2.23.0.rc1.153.gdeed80330f-goog

