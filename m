Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0FBC2BA4C
	for <rcu@archiver.kernel.org>; Wed, 26 Jan 2022 20:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiAZUHH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jan 2022 15:07:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48390 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiAZUHG (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 26 Jan 2022 15:07:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D70EB81DCF
        for <rcu@vger.kernel.org>; Wed, 26 Jan 2022 20:07:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23476C340E3;
        Wed, 26 Jan 2022 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643227624;
        bh=0n0XfkUqAiHXfyFoFLEmezJtyVIj+mi9SHAntOnBwgA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QqIc5gBJBQ5RIw0CB/kxyYJ7lUVF5YwInqzvL3bAMBm/HW5CEJFgxf09IMbS7X4uA
         /Yfh3LimlzefAxZcTTJFwgNsWvd/cm3c62PhEp8VAwL64TJK6dV6MIyr8wuBzQcXRA
         +2Ec0FiHdLcwt8rNpSWRDld2bQOhNL6TMDkKdt3vErdL67HBf52R9mJ/1Mk+WslIyI
         xr/SnpYrci2zZw3cV6hm2WDHoXAV9xKsF+N+rEVZlNy6M7eFsny2+XmEsU0UQEQiOd
         v4myb3vrGP5Nq6BnF9nx5HDukqYO0kiQwQ3oSGrvxeIIjZ+fex3jorqQ3l9uLoTzOy
         2km4DsxP8teqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DB7EB5C043B; Wed, 26 Jan 2022 12:07:03 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:07:03 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, rcu@vger.kernel.org,
        cluster-devel@redhat.com
Subject: Re: [PATCH] srcutree: use export for srcu_struct defined by
 DEFINE_STATIC_SRCU()
Message-ID: <20220126200703.GZ4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220126150354.3644838-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126150354.3644838-1-aahringo@redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jan 26, 2022 at 10:03:54AM -0500, Alexander Aring wrote:
> This patch fixes a sparse issue if DEFINE_STATIC_SRCU() of srcutree is
> used by a module. Sparse will show:
> 
> sparse: symbol '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> 
> The problem is here that the DEFINE_STATIC_SRCU() of srcutree uses
> __DEFINE_SRCU() and define a non-static srcu_struct. This srcu_struct
> will be exported by inserting it in a special module section
> '__section("___srcu_struct_ptrs")'. During load/unloading srcutree runs
> their init/cleanup functionality. It seems sparse does not understand
> this connection. To avoid the sparse warning we make a prototype of the
> exported srcu_struct with an export keyword. This way we tell the
> that the srcu_struct might be used outside of the module.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Queued for further review and testing, thank you!!!

As usual, I could not resist the urge to wordsmith a bit.  Could you
please check below in case I messed something up?

							Thanx, Paul

------------------------------------------------------------------------

commit fa92d727f94486195e12dc782fec17d103072101
Author: Alexander Aring <aahringo@redhat.com>
Date:   Wed Jan 26 10:03:54 2022 -0500

    srcutree: Use export for srcu_struct defined by DEFINE_STATIC_SRCU()
    
    If an srcu_struct structure defined by tree SRCU's DEFINE_STATIC_SRCU()
    is used by a module, sparse will give the following diagnostic:
    
    sparse: symbol '__srcu_struct_nodes_srcu' was not declared. Should it be static?
    
    The problem is that a within-module DEFINE_STATIC_SRCU() must define
    a non-static srcu_struct because it is exported by referencing it in a
    special '__section("___srcu_struct_ptrs")'.  This reference is needed
    so that module load and unloading can invoke init_srcu_struct() and
    cleanup_srcu_struct(), respectively.  Unfortunately, sparse is unaware of
    '__section("___srcu_struct_ptrs")', resulting in the above false-positive
    diagnostic.  To avoid this false positive, this commit therefore creates
    a prototype of the srcu_struct with an "extern" keyword.
    
    Signed-off-by: Alexander Aring <aahringo@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 8501b6b459411..44e998643f483 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -131,6 +131,7 @@ struct srcu_struct {
 #ifdef MODULE
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
+	extern struct srcu_struct * const __srcu_struct_##name;		\
 	struct srcu_struct * const __srcu_struct_##name			\
 		__section("___srcu_struct_ptrs") = &name
 #else
