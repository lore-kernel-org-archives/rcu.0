Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0011EC43217
	for <rcu@archiver.kernel.org>; Fri, 18 Nov 2022 19:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiKRTTb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 18 Nov 2022 14:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241593AbiKRTT3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 18 Nov 2022 14:19:29 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FBE64542
        for <rcu@vger.kernel.org>; Fri, 18 Nov 2022 11:19:28 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g10so4116864qkl.6
        for <rcu@vger.kernel.org>; Fri, 18 Nov 2022 11:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPpwqLUbnT1bAnW/zW+E67t6MBL3eH6A9u0qDYvFcWw=;
        b=u/2XfL0tPG6GBJLPYyTHlLt/PrZI3yVn8VxWlCWjWq3ieouEHW2Ws/jpTVeMP+Mwlr
         LemZtoszK8Ff3Z2vtK/bRbwa/acoEfwUlIVs0ebNc4+08hlP6z5ChCPTCPBxPRmhQeQH
         /TOKyl7UElbeQMdAC+Clax4UCy9klC7bUs4ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPpwqLUbnT1bAnW/zW+E67t6MBL3eH6A9u0qDYvFcWw=;
        b=BYNJGeajP6pyxVTtlgk+tmrWlxlX3ALTqIxMQ3xBtZTC969AVqdk5m/zOwVrZSDQag
         9InFRaQ09VwdnSGjSxMe/AkvZN1i8V7/dZ6TQ3FQ03qZC5OauTA6bn58GG/wa6ntrvim
         2H7k693MsZK6BAPZeq4i9qabcdh0oaaFMuLawmZ/0IjNTgCiEoJT0fEz9NPWEI/qWcdg
         VbP0oxcp/1WjffqJNtCDG/hhEaORAdsKO+sdycNGm/6nayJSOdpsCYKSFS83iNizkHQH
         2OFKrJ2/Ki9Bd/xHBfFAZwuItOsmmp2R4HMQDF9FsD0I2IzHp2yoY0nCNy11gTu/gNnI
         rgEg==
X-Gm-Message-State: ANoB5pksRr+s3YvUNrk97VXShKL38GOKrXaik3JSR1N+ElAFx9GGD35D
        WssvdBfQ4uwlHdAsvtxftdtT6A==
X-Google-Smtp-Source: AA0mqf4VuCjTQx1EzQp2ZWG8PsWGsHDdIjBOjeNFJK7bNHpS6s1ATzvJXRaMmwcfUypWvWZO/Dskvw==
X-Received: by 2002:a05:620a:3d9:b0:6fa:5091:7ac8 with SMTP id r25-20020a05620a03d900b006fa50917ac8mr7052092qkm.372.1668799167180;
        Fri, 18 Nov 2022 11:19:27 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a424900b006ce2c3c48ebsm2958122qko.77.2022.11.18.11.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 11:19:26 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, rcu@vger.kernel.org,
        rostedt@goodmis.org, paulmck@kernel.org, fweisbec@gmail.com
Subject: [PATCH v2 2/2] net: devinet: Reduce refcount before grace period
Date:   Fri, 18 Nov 2022 19:19:09 +0000
Message-Id: <20221118191909.1756624-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221118191909.1756624-1-joel@joelfernandes.org>
References: <20221118191909.1756624-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Currently, the inetdev_destroy() function waits for an RCU grace period
before decrementing the refcount and freeing memory. This causes a delay
with a new RCU configuration that tries to save power, which results in the
network interface disappearing later than expected. The resulting delay
causes test failures on ChromeOS.

Refactor the code such that the refcount is freed before the grace period
and memory is freed after. With this a ChromeOS network test passes that
does 'ip netns del' and polls for an interface disappearing, now passes.

Reported-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/ipv4/devinet.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index e8b9a9202fec..b0acf6e19aed 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -234,13 +234,20 @@ static void inet_free_ifa(struct in_ifaddr *ifa)
 	call_rcu(&ifa->rcu_head, inet_rcu_free_ifa);
 }
 
+static void in_dev_free_rcu(struct rcu_head *head)
+{
+	struct in_device *idev = container_of(head, struct in_device, rcu_head);
+
+	kfree(rcu_dereference_protected(idev->mc_hash, 1));
+	kfree(idev);
+}
+
 void in_dev_finish_destroy(struct in_device *idev)
 {
 	struct net_device *dev = idev->dev;
 
 	WARN_ON(idev->ifa_list);
 	WARN_ON(idev->mc_list);
-	kfree(rcu_dereference_protected(idev->mc_hash, 1));
 #ifdef NET_REFCNT_DEBUG
 	pr_debug("%s: %p=%s\n", __func__, idev, dev ? dev->name : "NIL");
 #endif
@@ -248,7 +255,7 @@ void in_dev_finish_destroy(struct in_device *idev)
 	if (!idev->dead)
 		pr_err("Freeing alive in_device %p\n", idev);
 	else
-		kfree(idev);
+		call_rcu(&idev->rcu_head, in_dev_free_rcu);
 }
 EXPORT_SYMBOL(in_dev_finish_destroy);
 
@@ -298,12 +305,6 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	goto out;
 }
 
-static void in_dev_rcu_put(struct rcu_head *head)
-{
-	struct in_device *idev = container_of(head, struct in_device, rcu_head);
-	in_dev_put(idev);
-}
-
 static void inetdev_destroy(struct in_device *in_dev)
 {
 	struct net_device *dev;
@@ -328,7 +329,7 @@ static void inetdev_destroy(struct in_device *in_dev)
 	neigh_parms_release(&arp_tbl, in_dev->arp_parms);
 	arp_ifdown(dev);
 
-	call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
+	in_dev_put(in_dev);
 }
 
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
-- 
2.38.1.584.g0f3c55d4c2-goog

