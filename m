Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230DCC433FE
	for <rcu@archiver.kernel.org>; Fri, 18 Nov 2022 19:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbiKRTTa (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241531AbiKRTT3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Nov 2022 14:19:29 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF726457A
        for <rcu@vger.kernel.org>; Fri, 18 Nov 2022 11:19:26 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g10so4116820qkl.6
        for <rcu@vger.kernel.org>; Fri, 18 Nov 2022 11:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hJIDHLBXF0giuH5POYZYhMSuPEuGT60Uc/uAs3zlWI=;
        b=pshyycCa9K3066tR7yK8eyCk/6IKgxQcw8JtBoKV/FxCYuUPhkZia4zqJr7ZOQsnsH
         tiHH4G51c7+2xyWLJOSzUt5s5IsgPwglvg2P5o60nmoZWQeCT0XL6DeQBCZVQH9VAf/R
         hk3ORJwKdt+yY2896qFj/fpXzjZYA2dmIyPjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hJIDHLBXF0giuH5POYZYhMSuPEuGT60Uc/uAs3zlWI=;
        b=EPalGnwWNxpwK6/GMY9/81pjc+1GP03DBOe9sTWImtUXkuxy17xWD7MGn/zTotbO0u
         WEXUEfFNHiGK78e6EBv/MCcSY3Ucr3mrjLBhmL5rc3QJgP/uVQyN3B4Sv/XYm+3vbAeY
         gEVQ/mgmpWgpxZlkQAeO65KQ6yzhg0mZpm8atR+h9NhzncESX+Zm9zZkOgV7REpuOj+4
         KaDwceeHD5OuiLbVzOAENc0+xIy43MwNjD6NrZ4V7umrT9QfKrP1IrOPzd8k22RQViob
         XYpKSugr0Dli++HDSPkPqtMbNHpkBuCRZWqYH2X1kM+9GDSZjuwyGnAVd/65CSecGHXd
         +y4g==
X-Gm-Message-State: ANoB5pkMIJX8boTf/gV6Si6VQV0XYQtFqcp2kNWrV+gNHiroWrhefEs2
        sTYet7SHSk6yWY8UsITta4gaeA==
X-Google-Smtp-Source: AA0mqf58VSjEf3FAcQabR+Xop4/j7v2952HvBQjGH8tmzs2eH3+2gemV+ZeRzoF1BoJ1dfrjJvMJcw==
X-Received: by 2002:ae9:e50d:0:b0:6f9:f247:88ca with SMTP id w13-20020ae9e50d000000b006f9f24788camr7209922qkf.59.1668799165793;
        Fri, 18 Nov 2022 11:19:25 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a424900b006ce2c3c48ebsm2958122qko.77.2022.11.18.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:19:25 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
Subject: [PATCH v2 1/2] net: Use call_rcu_flush() for dst_destroy_rcu
Date:   Fri, 18 Nov 2022 19:19:08 +0000
Message-Id: <20221118191909.1756624-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

In a networking test on ChromeOS, we find that using the new
CONFIG_RCU_LAZY causes a networking test to fail in the teardown phase.

The failure happens during: ip netns del <name>

Using ftrace, I found the callbacks it was queuing which this series fixes.
Use call_rcu_flush() to revert to the old behavior. With that, the test
passes.

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

