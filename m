Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5482AC4321E
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 03:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiKQDQJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 22:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiKQDQH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 22:16:07 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAF264A08
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:16:06 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id l15so390198qtv.4
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9LBEXDD+Ph4SF0Q02heQyIynGLkO+luTsSJyIxQLi8=;
        b=JHB8aiQgqZr6T2488gjy0+mFOhHh2VyJvRopV5+pPWMJXZhxAwmnceQy5QEv3N8tOk
         Ne1NmLfUHfz0FDXUP8hNcvKOK5FPq4UpnuFxw8/1IO6+cRNfmUgFz3ciXPbZVkiiHxIV
         xS+aaBeY1m0r9PJS6zCglk21/419o+83mDIcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9LBEXDD+Ph4SF0Q02heQyIynGLkO+luTsSJyIxQLi8=;
        b=aYSJ9YS0fneyb2dbXf+5SFaCziCXmVaH2cuvZj99e5nFYlzefAQxQ02DCjtRjzIlj6
         PcEsm4Jml102hZddaEU+iqUsCosxOBhStt05H+NlB2IzcZ1kYZG+7V2RByU1G5uHK7yS
         eBiBWLM6oMz6kXS9/FeE3P6seLGhd1JHfyMeM6agdekcy84z4w7DaSfenvkPkawK3bHy
         D2Oz+/1fYp80tXGGPjHoxT0Ziz4CSU1BBVAYis9coKSJM77k46jBBdSZkvNMmdWhfC+P
         ude1KrxnEarLATfw9Eehw18wV0MMURwKmXGGKEZeIIZfWucXXtop5UkR3C2UnbD7RgJv
         Dxqw==
X-Gm-Message-State: ANoB5pl1F3HyxETp954VmhDm61lRUAl6eWLfb4BfCK2+oQcj1iDMIcQ7
        eNmb5B0wpHMDJk8ekt9X03eJ1w==
X-Google-Smtp-Source: AA0mqf6tYbb7aqh2iSUw+/DUxtEpt+XbSFQV9UPEmammY7VOC9v7BaLxv9VBsF2YJcPh3TQAZIKKew==
X-Received: by 2002:a05:622a:4899:b0:3a5:64a0:5eba with SMTP id fc25-20020a05622a489900b003a564a05ebamr827383qtb.96.1668654965522;
        Wed, 16 Nov 2022 19:16:05 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006cdd0939ffbsm11398318qko.86.2022.11.16.19.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 19:16:05 -0800 (PST)
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
Subject: [PATCH rcu/dev 3/3] net: Use call_rcu_flush() for dst_destroy_rcu
Date:   Thu, 17 Nov 2022 03:15:50 +0000
Message-Id: <20221117031551.1142289-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221117031551.1142289-1-joel@joelfernandes.org>
References: <20221117031551.1142289-1-joel@joelfernandes.org>
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
 net/core/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index bc9c9be4e080..15b16322703f 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -174,7 +174,7 @@ void dst_release(struct dst_entry *dst)
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
 		if (!newrefcnt)
-			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+			call_rcu_flush(&dst->rcu_head, dst_destroy_rcu);
 	}
 }
 EXPORT_SYMBOL(dst_release);
-- 
2.38.1.584.g0f3c55d4c2-goog

