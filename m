Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C720C433FE
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 03:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiKQDQH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 22:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKQDQG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 22:16:06 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611FA627F4
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:16:04 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c15so373284qtw.8
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S1ptF9mncQNJ+YzPoHhaIMd3nHddn4TGB/DoUobLdZU=;
        b=GcfN8q0cdS6ovJPkcYbDaqLvjp2zegbXELs5S4CRJutF7b+qeUEjdTBvXgBMq/OP0O
         5F0oDVaz0IMlsc3dJM130Zm51BsN/20FkgL5+YveFNxpF5QeQZUfW2actFnGJSzQOl7k
         9FJPLPu3eSIQwGzgteA3hAdyBxrFV0KXV9dzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1ptF9mncQNJ+YzPoHhaIMd3nHddn4TGB/DoUobLdZU=;
        b=daN31oXMzIpiHw6YSYhHlXdrTdQYorpjhI3T3aUuQWALQsmcFBE7xHz4thGPo594Q1
         hsknhF8J1W+umEoX7J6FL1bjSGeUjBibN1mdwieJxn5N0CJuXputV9lXgmJu1W+DKP6H
         Eow3DgwweCSVP8HK9ytZqi5mGnUvfSEURlYODmYpYZ0Z6k5oqVgCb5Gatsu0wrHf30Ud
         hHcw6MQmjCb+kia4+xOThBGbVE22nWpsf/0eKK5z8TgUKx08/+kw+wHEzPoB2EXMt3E4
         PKy4iXOQnXbF873ohHyWw4V15je6gF8SKCLSGjQP33Jogvm5iGmgmxsmys1v6vgG+SOR
         BcpQ==
X-Gm-Message-State: ANoB5pkgx9Oc8ZpExKhI9m1BYnS2wdSCS0aW0Y58qjKe04QPlwLVXdxZ
        K55TDOUZ1K8g4EnnFjBu9cOW1g==
X-Google-Smtp-Source: AA0mqf6wIKIMbSXoQzryo0edy3a17i21tuwAle5TzhjMCIbXHB1V2gGJhQuKdO3B3/Yxj47fWCqMTA==
X-Received: by 2002:a05:622a:401b:b0:3a5:2c7c:c915 with SMTP id cf27-20020a05622a401b00b003a52c7cc915mr722597qtb.499.1668654963515;
        Wed, 16 Nov 2022 19:16:03 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006cdd0939ffbsm11398318qko.86.2022.11.16.19.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 19:16:03 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
Subject: [PATCH rcu/dev 1/3] net: Use call_rcu_flush() for qdisc_free_cb
Date:   Thu, 17 Nov 2022 03:15:48 +0000
Message-Id: <20221117031551.1142289-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In a networking test on ChromeOS, we find that using the new CONFIG_RCU_LAZY
causes a networking test to fail in the teardown phase.

The failure happens during: ip netns del <name>

Using ftrace, I found the callbacks it was queuing which this series fixes. Use
call_rcu_flush() to revert to the old behavior. With that, the test passes.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index a9aadc4e6858..63fbf640d3b2 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1067,7 +1067,7 @@ static void qdisc_destroy(struct Qdisc *qdisc)
 
 	trace_qdisc_destroy(qdisc);
 
-	call_rcu(&qdisc->rcu, qdisc_free_cb);
+	call_rcu_flush(&qdisc->rcu, qdisc_free_cb);
 }
 
 void qdisc_put(struct Qdisc *qdisc)
-- 
2.38.1.584.g0f3c55d4c2-goog

