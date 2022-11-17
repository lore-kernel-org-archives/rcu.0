Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA143C4332F
	for <rcu@archiver.kernel.org>; Thu, 17 Nov 2022 03:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKQDQI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 16 Nov 2022 22:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbiKQDQG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 16 Nov 2022 22:16:06 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038563BBE
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:16:05 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d7so404433qkk.3
        for <rcu@vger.kernel.org>; Wed, 16 Nov 2022 19:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVyiieWly24z0z0fYFBjEvhMrkOmEI6OGYeufoegUM4=;
        b=phUx/1hExUXj+l6ZupXb949+eS0h2KoDX51zvVMU7Ie7h3iZCBke2E+BGODPJBV4tL
         xGjPEH8PMNVD5NL6U0rDwSD9odVjl6CMe7+lYIMoTphmU1iyZXlh7qyciMp422Gumrv7
         eeX0U1xVIh4mhYZ+0J4/xwfFnxRJXhOqK1gQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVyiieWly24z0z0fYFBjEvhMrkOmEI6OGYeufoegUM4=;
        b=UAtW5fcsh0+QGHq/Tz938UeDhlsI7Uez2/Ebn3OOqne60m+1d59U3uMhMrkgUg4QRC
         VDv7ojMjhcusTQLQzh5BeH+go2DKC7NKGuPqblo38y8C79ip1WyOW3vuLBaa8YZoRU5k
         VLs+MH1KaDXdubbHCmpgJ11kh6JfXKYqDo+nowiGDh9BAid3hhH1sfeQBsVjvxWgQRGG
         TmKiOLg2MjStVXeO9CBq/hz9RmYt5AzdGFR5kwfqzZxk+P/mOCBbDz6GkfRoZGezbMyf
         S+7VSe/Ykmf7KpGrf9BLutAvCReS7QEsrJ3erpidz7P7iqYOJidmqr0Rq0cqHlEhxIgd
         KJQA==
X-Gm-Message-State: ANoB5pkEuvv2Fc1c9Kn4/6QmwLQYjvSzXNXzT1fkZMjgCy6QnxVMy23x
        02JawiYtxWRduKW4NeRZ2wSAOg==
X-Google-Smtp-Source: AA0mqf4iZQlFujHEBGLFvhYWg4vhUvvJjjCO/pv1TcbmlblMbmZxj6HXge1lTpprJ/0n5Y9W2BGmxQ==
X-Received: by 2002:a05:620a:459f:b0:6fa:f76d:bbc1 with SMTP id bp31-20020a05620a459f00b006faf76dbbc1mr307187qkb.11.1668654964533;
        Wed, 16 Nov 2022 19:16:04 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id k19-20020a05620a415300b006cdd0939ffbsm11398318qko.86.2022.11.16.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 19:16:04 -0800 (PST)
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
Subject: [PATCH rcu/dev 2/3] net: Use call_rcu_flush() for in_dev_rcu_put
Date:   Thu, 17 Nov 2022 03:15:49 +0000
Message-Id: <20221117031551.1142289-2-joel@joelfernandes.org>
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
 net/ipv4/devinet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index e8b9a9202fec..98b20f333e00 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -328,7 +328,7 @@ static void inetdev_destroy(struct in_device *in_dev)
 	neigh_parms_release(&arp_tbl, in_dev->arp_parms);
 	arp_ifdown(dev);
 
-	call_rcu(&in_dev->rcu_head, in_dev_rcu_put);
+	call_rcu_flush(&in_dev->rcu_head, in_dev_rcu_put);
 }
 
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
-- 
2.38.1.584.g0f3c55d4c2-goog

