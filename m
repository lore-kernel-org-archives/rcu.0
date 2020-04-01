Return-Path: <SRS0=yXb9=5R=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D81AC43331
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 12:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AB320776
	for <rcu@archiver.kernel.org>; Wed,  1 Apr 2020 12:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585742707;
	bh=NhoPRsRq/YyLa+Vf1+G6SIlFLJ5p1f4hh/gZAzLwVPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0AV2+PAXsiU0lqUCCCM3i1lXM5Enjy4Deo5ua0JXF2+WprMcpumnycq6AqItGMp8Y
	 N8T6pU6e+/dRJE/aeFgS70Tf6WgktK/vPbr8a6zMLHXXBJ5Cx31BWQGnzsmC5qcWsi
	 CcJZwFoA8JyHy+SFDZOsQt/YgRpm4bDau0mF3uUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbgDAMFG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:05:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35475 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732246AbgDAMFG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Apr 2020 08:05:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id d5so30308548wrn.2;
        Wed, 01 Apr 2020 05:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2qHESkVe3nhbeIsGwZeWdkb1tB2ydLYFVJb0HdBY5Q8=;
        b=sZdOXshtKPrMdliQmaplnIfrDHfyEt5qZQZcBHJXaYh04rnsOysfI19HxdOyMyqhDl
         /JsNfA4qQWIWzLTn1ug5HAffO4AWvl2l6R6zRVUnqNT5kEQh9zbVKL3lxs4cQvFJ9/z0
         17FG592k+FTvwoYa1/Y/rHhxKt7ATH4J0EgiGxKoKIqNlcJbE8RRY7vNJ+rrjM6FINqs
         4u0hPoCyAPbVzVR1SpGyepJxm7TbZ9iT5jy8wLPa8M6icCpOSmVM+fFLtN5/8/fyGU9a
         GyDTbhCzAljzwjZToDl4pKMKRP/S6lI8WnUmaa6mGU51fbREPQEJqrijIQap9ay1Itpa
         shKw==
X-Gm-Message-State: ANhLgQ3mcdKZ238CBuiWydXFQHLRPnY83537t7v/33H1YbXKrMZaFEBJ
        bfuYdUpuS9GygNRoPzxyr7lhbTn/
X-Google-Smtp-Source: ADFU+vtfgdGL9hubYcT6d3Hh/gPXpmGPiuRY7Uj/WWVpV52yieI7MXiVPFLc68WpRZK+6w4X9jUCVw==
X-Received: by 2002:adf:8187:: with SMTP id 7mr26810166wra.358.1585742704551;
        Wed, 01 Apr 2020 05:05:04 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id h132sm2546019wmf.18.2020.04.01.05.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 05:05:03 -0700 (PDT)
Date:   Wed, 1 Apr 2020 14:05:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200401120502.GH22681@dhcp22.suse.cz>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331145806.GB236678@google.com>
 <20200331153450.GM30449@dhcp22.suse.cz>
 <20200331160117.GA170994@google.com>
 <20200401072359.GC22681@dhcp22.suse.cz>
 <30295C90-34DB-469C-9DCD-55DB91938BA9@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30295C90-34DB-469C-9DCD-55DB91938BA9@joelfernandes.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed 01-04-20 07:14:16, joel@joelfernandes.org wrote:
[...]
> I am in support of this documentation patch. I would say "consumption of the reserve".

Like this?

From afc9c4e56c6dd5f59c1cf5f95ad42a0e7cd78b2e Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Wed, 1 Apr 2020 14:00:56 +0200
Subject: [PATCH] mm: clarify __GFP_MEMALLOC usage

It seems that the existing documentation is not explicit about the
expected usage and potential risks enough. While it is calls out
that users have to free memory when using this flag it is not really
apparent that users have to careful to not deplete memory reserves
and that they should implement some sort of throttling wrt. freeing
process.

This is partly based on Neil's explanation [1].

[1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/gfp.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e5b817cb86e7..e3ab1c0d9140 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -110,6 +110,9 @@ struct vm_area_struct;
  * the caller guarantees the allocation will allow more memory to be freed
  * very shortly e.g. process exiting or swapping. Users either should
  * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
+ * Users of this flag have to be extremely careful to not deplete the reserve
+ * completely and implement a throttling mechanism which controls the consumption
+ * of the reserve based on the amount of freed memory.
  *
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
-- 
2.25.1

-- 
Michal Hocko
SUSE Labs
