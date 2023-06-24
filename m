Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C903DEB64DC
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 03:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFXDOX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 23 Jun 2023 23:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXDOV (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 23 Jun 2023 23:14:21 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7D8E47;
        Fri, 23 Jun 2023 20:14:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-392116b8f31so978708b6e.2;
        Fri, 23 Jun 2023 20:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687576460; x=1690168460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Id52rcowJ7NZMb5+YK4IlpOtkvo0YDczJ2nwiMNvyqw=;
        b=BShzq8MyYkVioGmrAxeOVWScFForOJrYEt3VbO/E82mY8Jr2ivkVJggn8locLJGFh1
         dHgpxd3I9pzGNxUU+kmwHgLhG11UVGY0ZLB27m0HGE8aLIu9MoFl5XL8GyGcvPCbdRcg
         YcHejhIfOLEPd1gK5Ew5/C/QvgLymapawu5Xlr5EnEq1aUb71CXMeMqTRyHFeOc+ocBg
         mt++ATYZqs1FgzL+qLbuxAQ0KqFe5EItZDwIyBi95VMi1hWmDB/Jxq3eTJ5bAo6xUbGm
         p48XI6MM8pbjXL5/55MBlkBYq5aLVVzI3ZgUNRqodqsi/HfIhKmDVjb84apd6e09YpwB
         wevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687576460; x=1690168460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Id52rcowJ7NZMb5+YK4IlpOtkvo0YDczJ2nwiMNvyqw=;
        b=EYw8pS/UCzq7xKrZzGe5vGSkE4hUXATk01kaTBD5CmpN5pfjqMjQh1ywKVZH3Sg84W
         wAkOrNbNXx/hTETJjDIBOv6F55uc7Ri9XpMtGslottCq5vGIIHmv8nr66DCEF9zp8eqi
         8TmkK5P7nNuRULuSpi6vlWQlI5hCwbR81Zu0YCSvNONve6Oqqr5kOgeZLHDRTSzLfGTi
         nkvvoGe5//lUmlmj/+nArkugswjEqyfjZwVAgrg/0W4KaIg47sm9Sg4u+isxwGLsJgrr
         inWLqYrd6djI0WxNQmBpailReqnhh/bc9ABrbKZhWkqB87fCh30NEkeTQv5xLf0YHJ/j
         5QPg==
X-Gm-Message-State: AC+VfDxKjTA6NOSQQ1C1ZzK6UAAlN3T+em06K1ApLjDQVwpvZf7YJTj0
        jBt+Oh0EWnZBO+H6RJZnRZQnRfyvUyM=
X-Google-Smtp-Source: ACHHUZ6PhUWyiwFlHRknKqzTh5a+xst8/nQYnjELBVda5xmxVWGNE66JwfUlEteCx+gb6wq8UpZBTA==
X-Received: by 2002:a05:6808:23d0:b0:3a0:567f:8e9c with SMTP id bq16-20020a05680823d000b003a0567f8e9cmr9973176oib.43.1687576460380;
        Fri, 23 Jun 2023 20:14:20 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:b07c])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902d70100b001b523714ed5sm225623ply.252.2023.06.23.20.14.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jun 2023 20:14:19 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 bpf-next 11/13] selftests/bpf: Improve test coverage of bpf_mem_alloc.
Date:   Fri, 23 Jun 2023 20:13:31 -0700
Message-Id: <20230624031333.96597-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

bpf_obj_new() calls bpf_mem_alloc(), but doing alloc/free of 8 elements
is not triggering watermark conditions in bpf_mem_alloc.
Increase to 200 elements to make sure alloc_bulk/free_bulk is exercised.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/linked_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 57440a554304..84d1777a9e6c 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -96,7 +96,7 @@ static __always_inline
 int list_push_pop_multiple(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
 {
 	struct bpf_list_node *n;
-	struct foo *f[8], *pf;
+	struct foo *f[200], *pf;
 	int i;
 
 	/* Loop following this check adds nodes 2-at-a-time in order to
-- 
2.34.1

