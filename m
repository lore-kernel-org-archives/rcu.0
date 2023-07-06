Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF21EB64DD
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 03:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjGFDfl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 5 Jul 2023 23:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjGFDfi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 5 Jul 2023 23:35:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BA01BD9;
        Wed,  5 Jul 2023 20:35:35 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e97fcc60so237572b3a.3;
        Wed, 05 Jul 2023 20:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688614535; x=1691206535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYt+LNzB/i0hKKdEYq5jVUn1IOf1250hxziDpCkVzXs=;
        b=KmhDZ5nonfra5L1SO5UQa1PTBxdDqvFvzc2PeDr78AP0CCvyXaSPuHJCsi2RqoLlDG
         P85IbaLhS+zuIZyGLSKTv7SFiN0DRJ6gH8qY7loR/tEBUaB1LWmseyaUrZZz26zwpZNs
         BQx3WeURSBS8R6o9KVwFTerN3DxX94brRgmdI9jjOzu3CsgIZpfdimpcNsUTQg7K7LUb
         yKoy+iyTASGMuy6Fx54aIumfzxoh1zllA/SYkDMl+1aZTnUtzmVhT+MrVjvN03nDAUPh
         Kp3YhOTv5rqFt9UMbF+4YGs50Nl0dCFNVyQq+KmhP32Vv/uyBvI4xN8OB6M9RfE3++Pc
         9c7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688614535; x=1691206535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYt+LNzB/i0hKKdEYq5jVUn1IOf1250hxziDpCkVzXs=;
        b=BeXfden6st8LkJ3qKIXy7Ghwq6lK5gsoS97bTQBLSKfwtefD/LQr7lEM57qUeWljli
         ohLCijWtCw3iMJyDyNLrvxQuhHfZ/vdX8b43EUc4+++q+5Ny5bx8agdfSXDy1oaVb/eL
         7+fnNHvclIgfHRAIpOOPF0rmWa2ZUTszSOKFehCjp4AiBm0rwcRov1ORj2mej688+cBF
         RmC636sBo6SQ5HRWoQhEzdzfRK571vtqaJlSEt0qzcx+fcG/GrCvuJKeI2PgmBuF3bA8
         2LmIPJREmNCpxCs6sEZHsN6dYDPfdRTfTnEUkPxoN+yPA6gIf8O7XzCwKf8USHdT/oI3
         JJ1w==
X-Gm-Message-State: ABy/qLalYm50PwXBXM0jTdOB+TcE6B96vkqfXtSzz2U88te9qaA8m0Mt
        e9pE2eCPcmy9k4BQ+CzC1rzIxl5hDa4=
X-Google-Smtp-Source: APBJJlGPxYImLwrJfTPWKzIl2uJaj+5H/chqedmrZYcFrBslXfYGj/+773Z7IXOQ2BCZLOWAGyMSSA==
X-Received: by 2002:a05:6a00:1991:b0:666:a25b:3788 with SMTP id d17-20020a056a00199100b00666a25b3788mr492266pfl.34.1688614534738;
        Wed, 05 Jul 2023 20:35:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:f715])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b006661562429fsm248363pfh.97.2023.07.05.20.35.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Jul 2023 20:35:34 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        houtao@huaweicloud.com, paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 11/14] selftests/bpf: Improve test coverage of bpf_mem_alloc.
Date:   Wed,  5 Jul 2023 20:34:44 -0700
Message-Id: <20230706033447.54696-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
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
Acked-by: Hou Tao <houtao1@huawei.com>
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

