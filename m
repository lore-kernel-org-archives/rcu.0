Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DF3CE79AC
	for <rcu@archiver.kernel.org>; Wed, 20 Sep 2023 09:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbjITJYK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Sep 2023 05:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjITJYB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Sep 2023 05:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3971AB
        for <rcu@vger.kernel.org>; Wed, 20 Sep 2023 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695201785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rIy294xxcRG5X8mamyGReIFpqhnDJXgcIMqu9YASlB8=;
        b=KFSwJulw7wPIgWSaJ66ZfwLH6ol9Odck8K/PzapHaO141jIUPGRqAZICiSfl3ivRWAaUOJ
        /PA02CK+YhhB+ffUemJnTB4NQsbOKInT+AUnYPccWvUao6I82xTcUqi/2LhePLzajaLrlP
        Gc5jKl/Dc1cHyJvQoRfJhTDvrvcV4JM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-XBEMuqS3MbKiE8UDlmiBNw-1; Wed, 20 Sep 2023 05:23:03 -0400
X-MC-Unique: XBEMuqS3MbKiE8UDlmiBNw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5031c8d5589so673915e87.0
        for <rcu@vger.kernel.org>; Wed, 20 Sep 2023 02:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201782; x=1695806582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIy294xxcRG5X8mamyGReIFpqhnDJXgcIMqu9YASlB8=;
        b=hzjj0MnYBFG2h+6IHISzCIfpfmsUtKpa8i2n2+w3exec4eorptpVR6VRr22fj3vgIB
         2lyqinBquuzky9hR2ifvh8JMbx8GfcLq5esn56w5ZFSKIkqoGAaAI/Zc8OLqlPr9CSzL
         s21K/k9LguNeiipjkHhNHkOS8Vs4UgVoVFrHtWfCknCD6r5JpcOPeZAUiiQAbSUyqz1E
         wfDVGeeDusJY2MQ6nXmlyk9T/LO34Fdk4jWZ20l5i+tu24oVJNd/qUxj2DXfEgMyRbYy
         52vd0/LxZFdJzA93xLJMTjmhlpEQAHC3YNnipr9Ku+8tTtaokNBMNaHXSeeqe9zvr5z1
         1rgQ==
X-Gm-Message-State: AOJu0Yx5S3gnMXTznQTe+JCZ3yKGbSrJzJBFatd/NnNCmkIo327d4Hs9
        9KsqoJFOj430olkNk0pZPPH3C0/ZH1kxovQw899eMrrh6Yvz5TyFZrRyKM0TcxSP7KqylASbVeK
        7IdJrmihBNfyY
X-Received: by 2002:ac2:593c:0:b0:503:2dcd:30ed with SMTP id v28-20020ac2593c000000b005032dcd30edmr1841819lfi.0.1695201782300;
        Wed, 20 Sep 2023 02:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkxZsQBqiHyOJWqxF75XqAGlu1IOGH4PxAL385CxSZ1sXj3qO4M67md1rS1PUK28mcHvZDw==
X-Received: by 2002:ac2:593c:0:b0:503:2dcd:30ed with SMTP id v28-20020ac2593c000000b005032dcd30edmr1841799lfi.0.1695201781897;
        Wed, 20 Sep 2023 02:23:01 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id n23-20020aa7c697000000b0052e2472f884sm8544689edq.21.2023.09.20.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 02:23:01 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] rculist.h: docu: fix wrong function summary
Date:   Wed, 20 Sep 2023 11:22:12 +0200
Message-ID: <20230920092211.11371-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

The brief summary in the docstring for function list_next_or_null_rcu()
states that the function is supposed to provide the "first" member of a
list, whereas in truth it returns the next member.

Change the docstring so it describes what the function actually does.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4837d8892691..fd0ed1550a7c 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -355,7 +355,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 })
 
 /**
- * list_next_or_null_rcu - get the first element from a list
+ * list_next_or_null_rcu - get the next element from a list
  * @head:	the head for the list.
  * @ptr:        the list head to take the next element from.
  * @type:       the type of the struct this is embedded in.
-- 
2.41.0

