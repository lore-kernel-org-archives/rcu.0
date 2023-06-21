Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C36EB64D8
	for <rcu@archiver.kernel.org>; Wed, 21 Jun 2023 02:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFUCdc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 22:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjFUCdb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 22:33:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52D7B7;
        Tue, 20 Jun 2023 19:33:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b5465a79cdso22328945ad.3;
        Tue, 20 Jun 2023 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687314810; x=1689906810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfktoJD/McKDXPEAYo4ZmtHg2u99iMZJ4yXppCi89l0=;
        b=p20FW5sp0sL/DKIuel7h/Z+q4KMtjws+ZwRhTMLsNdbtENbGlSe89iLoXpVQR9l47O
         0xPd73i2nzjaQhbKuL0V6N/06edDdr3Edi7NDcwDliKiulfMMX/Zw4CRyY8esvhxgkc/
         iEitprfELcceVoxEkrxbbp+Q7ZKuWvEwbTU9v8cO8ZbKQvtlQYDz6tNCl/gtzN6+vGvg
         Yvj8NDQgQtXAJmCx5PZC03Dj9Ic/Z8rNTPIi2YO8E7euE8oh5G9F/NqXdsdHiR6x6m+k
         XSNBiYu01GimsDyYilVloeUVPSTO9wszic1eycY0oVGMs2/kwYYjBwB6Pa28sWKkksC5
         b+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314810; x=1689906810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfktoJD/McKDXPEAYo4ZmtHg2u99iMZJ4yXppCi89l0=;
        b=OEVySKhdFtk4zHf8PItge82qir5Yv9W2BXp68jxxYwR7ONwUb5FQmNQNuXTXb4IB0W
         phlDXMNAHtTrG5eQf+nOAdWRosxd53bzWZruiMREnuwaSzq5iMxx/OZcUaoC8aNYMYvV
         3wDKV5+V5I1hWuyRHX578A6JyMLpzlBNp0iegYqshdtB2PvyUccSCsOwr1q9b388WOoE
         kyW0H3kTDjCyHl93btYLxvCj93gbvJI+D5cPKI97hyovHRzXfV4AMBWc68HRf0mBHlVC
         Qvk12MXYmQMgUDdpMb8d1lAFqmKxPUO9GwlO1EEsciDFDdHUjMQP6idsmd/ACmo3nS7R
         jQoA==
X-Gm-Message-State: AC+VfDyudqetcBH5ieGWNo73D8INGVD3gmHk9FT3/m1xwNDkPeef139+
        6MIj4NXIqW9bVfyroiTtBIs=
X-Google-Smtp-Source: ACHHUZ6VrWYH+0RQ3hURKAf10UHuTT98N8h9jJbfCXdyJrCMpPHqDCPfDIrOtjzPE4L2DiaMjFqyyw==
X-Received: by 2002:a17:902:bb10:b0:1b2:665:d251 with SMTP id im16-20020a170902bb1000b001b20665d251mr11334285plb.47.1687314810171;
        Tue, 20 Jun 2023 19:33:30 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:e719])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b001b0358848b0sm2242831plb.161.2023.06.20.19.33.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Jun 2023 19:33:29 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 12/12] bpf: Convert bpf_cpumask to bpf_mem_cache_free_rcu.
Date:   Tue, 20 Jun 2023 19:32:38 -0700
Message-Id: <20230621023238.87079-13-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
References: <20230621023238.87079-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Convert bpf_cpumask to bpf_mem_cache_free_rcu.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/cpumask.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 938a60ff4295..6983af8e093c 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -9,7 +9,6 @@
 /**
  * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
  * @cpumask:	The actual cpumask embedded in the struct.
- * @rcu:	The RCU head used to free the cpumask with RCU safety.
  * @usage:	Object reference counter. When the refcount goes to 0, the
  *		memory is released back to the BPF allocator, which provides
  *		RCU safety.
@@ -25,7 +24,6 @@
  */
 struct bpf_cpumask {
 	cpumask_t cpumask;
-	struct rcu_head rcu;
 	refcount_t usage;
 };
 
@@ -82,16 +80,6 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 	return cpumask;
 }
 
-static void cpumask_free_cb(struct rcu_head *head)
-{
-	struct bpf_cpumask *cpumask;
-
-	cpumask = container_of(head, struct bpf_cpumask, rcu);
-	migrate_disable();
-	bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
-	migrate_enable();
-}
-
 /**
  * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
  * @cpumask: The cpumask being released.
@@ -102,8 +90,12 @@ static void cpumask_free_cb(struct rcu_head *head)
  */
 __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
 {
-	if (refcount_dec_and_test(&cpumask->usage))
-		call_rcu(&cpumask->rcu, cpumask_free_cb);
+	if (!refcount_dec_and_test(&cpumask->usage))
+		return;
+
+	migrate_disable();
+	bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
+	migrate_enable();
 }
 
 /**
-- 
2.34.1

