Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B736BC433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973A2207DD
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 20:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FB0J9rkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgFRUaM (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFRUaJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 16:30:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE32C0613EE
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so6877988qkm.12
        for <rcu@vger.kernel.org>; Thu, 18 Jun 2020 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jx1ahIG5x2xobNXqKJVJpgSIz/2NwPxYpe7GOL7ZVfU=;
        b=FB0J9rkYiwgXuHJSC1DnZtDkZF4Tw75ZIZHluNjr3AUvFDwfUTMgtY4H214+sXIJLX
         9Rtlm5lo5CdL/BvI+EGkOWs4zuobC1azbbFFc0+13NKhzKxZYWFDTr8MEdpghAo9awS7
         8R5UTkPC7ewrUUIXIXVyczO6Cx+kvBVlyVu24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jx1ahIG5x2xobNXqKJVJpgSIz/2NwPxYpe7GOL7ZVfU=;
        b=fUPl5gnOHP9GQXNBxKo3Tbrw3zbgVJCPvIh9rgyr3OXMHMmwDcrUf65bJmHUCkDfG6
         M+XHbeTgCYZB6H4OQNNWDC5MfWn4f+on8ZRiMHbgI5kkSgLJwKW9zoLdpeMPRyuYGhnK
         aIXNVgnG6jH74uCLcj/K+1RAWVgIcyCT0Bl34yf7d4+jWFPEZOG4ua0VY3P0kX48/Xo/
         fab9N2Ptu7RQ/UDIq/hNoWnxnaYclw3pHQk6YuRC+KYU0DHFg16WIlVuZyyh3+hdrkJY
         BlfJmdKlEW1NiF/tHdGnZ1vnM6y0vS/GLtey/4dpfuf8gCEZrAhonNwqrrVN5H6FejFf
         LXig==
X-Gm-Message-State: AOAM533y0jOSoFfuRcL1iTuLITpCQFLihE+Nd5UtqpZinWKbT7wWCzO2
        Wxil5IsPdWHGs7ISZV0mbabQmQ==
X-Google-Smtp-Source: ABdhPJzylQaooeD46hftkonQc35ZJOpi4VP5APbXZBlkgFXxIh6caC2s9W0bhjKMn1dR8N2XfIyT+g==
X-Received: by 2002:a37:6610:: with SMTP id a16mr206695qkc.17.1592512208454;
        Thu, 18 Jun 2020 13:30:08 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v3sm4027503qkh.130.2020.06.18.13.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:30:08 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 5/7] rcu/trace: Use rsp's gp_seq in acceleration's rcu_grace_period tracepoint
Date:   Thu, 18 Jun 2020 16:29:53 -0400
Message-Id: <20200618202955.4024-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200618202955.4024-1-joel@joelfernandes.org>
References: <20200618202955.4024-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During acceleration of CB, the rsp's gp_seq is rcu_seq_snap'd. This is
the value used for acceleration - it is the value of gp_seq at which it
is safe the execute all callbacks in the callback list.

The rdp's gp_seq is not very useful for this scenario. Make
rcu_grace_period report the rsp's gp_seq instead as it allows one to
reason about how the acceleration works.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 81df1b837dd9d..c3bae7a83d792 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1437,9 +1437,9 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("AccReadyCB"));
 
 	/* Count CBs for tracing. */
 	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
-- 
2.27.0.111.gc72c7da667-goog

