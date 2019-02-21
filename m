Return-Path: <SRS0=rKhI=Q4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0FFC43381
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7012084F
	for <rcu@archiver.kernel.org>; Thu, 21 Feb 2019 05:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uye2tYOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfBUFuP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:50:15 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42782 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfBUFuH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 21 Feb 2019 00:50:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id b8so30186554qtr.9
        for <rcu@vger.kernel.org>; Wed, 20 Feb 2019 21:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ugol0rgDCJ10tdYejpAP4lSNDuzdaHwVbfjsfuyPKr4=;
        b=uye2tYOOC0bZ39eWdPJnH1bptH+S4Cs9o0M6xgMzLkhahm4hMVUOBbQkW51Ti19KMR
         oerpGE8JpjWjD4HGM4SeomN1VM20+2cy3mnkc8I/+NV3bEp6ey8gbknhjyzULWebul0a
         6udN8DWGUjVYkGNzqLEre31/UHMSHjLYlYWYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ugol0rgDCJ10tdYejpAP4lSNDuzdaHwVbfjsfuyPKr4=;
        b=CFxsMJ/7qynx+VEWFeQ5vbaQmS9oWppihGew3OiXs+73B0fZZ1rUiNzs2mJpMx77sV
         8JdQBry+9kQnx1JdGK4jyAbNQdXF5Esi9dZcpWoeQjRc0D97nrWW+AnuezHq0FkESAcK
         aS0f8NG4xkduIgQgoFzHQoV7Z4ZKd+5TjQinkpU328FoGo7NuCQHp21Azqi+Zlcy6Xau
         G+3d+FqTEIU06E91VCtZ9x/XSYBRZ/d8P8fJU9Ao1/JWSVvoWeAqomlIt/5+o7la58st
         S+fbCZ+svYJ09I+Ii0scaKm9y3PoCD6m0YNpS8XoHZPqZFcXKJLh1RaMhq1DOhWMEjSp
         ddgA==
X-Gm-Message-State: AHQUAuZQdFEFpe/+ATP+8TWKH/SlhO+nzcj+QpkMsLpIhCstLHN6BcTa
        mMWinkUNmTjIt7KFE98T5OkmXg==
X-Google-Smtp-Source: AHgI3IY1x2CsKnOyckwybfdh/IC8vE4HGJ48wjA9vpW4LbhlPy2SxC91fb7T2aBEZJUZvnNh7C0Y8A==
X-Received: by 2002:a0c:b60d:: with SMTP id f13mr4809691qve.209.1550728205769;
        Wed, 20 Feb 2019 21:50:05 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id k185sm11561219qkd.62.2019.02.20.21.50.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 21:50:04 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        Ingo Molnar <mingo@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, keescook@chromium.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        netdev@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        xdp-newbies@vger.kernel.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH RFC 5/5] rcuwait: Replace rcu_assign_pointer() with WRITE_ONCE
Date:   Thu, 21 Feb 2019 00:49:42 -0500
Message-Id: <20190221054942.132388-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This suppresses a sparse error generated due to the recently added
rcu_assign_pointer sparse check below. It seems WRITE_ONCE should be
sufficient here.

>> kernel//locking/percpu-rwsem.c:162:9: sparse: error: incompatible
types in comparison expression (different address spaces)

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcuwait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuwait.h b/include/linux/rcuwait.h
index 90bfa3279a01..9e5b4760e6c2 100644
--- a/include/linux/rcuwait.h
+++ b/include/linux/rcuwait.h
@@ -44,7 +44,7 @@ extern void rcuwait_wake_up(struct rcuwait *w);
 	 */                                                             \
 	WARN_ON(current->exit_state);                                   \
 									\
-	rcu_assign_pointer((w)->task, current);				\
+	WRITE_ONCE((w)->task, current);					\
 	for (;;) {							\
 		/*							\
 		 * Implicit barrier (A) pairs with (B) in		\
-- 
2.21.0.rc0.258.g878e2cd30e-goog

