Return-Path: <SRS0=0Vxy=57=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7263EC2BA19
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 22:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED66206E9
	for <rcu@archiver.kernel.org>; Wed, 15 Apr 2020 22:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogbq48oE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgDOW1L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727993AbgDOW1H (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 15 Apr 2020 18:27:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D283C061A0C;
        Wed, 15 Apr 2020 15:27:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so2067572wml.2;
        Wed, 15 Apr 2020 15:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zg3ob5dFIHsdWUyPt1RU43xeZYyJjlIPkOiX/f8YR84=;
        b=ogbq48oEXKMvuX6Wqc6V76/Y7aYtAhaE3UxZLBIRfJWjqKTFOGiMRkVg03+/9opHA0
         Nq6JVFRzLkJTSiWD4gAsFBQEX7eFyrNMHD7B3XftHASOHKXdIzeVyv4D7j69sC1bLwIe
         aPFXb+CYlnhKrsIqHb2AXECHd6qlZ4mH4rZ4cEhZQ9ZnNOHzycXeSdFC0KuJMtcuhINR
         UO5jtzUV+dpWuVz/6KV/c6mIHKpGO8vTqMFIxRaN5d9gy+mtTGct+2KDKgvJQCCs3Fvy
         QpYmYrE3jVGqaF+PyeEh8uOYzopcs35jPRrF1Ac2l3N3RQDta9L8/ERN881JxIBhXm0X
         OBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zg3ob5dFIHsdWUyPt1RU43xeZYyJjlIPkOiX/f8YR84=;
        b=scLId3iEV3u4iyy+5md9kBsHOJ168jni7pinyGawwapuGY7VQd1qehZ6J60gshiRxP
         faWnpUndNbTLQV6c1MgglQwU/JpuavQjAa1YgbJ0yNlIF0um+UH+AMBkNUVyOR2ukL9N
         sLasdSeelGafspvuRHnNEgsH4PvslZ0mikxadN2A3csW1+qlgMyiNgnB6sTPROijglkE
         9XA8DprLrv9Pw3qjcBlzsrvdd7qDX2A1OCyDISRhBNUn5dy+sMpDUt1gSA9Au9ju525i
         p12JOYkcX709CEfpf5NBnXQD0i3T/uYLh2qOEnjrVfnjfqrtGytnBj+pTzQuwYfx40Ln
         8RUQ==
X-Gm-Message-State: AGi0PuZ8ddYhVP8nHyBafBbSUZMFy26owqzRU4XahPfz7xQ1GNq8eh7m
        VQ8IBzAYumBzD+zdxUxWiQ8=
X-Google-Smtp-Source: APiQypJ4nk4y/NIUuy7cNNsNj4JyK9eMcuHuy+sY0Q3j/CR3sPw4tKyyX94iSUliU+33fV8kivTCDw==
X-Received: by 2002:a1c:1d4b:: with SMTP id d72mr1421501wmd.19.1586989626211;
        Wed, 15 Apr 2020 15:27:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b4sm20105151wrv.42.2020.04.15.15.27.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 15:27:05 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     paulmck@kernel.org, josh@joshtriplett.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] rcu: init and destroy rcu_synchronize when necessary
Date:   Wed, 15 Apr 2020 22:26:55 +0000
Message-Id: <20200415222655.9006-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

We would skip the rcu_synchronize if it is a duplicate call back function.

This is not necessary to init and destroy for them.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 kernel/rcu/update.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 6c4b862f57d6..91e44b527aad 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -353,13 +353,14 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 			might_sleep();
 			continue;
 		}
-		init_rcu_head_on_stack(&rs_array[i].head);
-		init_completion(&rs_array[i].completion);
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
+			init_rcu_head_on_stack(&rs_array[i].head);
+			init_completion(&rs_array[i].completion);
 			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
+		}
 	}
 
 	/* Wait for all callbacks to be invoked. */
@@ -370,9 +371,10 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
 		for (j = 0; j < i; j++)
 			if (crcu_array[j] == crcu_array[i])
 				break;
-		if (j == i)
+		if (j == i) {
 			wait_for_completion(&rs_array[i].completion);
-		destroy_rcu_head_on_stack(&rs_array[i].head);
+			destroy_rcu_head_on_stack(&rs_array[i].head);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(__wait_rcu_gp);
-- 
2.23.0

