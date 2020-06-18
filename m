Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A3C433E0
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C99207DD
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 18:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oTv1W5/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFRSPo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgFRSPn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 14:15:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D2C06174E;
        Thu, 18 Jun 2020 11:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kJCSM+lT7eN878npx59JZNam/q/gzo1rfV4XChTT5Y4=; b=oTv1W5/XKMdGXDoAucoP7vrSrC
        D/8eHKR6jrWgKaDtdZFXj4xdj3yQ72CxsXd6lEjyq+Gxa2SSVGK0IfiPhbl8zPpKsJfj+r+Jms3tc
        0RmHox4to9IXuuyLTWfvl1llJWDFt47rHL2dU5r0OVZFtHj5sW/KANZWG4YQbONDI4xiopVivZo94
        wJ+gNBVU32/KxbrmCuE5/xjPBUj+NR4PShu4UKYBKQ3bIUsjfnXHWd9DoKAjuVOlDz1Hyxa7fMTY6
        fSEOR09Uzu5L0LwqyjB02jBPGEKRv7aYzWl7HwguM3US4YDLhfNdiRWQrYsIzOyE6bSnDMQsLRweJ
        YvPlVseg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlz4g-00048V-1X; Thu, 18 Jun 2020 18:15:42 +0000
Date:   Thu, 18 Jun 2020 11:15:41 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 09/16] rcu/tree: Maintain separate array for vmalloc
 ptrs
Message-ID: <20200618181541.GS8681@bombadil.infradead.org>
References: <20200525214800.93072-1-urezki@gmail.com>
 <20200525214800.93072-10-urezki@gmail.com>
 <20200617234609.GA10087@paulmck-ThinkPad-P72>
 <20200618172504.GA14613@pc636>
 <20200618173206.GS2723@paulmck-ThinkPad-P72>
 <20200618175623.GA14865@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618175623.GA14865@pc636>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 07:56:23PM +0200, Uladzislau Rezki wrote:
> If we mix pointers, then we can do free per pointer only. I mean in that
> case we will not be able to use kfree_bulk() interface for freeing SLAB
> memory and the code would converted to something like:
> 
> <snip>
> while (nr_objects_in_array > 0) {
>     if (is_vmalloc_addr(array[X]))
>        vfree(array[X]);
>     else
>        kfree(array[X]);
> }
> <snip>

[PATCH] Add vfree_bulk interface

This is a useful interface to have for the RCU kvfree code.  There is
scope for more performance gains later, but introducing the interface
now allows us to simplify the RCU code today.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 48bb681e6c2a..dc2bbb61af61 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -119,6 +119,7 @@ void *__vmalloc_node(unsigned long size, unsigned long align, gfp_t gfp_mask,
 
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
+extern void vfree_bulk(size_t count, void **addrs);
 
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index abe37f09ac42..6042f9b4394a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2366,6 +2366,22 @@ void vfree(const void *addr)
 }
 EXPORT_SYMBOL(vfree);
 
+void vfree_bulk(size_t count, void **addrs)
+{
+	unsigned int i;
+
+	BUG_ON(in_nmi());
+	might_sleep_if(!in_interrupt());
+
+	for (i = 0; i < count; i++) {
+		void *addr = addrs[i];
+		kmemleak_free(addr);
+		if (addr)
+			__vfree(addr);
+	}
+}
+EXPORT_SYMBOL(vfree_bulk);
+
 /**
  * vunmap - release virtual mapping obtained by vmap()
  * @addr:   memory base address
