Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2F9ECAAD3
	for <rcu@archiver.kernel.org>; Thu,  1 Sep 2022 22:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiIAWSB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbiIAWSA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:00 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB05809B
        for <rcu@vger.kernel.org>; Thu,  1 Sep 2022 15:17:59 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id y17so170944qvr.5
        for <rcu@vger.kernel.org>; Thu, 01 Sep 2022 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+2CQoWOzORwmFm7W8hobFnBssU2v8aOfIo1J22tLn5A=;
        b=gYFVtvH6IT88YOW+VuemDQdOw9jN1vrqUhqD4F59DGDWIburm49TpkXGVQY87YJ84L
         qH6wa/UO5erX3ioCJY2/tLyTnBhtQ1+KSn2ciZl3SpPmczkva7MHX/hbiZhzntNqv0Q4
         KArjDPxW26NuxuN0qO1Zj5kVlXjgrE+8nGLpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+2CQoWOzORwmFm7W8hobFnBssU2v8aOfIo1J22tLn5A=;
        b=eNYAoMqTHCILpDM6ci+EyaOjXY1ZLLo0hcA0P7wmCb6IzgH5IQFxH7REFPDN0NyEkx
         zwRDFo1g4iv/sNU1FVmRQX8Fg9DFlNnWxCReh8tnoSAiV3XKc9yt5Ph9+cYtI17/H0+f
         /MR+lNJxuaK2sEr5G39Um3hdM8+GBPmxiiIg1tNreSd4Je1V8LicVKT/+kGdoGi5DvMa
         vpJz0D96Wm/OuNhCoZDBbLhcORYJIL0xcLkZFvlNbnamHZPc5+HoywV9z6TDkaHF4CCZ
         rh8XhQmezqMfAbCgbUtkY4fFS6q4AoDP2we4PfUxWXKRRQfJeUFzQ5wMgCTm2/InMDpe
         WAlQ==
X-Gm-Message-State: ACgBeo2LYk+oQE5WJAj8tCTWmiTnzxz/bIgF6PeZAnnKNQ0MKJ/x9ygc
        3QZnkxJGfilreolgZgccqgkishsC3te1QQ==
X-Google-Smtp-Source: AA6agR4kxLtEYufGPqZXnLYzR+tmjfowzJgSuRNILICeEUEdChLKGM9hmPATH/Xdqmcnc+IW5AQBNw==
X-Received: by 2002:a05:6214:2a4b:b0:499:eb9:6ed3 with SMTP id jf11-20020a0562142a4b00b004990eb96ed3mr14878236qvb.66.1662070678188;
        Thu, 01 Sep 2022 15:17:58 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:17:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v5 01/18] mm/slub: perform free consistency checks before call_rcu
Date:   Thu,  1 Sep 2022 22:17:03 +0000
Message-Id: <20220901221720.1105021-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Vlastimil Babka <vbabka@suse.cz>

For SLAB_TYPESAFE_BY_RCU caches we use call_rcu to perform empty slab
freeing. The rcu callback rcu_free_slab() calls __free_slab() that
currently includes checking the slab consistency for caches with
SLAB_CONSISTENCY_CHECKS flags. This check needs the slab->objects field
to be intact.

Because in the next patch we want to allow rcu_head in struct slab to
become larger in debug configurations and thus potentially overwrite
more fields through a union than slab_list, we want to limit the fields
used in rcu_free_slab().  Thus move the consistency checks to
free_slab() before call_rcu(). This can be done safely even for
SLAB_TYPESAFE_BY_RCU caches where accesses to the objects can still
occur after freeing them.

As a result, only the slab->slab_cache field has to be physically
separate from rcu_head for the freeing callback to work. We also save
some cycles in the rcu callback for caches with consistency checks
enabled.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 862dbd9af4f5..d86be1b0d09f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2036,14 +2036,6 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	int order = folio_order(folio);
 	int pages = 1 << order;
 
-	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
-		void *p;
-
-		slab_pad_check(s, slab);
-		for_each_object(p, s, slab_address(slab), slab->objects)
-			check_object(s, slab, p, SLUB_RED_INACTIVE);
-	}
-
 	__slab_clear_pfmemalloc(slab);
 	__folio_clear_slab(folio);
 	folio->mapping = NULL;
@@ -2062,9 +2054,17 @@ static void rcu_free_slab(struct rcu_head *h)
 
 static void free_slab(struct kmem_cache *s, struct slab *slab)
 {
-	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU)) {
+	if (kmem_cache_debug_flags(s, SLAB_CONSISTENCY_CHECKS)) {
+		void *p;
+
+		slab_pad_check(s, slab);
+		for_each_object(p, s, slab_address(slab), slab->objects)
+			check_object(s, slab, p, SLUB_RED_INACTIVE);
+	}
+
+	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
 		call_rcu(&slab->rcu_head, rcu_free_slab);
-	} else
+	else
 		__free_slab(s, slab);
 }
 
-- 
2.37.2.789.g6183377224-goog

