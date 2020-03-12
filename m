Return-Path: <SRS0=7AYa=45=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB9C10DCE
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5568D2072F
	for <rcu@archiver.kernel.org>; Thu, 12 Mar 2020 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584036699;
	bh=gwUCgCuXfCgmfeTaFQAezneavcDqd70v/8AxSh6kt+Q=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=nPRhSaV0ACcuYFY93OpuMF718uV662u/uLOngVzqwodDFJK+eu2hhTQ45QIsRDLQu
	 urs5inLpVFi58369YXIbEx2PCKo0x4bXwqpeCQTz2jZlSeKO2+uPpxxK4XaPcqzDEp
	 gD79y7ixCmBTqUW5yb+NfOvLYQxdKYjQvxPwya5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCLSLj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgCLSLj (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 12 Mar 2020 14:11:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A6120724;
        Thu, 12 Mar 2020 18:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584036698;
        bh=gwUCgCuXfCgmfeTaFQAezneavcDqd70v/8AxSh6kt+Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Shek5uFRPxbdgmJJNrWuw70YRCFlLNura5fwNj4kSx9CHtDTLT0Wp3LzDm00QXyG3
         Xix+Xsvvx/ohxO/nDN5Mrvja7cNRLXLGj2OYvF8+UOBzwN3IPRm0uEdpvgYHaY2nhx
         Zthl3B72SJ9Fq8aFdYXr3VynZwDTKAzPzLc/CPGI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 43A6035226D0; Thu, 12 Mar 2020 11:11:38 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:11:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     rcu@vger.kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, urezki@gmail.com
Subject: Re: Is there a reason we don't have kvfree_rcu()?
Message-ID: <20200312181138.GI3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200312162730.GB11889@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312162730.GB11889@SDF.ORG>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 12, 2020 at 04:27:30PM +0000, George Spelvin wrote:
> kvfree() is a superset of kfree(), so there's nothing obvious stopping 
> kfree_rcu() from simply changing to kvfree() and everything will keep 
> working.
> 
> I'd probably add a kvfree_rcu() alias, just for documentation's sake and
> to make code that depends on the new feature explode at compile time, but
> it could be identical behind the scenes.
> 
> There's an existing user in mm/list_lru.c already.
> 
> I was just thinking of using kvmalloc() in a module, and realized that the 
> lack of a core kvfree_rcu() helper meant I'd have to synchronize_rcu() on 
> module unload.

There was a recent proposal to do just that, but current patches in -rcu
use kfree_bulk().  It doesn't look to me that this works for kfvree()
under the covers in its current form.  Could it be upgraded to handle
this case?

Adding Vlad on CC for his thoughts.

							Thanx, Paul
