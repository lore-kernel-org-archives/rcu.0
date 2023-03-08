Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FB7C64EC4
	for <rcu@archiver.kernel.org>; Wed,  8 Mar 2023 15:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCHPBS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 8 Mar 2023 10:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCHPBR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 8 Mar 2023 10:01:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B454C11;
        Wed,  8 Mar 2023 07:01:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5682A617A1;
        Wed,  8 Mar 2023 15:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2725BC433D2;
        Wed,  8 Mar 2023 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678287675;
        bh=qv5C1L8csKZToknaBrvzw2vea6w9XFGrBtmS3nomm9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFbcilUGpJvbGKop5g0/U84ZSfsaa4AZbq7UCovVTAgZJu2igUnFeRiLamd9cZOW5
         LyJukq0qYu6lPtxaojRMouwB0n+8IxRAof50BObmzzBC+WqqJ+/wu2AiEKDl1QY3RX
         xFSw1Ee0lFvXtWsnBJd3FVccdRkSUdL9yy2Ob6sxyEC4qXmTAppLEhVx7o9iX/e7uE
         Q9C7XIRksGYt2BayIv6mHpue4EyQSs+9q2Xa5bf8zzF+6KtXSNg+aIFl8ajih4kBh1
         A+9Qa8se/uz5nRFcn0WtswfpYdRixeJE54TZ3ZVfBCZaxKAQAvxvxK08b+GuOiZqQX
         YKgNee6POXmJg==
Date:   Wed, 8 Mar 2023 16:01:12 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, urezki@gmail.com
Subject: Re: [PATCH v3] rcu: Add a minimum time for marking boot as completed
Message-ID: <ZAijOO0vEiiDn+Ex@lothringen>
References: <ZAdyGANbQhduAFTM@lothringen>
 <FF43EB74-026D-4863-8926-8DB40FED5930@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF43EB74-026D-4863-8926-8DB40FED5930@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 08, 2023 at 05:52:50AM -0800, Joel Fernandes wrote:
> Just to add to previous reply:
> 
> One thing to consider is that it is more of a performance improvement for
> booting in expedited mode to fallback to normal later, than a bug
> fix. Repeated synchronize_rcu() can easily add 100s of milliseconds and to
> remedy that — a conversion of the call from normal API to the expedited API
> will not help.

2 things to consider:

1) Is it this about specific calls to synchronize_rcu() that repeat a lot
   and thus create such measurable impact? If so the specific callsites should
   be considered for a conversion.

2) Is it about lots of different calls to synchronize_rcu() that gather a big
   noise? Then the solution is different.

Again without proper analysis, what do we know?

Thanks.
