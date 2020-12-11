Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B1C4361B
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 03:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F2723ECE
	for <rcu@archiver.kernel.org>; Fri, 11 Dec 2020 03:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbgLKDng (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Dec 2020 22:43:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:57156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391130AbgLKDnI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Dec 2020 22:43:08 -0500
Date:   Thu, 10 Dec 2020 19:42:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607658147;
        bh=aVyB5tvoBROSnm5VRT1WJXpC3r3ukn7gssJ/P/aK8BQ=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d4z+H2AlZ5RQve9ZA2JjgR1LoxIXv2qg3Ccm4s2aqerrNVxoS6rNxgN9BbEw3FbPL
         SufuqdVrNfBOMIQg8daSdQzMkr4EwiQwOelmiwdaTt3dcPvLgMmuw7Zt8tGgSYuHsX
         rIfgc+/WLk1H3Onm5ikwWbZLdIqZkqRk0zyXhqfKgxEV5VhdkGSYESl3dBMYZKPAH/
         MGJRizsFpvZKqx7HxOsVPMewaiiRUWVf23j55uluw+Slz9KZxGdYoCyphRHa9NSmFv
         6RcpDgo3u7ND9yJeI8vdEViR6/XSKJZtsS/fy9pxvQ2H5TFZeEOHro3dCKIrNB2Ry3
         Y7/cC/Q1cAu/g==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        andrii@kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH v3 sl-b 1/6] mm: Add mem_dump_obj() to print source of
 memory block
Message-ID: <20201211034226.GA2116@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201211011907.GA16110@paulmck-ThinkPad-P72>
 <20201211012003.16473-1-paulmck@kernel.org>
 <20201211022205.GA11631@js1304-desktop>
 <20201211033359.GD2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211033359.GD2657@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 10, 2020 at 07:33:59PM -0800, Paul E. McKenney wrote:
> On Fri, Dec 11, 2020 at 11:22:10AM +0900, Joonsoo Kim wrote:
> > On Thu, Dec 10, 2020 at 05:19:58PM -0800, paulmck@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>

[ . . . ]

> > We can get some infos even if CONFIG_SLUB_DEBUG isn't defined.
> > Please move them out.
> 
> I guess since I worry about CONFIG_MMU=n it only makes sense to also
> worry about CONFIG_SLUB_DEBUG=n.  Fix update.

Like this?  (Patch on top of the series, to be folded into the first one.)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/mm/slub.c b/mm/slub.c
index 0459d2a..abf43f0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3920,21 +3920,24 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 
 void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 {
-#ifdef CONFIG_SLUB_DEBUG
 	void *base;
-	int i;
+	int __maybe_unused i;
 	unsigned int objnr;
 	void *objp;
 	void *objp0;
 	struct kmem_cache *s = page->slab_cache;
-	struct track *trackp;
+	struct track __maybe_unused *trackp;
 
 	kpp->kp_ptr = object;
 	kpp->kp_page = page;
 	kpp->kp_slab_cache = s;
 	base = page_address(page);
 	objp0 = kasan_reset_tag(object);
+#ifdef CONFIG_SLUB_DEBUG
 	objp = restore_red_left(s, objp0);
+#else
+	objp = objp0;
+#endif
 	objnr = obj_to_index(s, page, objp);
 	kpp->kp_data_offset = (unsigned long)((char *)objp0 - (char *)objp);
 	objp = base + s->size * objnr;
@@ -3942,6 +3945,7 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
 	if (WARN_ON_ONCE(objp < base || objp >= base + page->objects * s->size || (objp - base) % s->size) ||
 	    !(s->flags & SLAB_STORE_USER))
 		return;
+#ifdef CONFIG_SLUB_DEBUG
 	trackp = get_track(s, objp, TRACK_ALLOC);
 	kpp->kp_ret = (void *)trackp->addr;
 #ifdef CONFIG_STACKTRACE
