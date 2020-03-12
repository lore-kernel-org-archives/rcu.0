Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1707AC10DCE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E022067C
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 16:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCLQg0 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:36:26 -0400
Received: from mx.sdf.org ([205.166.94.20]:61637 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCLQg0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 12:36:26 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 12:36:24 EDT
Received: from sdf.org (IDENT:lkml@rie.sdf.org [205.166.94.4])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02CGRVO6025303
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Thu, 12 Mar 2020 16:27:31 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02CGRUTl000866;
        Thu, 12 Mar 2020 16:27:30 GMT
Date:   Thu, 12 Mar 2020 16:27:30 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     rcu@vger.kernel.org
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, lkml@sdf.org
Subject: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200312162730.GB11889@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

kvfree() is a superset of kfree(), so there's nothing obvious stopping 
kfree_rcu() from simply changing to kvfree() and everything will keep 
working.

I'd probably add a kvfree_rcu() alias, just for documentation's sake and
to make code that depends on the new feature explode at compile time, but
it could be identical behind the scenes.

There's an existing user in mm/list_lru.c already.

I was just thinking of using kvmalloc() in a module, and realized that the 
lack of a core kvfree_rcu() helper meant I'd have to synchronize_rcu() on 
module unload.
