Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F0EB64D9
	for <rcu@archiver.kernel.org>; Thu,  6 Jul 2023 10:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjGFK3Y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Jul 2023 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGFK3X (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Jul 2023 06:29:23 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958C01BCC;
        Thu,  6 Jul 2023 03:29:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-668704a5b5bso484579b3a.0;
        Thu, 06 Jul 2023 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688639362; x=1691231362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcBm3tIPDYjaiJYtej3V+EGlEbrFWBZv2rFb8nvh3TM=;
        b=XtYlo7GiKeg0vttl4mWNuLr/TzVJOKTEj+YFuVmcPXjvMjK+MpVDj7DA/JalO3GIxR
         hTVearElLUpntFjHD20Mn3dyu4+tALjwErzxTJnn1a9g+c9LinhYHeF8DblrVQFt4uNJ
         2L7tirS90lVgaHOFKMK2frzJzTuiqHeJXBj8RbTh8IhYEwzURUM9hFaUUAwI57rpnRqc
         Mz2AOQE+YmwJykf+t6BW0i+pipfliIWKgu8WCaqsVilBDMJ3Im5BwzGGsab7HD9nk3wq
         ufVgvfUYuP4ymhBge3lawMcO1u9P6pr5gNzNwFElnRu1FZkEozhf/EvVHtXNnuqYZhj5
         NoMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688639362; x=1691231362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcBm3tIPDYjaiJYtej3V+EGlEbrFWBZv2rFb8nvh3TM=;
        b=KrKQfPzdLr2XtIMi7eMNdPG3vcgc4rhnJHQlx/Nb/erSB02nVdUQo7ieWv1RL6I3sX
         YNWZnFlAk9MvtNkaGJl0GHRbnajnizOCPqQ8fHknDN1CPsX04WGCHn21L8Oj5u3eex36
         rUKZ/hAYjA2246QDq1t1zyoHRwWUgmhX3DnkV9mhagFjPnvQ1gq6Gn/ZtZxXRPZNgtVU
         AqUKvbVLhWLWR60U0qmdoM4FUy69oJ8H5Ty7K+/qNi212CfP/N1NH6fRQ+SaawNa3H6f
         Fcp8RztEHMDU+75lm3xChF94eUwqQMw26TSXm8azjf8q3MS53s//plsNnaUQm+s5gSWe
         ulCw==
X-Gm-Message-State: ABy/qLZEnn/O7/3QviYuNcTf3aOYOmPf+IK6NiQGaiGDbI6Fy9Gh6sL+
        gHBpjkx7BpMWSlTz+RRqhPc=
X-Google-Smtp-Source: APBJJlHEsb5IoJZ00ytZJiqM5dS8+VVGstH4ybAo0LHSmC6/cSczMkE1jRCATMAVN94SoLy0iShd/g==
X-Received: by 2002:a05:6a00:1790:b0:681:c372:5aa4 with SMTP id s16-20020a056a00179000b00681c3725aa4mr1778465pfg.27.1688639361080;
        Thu, 06 Jul 2023 03:29:21 -0700 (PDT)
Received: from localhost ([2402:d0c0:2:a2a::1])
        by smtp.gmail.com with ESMTPSA id l3-20020a62be03000000b0067aea93af40sm1008849pff.2.2023.07.06.03.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 03:29:20 -0700 (PDT)
From:   Alan Huang <mmpgouride@gmail.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, corbet@lwn.net
Cc:     rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Huang <mmpgouride@gmail.com>
Subject: [PATCH 1/2] rcu: Use WRITE_ONCE() for assignments to ->next for rculist_nulls
Date:   Thu,  6 Jul 2023 10:28:48 +0000
Message-Id: <20230706102849.437687-2-mmpgouride@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706102849.437687-1-mmpgouride@gmail.com>
References: <20230706102849.437687-1-mmpgouride@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

When the objects managed by rculist_nulls are allocated with
SLAB_TYPESAFE_BY_RCU, readers may still hold references to this
object that is being added, which means the modification of ->next
is visible to readers. So, this patch uses WRITE_ONCE() for assignments
to ->next.

Signed-off-by: Alan Huang <mmpgouride@gmail.com>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index ba4c00dd8005..89186c499dd4 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -101,7 +101,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
 {
 	struct hlist_nulls_node *first = h->first;
 
-	n->next = first;
+	WRITE_ONCE(n->next, first);
 	WRITE_ONCE(n->pprev, &h->first);
 	rcu_assign_pointer(hlist_nulls_first_rcu(h), n);
 	if (!is_a_nulls(first))
@@ -137,7 +137,7 @@ static inline void hlist_nulls_add_tail_rcu(struct hlist_nulls_node *n,
 		last = i;
 
 	if (last) {
-		n->next = last->next;
+		WRITE_ONCE(n->next, last->next);
 		n->pprev = &last->next;
 		rcu_assign_pointer(hlist_nulls_next_rcu(last), n);
 	} else {
-- 
2.34.1

