Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3C2C63797
	for <rcu@archiver.kernel.org>; Wed,  1 Feb 2023 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjBAPKc (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Feb 2023 10:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjBAPJo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Feb 2023 10:09:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D10D66FAA;
        Wed,  1 Feb 2023 07:08:24 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id be12so6740712edb.4;
        Wed, 01 Feb 2023 07:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7t+jH47dutnrEewrpFYJCTIdzeIdrMXC7jVe2cYM1o=;
        b=axm8GclNe0TkydqMsP7WrJXjtkaTy5Us4zqhdTWmg2xnNAxQfkDMBXKZ21FQxDg7wq
         FxoE3ayhhjkVGUy//ctSzLPp9/7i90nBwEV3YVUJJ0WMFS5L6oS0suOeNLJeaVO6i2L1
         s8s1dW3g8daDhCb1PYPRpk8S/774DEKn4IyUIiponWkVWmreuGMAosaw3IWCdhuPdVJ8
         8SEmr6Njxvw8bB5KOqp0GY5Gf1rr39JDlnVXdQhY5fpbEobkXyahDU92E1S1lU+xpoNd
         3O2/LiEs1exrkzevNNQX25oi7cq7VW5YiMd/AJcDfnHEF6LmMvNaI6AoTi/gRVb08UPH
         eGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7t+jH47dutnrEewrpFYJCTIdzeIdrMXC7jVe2cYM1o=;
        b=NI9Ja2nuJ+5Tp+JCstwRgvTPLm6oTRrOpBn2JmE998ZfjHJdFIt8BWz4NZgWENpjE/
         4qHYAMtLrK5yKxJEfw5h7cvp21MM7hhr/MtIZvdrKJOsp0iVzrdAWCHx/HnsuwL5PM7t
         4j1rWRf8NNMb854cnRav8G/BpLGomYo50OuysonC7oKXXnMmcRX85or6cGmUbIUeybE1
         sn0ClclF2IWn1AFzqgdGknwx8sDpLTNNZxr/BVyd2UfgsMfmDLgIFCt3gvRD+g6ZaZ9P
         9dMYTQ/NuaOCMAOikNGjKpMeNjuZL34dhcNUGmWzNMDjpw97DXffULUu+VELMi0x19tx
         InEw==
X-Gm-Message-State: AO0yUKXoUGJPQARKOPL3OieET0t74kawstx8y6Vt0WMK66gldvCwQwm6
        ByLLbcw1Uugpwa5+FIglVKox8v912bTJ/Q==
X-Google-Smtp-Source: AK7set8jOPc1FL0gqkf6hHR27Gh0OOx6IwdNTQrshUFLPMLPWE9EiGyHm4LH0bpDVr19OM6AVWddRg==
X-Received: by 2002:a05:6402:3488:b0:494:fae3:c0df with SMTP id v8-20020a056402348800b00494fae3c0dfmr2985034edc.12.1675264103466;
        Wed, 01 Feb 2023 07:08:23 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id qc26-20020a170906d8ba00b008787e94c5ccsm9585774ejb.184.2023.02.01.07.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:08:23 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Bryan Tan <bryantan@vmware.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Eric Dumazet <edumazet@google.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Ariel Levkovich <lariel@nvidia.com>,
        Theodore Ts'o <tytso@mit.edu>, Julian Anastasov <ja@ssi.bg>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 06/13] net/sysctl: Rename kvfree_rcu() to kvfree_rcu_mightsleep()
Date:   Wed,  1 Feb 2023 16:08:12 +0100
Message-Id: <20230201150815.409582-7-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230201150815.409582-1-urezki@gmail.com>
References: <20230201150815.409582-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The kvfree_rcu()'s single argument name is deprecated therefore
rename it to kvfree_rcu_mightsleep() variant. The goal is explicitly
underline that it is for sleepable contexts.

Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 net/core/sysctl_net_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5b1ce656baa1..a28562d4e468 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -101,7 +101,7 @@ static int rps_sock_flow_sysctl(struct ctl_table *table, int write,
 			if (orig_sock_table) {
 				static_branch_dec(&rps_needed);
 				static_branch_dec(&rfs_needed);
-				kvfree_rcu(orig_sock_table);
+				kvfree_rcu_mightsleep(orig_sock_table);
 			}
 		}
 	}
@@ -139,7 +139,7 @@ static int flow_limit_cpu_sysctl(struct ctl_table *table, int write,
 				     lockdep_is_held(&flow_limit_update_mutex));
 			if (cur && !cpumask_test_cpu(i, mask)) {
 				RCU_INIT_POINTER(sd->flow_limit, NULL);
-				kfree_rcu(cur);
+				kfree_rcu_mightsleep(cur);
 			} else if (!cur && cpumask_test_cpu(i, mask)) {
 				cur = kzalloc_node(len, GFP_KERNEL,
 						   cpu_to_node(i));
-- 
2.30.2

