Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E30CC433FE
	for <rcu@archiver.kernel.org>; Tue, 11 Oct 2022 18:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJKSC5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Oct 2022 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJKSCi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Oct 2022 14:02:38 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58CB6AA28
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id x13so6474118qkg.11
        for <rcu@vger.kernel.org>; Tue, 11 Oct 2022 11:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0y+DmjJhTq9monYJaUr4qwh4aRYR5iDLKa+yKUX59E=;
        b=irIdIFBl2ehbWbpq+w2qg+L5notVUkLMqwnI/fnXUI+vv4U+5vNVd7k0yjp/EDNZXA
         u6N3i/Gl2hq5hyg7WFsi2P9IEBC7llVQ089FaXhnGCzyGCRRSJNTjwonk2ABGnje5UtS
         IEfDrEIayfWCrL8i/DiXv8ifXoFjkBPS88LUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0y+DmjJhTq9monYJaUr4qwh4aRYR5iDLKa+yKUX59E=;
        b=7mFOn+Pc36VL7OMzFyOBprHmPPYeDdldoNGL1UdjJ142rdI/joN8RX7NArTd6Y8SES
         fllnDLj2zJEIJvSCG8F5/QF7HM2Rbjt4TUQhP19TwIdT8nG6wA4gN+qUddzY2u64c1v8
         g3VPv3t30wIulM4b4/juiQv1zhC5T+HHs/5sz5wE7IPe96SNDQiuKdxB46wkBmwOtn45
         IjtIn5WjvQd9k9mFthUPbDdLdZweQ1e4w8fdfPhpu7KSWLjSbd9CWmvtlQsAstxjF6IF
         +orfSYjZnm5AYi/hOQ8tVcbAoQUGJICy1NNnqVNTH+KgFHE6bjTOpkbAAhmaao6mcw7w
         ZqVw==
X-Gm-Message-State: ACrzQf0e7BDArrXY+n4CvM/RmBR73Ulc3PDNa7t8BxY8fOAfe0MKjkZb
        g/SdU1RIPvXIXAabkvjJiWNxpdKnjbPUiQ==
X-Google-Smtp-Source: AMsMyM7hnN8IlnHhSERMzjYvPOFqcwoe0X5Tz/ptPbXWucNDzvsSp3/KKI5+UZWMNj0N/KDlIhWTGQ==
X-Received: by 2002:a05:620a:1507:b0:6ec:eedd:aa57 with SMTP id i7-20020a05620a150700b006eceeddaa57mr8041254qkk.704.1665511338331;
        Tue, 11 Oct 2022 11:02:18 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a425600b006cbc00db595sm13464375qko.23.2022.10.11.11.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 11:02:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, youssefesmat@google.com,
        surenb@google.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v8 12/13] rxrpc: Use call_rcu_flush() instead of call_rcu()
Date:   Tue, 11 Oct 2022 18:01:41 +0000
Message-Id: <20221011180142.2742289-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011180142.2742289-1-joel@joelfernandes.org>
References: <20221011180142.2742289-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

call_rcu() changes to save power may cause slowness. Use the
call_rcu_flush() API instead which reverts to the old behavior.

We find this via inspection that the RCU callback does a wakeup of a
thread. This usually indicates that something is waiting on it. To be
safe, let us use call_rcu_flush() here instead.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/rxrpc/conn_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_object.c b/net/rxrpc/conn_object.c
index 22089e37e97f..fdcfb509cc44 100644
--- a/net/rxrpc/conn_object.c
+++ b/net/rxrpc/conn_object.c
@@ -253,7 +253,7 @@ void rxrpc_kill_connection(struct rxrpc_connection *conn)
 	 * must carry a ref on the connection to prevent us getting here whilst
 	 * it is queued or running.
 	 */
-	call_rcu(&conn->rcu, rxrpc_destroy_connection);
+	call_rcu_flush(&conn->rcu, rxrpc_destroy_connection);
 }
 
 /*
-- 
2.38.0.rc1.362.ged0d419d3c-goog

