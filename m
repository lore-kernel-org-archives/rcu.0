Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE63EC43334
	for <rcu@archiver.kernel.org>; Tue, 14 Jun 2022 11:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiFNLmb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 14 Jun 2022 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238564AbiFNLm3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 14 Jun 2022 07:42:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45A7E0CD;
        Tue, 14 Jun 2022 04:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28DFBB817DD;
        Tue, 14 Jun 2022 11:42:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C229C3411E;
        Tue, 14 Jun 2022 11:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655206941;
        bh=/o7y2/l9DHmtQ3bRkAr5fvtaNX33HWKQ5r1f0IUnWEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ko/k/hrlg3NenB0YrXj6aaKfJ2Xh9cVGhYh3YW3swIXRAEUMyz65eMGaPdDl80Eb6
         N64gyEN/5aGFImYSpy7FKdIF0Nc3+0ZJ2/2+4ILsWMpjujFT8GNczR58ijna3z0EIE
         frl53Ezq5PI2OMTxH0iQUbeW/bPEXgQ4gmmevDYe+3/SoVf5YIdVFuraA9EW9tilSP
         3KGihjhW7FnqgbbnP1PlNVnK1pi2d3YH4adhi5tjsQwjQ3j1hJQojupa2bRSGA1tcM
         e2X4EmsA1oH+9/zmFP7vawsFn0+QFxainLNYWbNXWg5DgMcrV2ejcrzPrHyx5a2Yt/
         saticvhOBSatQ==
Date:   Tue, 14 Jun 2022 13:42:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Message-ID: <20220614114219.GB1892551@lothringen>
References: <20220611110044.2999157-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611110044.2999157-1-qiang1.zhang@intel.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 11, 2022 at 07:00:44PM +0800, Zqiang wrote:
> Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog kthreads
> enter polling mode. however, due to only insert CPU's rdp which belong to
> rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp served by rcuog
> kthread have been de-offloaded, these cause the 'nocb_head_rdp' list
> served by rcuog kthread is empty, when the 'nocb_head_rdp' is empty,
> the rcuog kthread in polling mode not actually do anything. fix it by
> exiting polling mode when the 'nocb_head_rdp'list is empty, otherwise
> entering polling mode.
> 
> Co-developed-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!

(might be worth testing with TREE01 and --bootargs "rcu_gp_poll" )
