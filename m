Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52E3C43219
	for <rcu@archiver.kernel.org>; Sun, 16 Oct 2022 16:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJPQX7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 16 Oct 2022 12:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJPQXo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 16 Oct 2022 12:23:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE923C151
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id o2so5390020qkk.10
        for <rcu@vger.kernel.org>; Sun, 16 Oct 2022 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEtsx5s7XOiwD9ITg4bkmVjdZ73X1TK7P0DFf+XigW8=;
        b=pOMzhiN56m8msun4IsqBgxhAdONJhpbswx/IqkVNkSzTeoZyLosoi3Vb7h3daV57N2
         tbMeo2SLUtbhULfjpnA/VGwusi+VwdrN9fM3xRm7qFybgF62fYRKEGDPgdni8VnOptlp
         3VpNZBINyx4R1NGkCDqif21jM8JelQbOO5AKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEtsx5s7XOiwD9ITg4bkmVjdZ73X1TK7P0DFf+XigW8=;
        b=k+yIl4qtc2ggS2CSfELJ/4/f4Qm0uwvRoCiPlMVhdPdxNQbLA9nugmhS+11f7Y6brC
         QETHqjherkm33TIvIh3m00qWZGkVm0OF0/wHStffK5rcpUiW2M9Kz+O4Hoie2cPP3hqt
         SIpU98fGEahx57YWv70O+dc7oDQ0RmfcZZmgpv0aqZ/ZR5HEj9VAohcC9abZiGa3ziGN
         3H/KP6OTqPy+uPwuNsz0UNs9Xql6p2u+PKfJDQ75x0ilhJMOKa6SIJo3bbrC6H8BqgDe
         cygiC9AdI0CeWms+2CIlTgUXjoh65kJ6bwQL5wbCsg9CbBn1d7g9VEqnkpJlbZ5flSwg
         u8xQ==
X-Gm-Message-State: ACrzQf1pMVmgj+1iC9crbPpWVsZaB3Rkn4eJzjaReNCqAD+CieI6TNsS
        OoA8UiDJ0C4GxUQO6tE1psQd61oEIOxUIw==
X-Google-Smtp-Source: AMsMyM6yGlhG1jMARZVapw8+tf5joMmfgRkmzBDiCtBUJkkPqdbBN7kTkDtgGznT9qezr0r1+nL2yQ==
X-Received: by 2002:a05:620a:28c1:b0:6ee:d4f1:21df with SMTP id l1-20020a05620a28c100b006eed4f121dfmr4953922qkp.724.1665937421930;
        Sun, 16 Oct 2022 09:23:41 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x19-20020ac87ed3000000b003436103df40sm6001207qtj.8.2022.10.16.09.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 09:23:41 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, frederic@kernel.org,
        paulmck@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v9 12/13] rxrpc: Use call_rcu_flush() instead of call_rcu()
Date:   Sun, 16 Oct 2022 16:23:04 +0000
Message-Id: <20221016162305.2489629-13-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
References: <20221016162305.2489629-1-joel@joelfernandes.org>
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
2.38.0.413.g74048e4d9e-goog

