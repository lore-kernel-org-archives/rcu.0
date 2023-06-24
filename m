Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA74EB64DA
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 03:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjFXDNr (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Jun 2023 23:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXDNq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Jun 2023 23:13:46 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9210DE47;
        Fri, 23 Jun 2023 20:13:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ecb21f86so1129733b3a.3;
        Fri, 23 Jun 2023 20:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576425; x=1690168425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6ir4URdr01h+ZUg6kzH9KBRVLbULKDLoOzFhIlPeJI=;
        b=L+ptJ7NY03zyI1ljB8YpkJDY6mzKWJzN7mzzr1GH8I2PDRz6lEC4vG9S92WgLyAqnq
         jDIxZ9eVOut6aO1/yJABfk8hHMRjV5iGl/sW290PMTLIh1YlQdytM8pt9Mcd8crH1en6
         D0g8gSN5pNDX2HAj98d3w0vAZQBCT0d7YBk5GwL1hW9x14B8wF1JWJTz+563eFTmIDNE
         UK7p3EkJqp4KQatPUocMuYHImptp18tRTTpOiKzrBr6uvgADq0vnEmPwUucVbTMseYf4
         Dzn52UxEBIYGnFFNvla3P/4e52A4eGFd98t8H+PzeCzDBbrLNia7H0xmcQ9nsXmCUxUC
         TSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576425; x=1690168425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6ir4URdr01h+ZUg6kzH9KBRVLbULKDLoOzFhIlPeJI=;
        b=GaCEIkj+6GlMbqmp0rCla9UutMtfssZT5Rvl8wD3LfR/GKyCGnzyBpkg4xus8/iaLy
         jPzLr5J/06BSq5WftbTnXcZN14puwqwVOq/eQcnekDsbzLqsa/YzK6kBkGlIo3SnsKWQ
         864Ud1u0X9cDknBAk4IZKbpw/aGp0WiD79Y9BAzhEkrQ+bzsDZpCOmVRpEs8F12e3Ycd
         vgC01OEiUF2+ovvJO50AwKRhj38kwYuT1pNPxQdpeadVxFQ8ZOrtn1BFUp1JjsDMBTux
         bLbLM4E7Gis+3uyS6CsjmgJ3bET4IJJuEaKqG2VilxuwxaBDb3ZbWVlHZHS+EnZ/kuk7
         B+ag==
X-Gm-Message-State: AC+VfDzltqqzb0mhga15z6jBJAGX/TEvC/bnYEgsIIgUvqhQewC/KG6Q
        zGKUzr9VAnwSQWw7SJZ/eiqRYJHSG+s=
X-Google-Smtp-Source: ACHHUZ7DMOcBLsampKDvaTFPgxvAXugOh8VX0BBW7ADumKx2vEeJNaKIp6J81s2nwRsAtx0mLHvchw==
X-Received: by 2002:a05:6a00:2e10:b0:64f:35c8:8584 with SMTP id fc16-20020a056a002e1000b0064f35c88584mr32645742pfb.18.1687576424903;
        Fri, 23 Jun 2023 20:13:44 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id j18-20020a62e912000000b00666add7f047sm186975pfh.207.2023.06.23.20.13.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:13:44 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 02/13] bpf: Simplify code of destroy_mem_alloc() with kmemdup().
Date:   Fri, 23 Jun 2023 20:13:22 -0700
Message-Id: <20230624031333.96597-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Use kmemdup() to simplify the code.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/memalloc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index cc5b8adb4c83..b0011217be6c 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -499,7 +499,7 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 		return;
 	}
 
-	copy = kmalloc(sizeof(*ma), GFP_KERNEL);
+	copy = kmemdup(ma, sizeof(*ma), GFP_KERNEL);
 	if (!copy) {
 		/* Slow path with inline barrier-s */
 		free_mem_alloc(ma);
@@ -507,10 +507,7 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 	}
 
 	/* Defer barriers into worker to let the rest of map memory to be freed */
-	copy->cache = ma->cache;
-	ma->cache = NULL;
-	copy->caches = ma->caches;
-	ma->caches = NULL;
+	memset(ma, 0, sizeof(*ma));
 	INIT_WORK(&copy->work, free_mem_alloc_deferred);
 	queue_work(system_unbound_wq, &copy->work);
 }
-- 
2.34.1

