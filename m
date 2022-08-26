Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BC2ECAAA3
	for <rcu@archiver.kernel.org>; Fri, 26 Aug 2022 09:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiHZJJZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240799AbiHZJJY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 Aug 2022 05:09:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DED6313
        for <rcu@vger.kernel.org>; Fri, 26 Aug 2022 02:09:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B1ADB1F949;
        Fri, 26 Aug 2022 09:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661504962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9r9Y4nrZ+UpyPTbE+b0JTOOTRnErnN2EMFHblvWV84E=;
        b=1zj74Bqwu3CTKrmQX2WgTQRQgNgsM6b/3rEm8rXayTVXOt6R4xf6cw4qRAyT6P9MBGslcU
        CsYfyZSyjwYwh9xGaXuLWWSPFeuvI68bVv23oqo9rARSL+n4Yr83kvUhC0c2PhyuuIO3Ta
        NDriDbPEWpySeZWurnO++rGdbjQgRIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661504962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9r9Y4nrZ+UpyPTbE+b0JTOOTRnErnN2EMFHblvWV84E=;
        b=NRwqt9pvr6ZcrbAvXxxfl+2QZ1GFMkaMHWwsyZ4aCpvSZFwQWK2sIJoSFBTaml01kHkTL7
        BotrAix6sMBCpqBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8351013421;
        Fri, 26 Aug 2022 09:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EkdtH8KNCGOxOAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 26 Aug 2022 09:09:22 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH 1/2] mm/slub: perform free consistency checks before call_rcu
Date:   Fri, 26 Aug 2022 11:09:11 +0200
Message-Id: <20220826090912.11292-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

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
2.37.2

