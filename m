Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ADDC10DCE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 22:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A5620637
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 22:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgCLW0a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:26:30 -0400
Received: from mx.sdf.org ([205.166.94.20]:51535 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgCLW0a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 18:26:30 -0400
Received: from sdf.org (IDENT:lkml@rie.sdf.org [205.166.94.4])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02CMOje3017115
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Thu, 12 Mar 2020 22:24:45 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02CMOilH017145;
        Thu, 12 Mar 2020 22:24:44 GMT
Date:   Thu, 12 Mar 2020 22:24:44 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, urezki@gmail.com, lkml@sdf.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200312222444.GA20080@SDF.ORG>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312181138.GI3199@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> There was a recent proposal to do just that, but current patches in -rcu
> use kfree_bulk().  It doesn't look to me that this works for kfvree()
> under the covers in its current form.  Could it be upgraded to handle
> this case?

It would take a bit more fiddling, but nothing too difficult.

// from include/linux/mm.h
static inline bool is_vmalloc_addr(const void *x)
{
	unsigned long addr = (unsigned long)x;

	return addr >= VMALLOC_START && addr < VMALLOC_END;
}
// ... which could also be written as (addr - VMALLOC_START) < VMALLOC_TOTAL

// from mm/util.c
void kvfree(const void *addr)
{
	if (is_vmalloc_addr(addr))
		vfree(addr);
	else
		kfree(addr);
}

... so you could easily do the filtering yourself while forming the
kfree_bulk array.

vfree(p) itself is a wrapper around __vunmap(p, 1).  After some 
error-checking, it checks if it's called in interrupt context,
If not, it does the __vunmap synchronously.  If it *is* in interrupt
context, the freed object is put on a linked list and a work queue
does the __vunmap later.
