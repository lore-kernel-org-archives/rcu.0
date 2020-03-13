Return-Path: <SRS0=Iwfc=46=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013B4C10DCE
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 18:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F91206E7
	for <rcu@archiver.kernel.org>; Fri, 13 Mar 2020 18:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMSsH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:48:07 -0400
Received: from mx.sdf.org ([205.166.94.20]:52525 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCMSsH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 Mar 2020 14:48:07 -0400
Received: from sdf.org (IDENT:lkml@otaku.sdf.org [205.166.94.8])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02DIkg1b003155
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Fri, 13 Mar 2020 18:46:42 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02DIkfwb000120;
        Fri, 13 Mar 2020 18:46:41 GMT
Date:   Fri, 13 Mar 2020 18:46:41 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, lkml@sdf.org
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200313184641.GA14782@SDF.ORG>
References: <20200312162730.GB11889@SDF.ORG>
 <20200312181138.GI3199@paulmck-ThinkPad-P72>
 <20200312191009.GA27429@pc636>
 <20200313050659.GA22938@SDF.ORG>
 <20200313135400.GQ3199@paulmck-ThinkPad-P72>
 <20200313165219.GA1384@SDF.ORG>
 <20200313181917.GY3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313181917.GY3199@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 13, 2020 at 11:19:17AM -0700, Paul E. McKenney wrote:
> Another approach would be to terminate with a NULL pointer, or with the
> end of the array, as the case may be.

That's the basic idea, but you want to be able to append a pointer
in O(1) time, and a simple null-termination requires a linear search.

It's obfuscation for negligible gain, however, so I'm sorry I
bothered mentioning it.
