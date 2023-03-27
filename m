Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E6EC74A5B
	for <rcu@archiver.kernel.org>; Mon, 27 Mar 2023 03:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjC0Db3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Mar 2023 23:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjC0DbH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Mar 2023 23:31:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5BC65BB;
        Sun, 26 Mar 2023 20:29:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8944060F58;
        Mon, 27 Mar 2023 03:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8285C433EF;
        Mon, 27 Mar 2023 03:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679887776;
        bh=AxwoMB+VkfLIBQoB4qhfr4okNhTIZ6HWGYdZ6XQjgqY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Tq2Lhu193plMBZ+ysv9pNMvsimnvM4XPos0gqPRxKJZOOAvMizuBz9homzYGvJ01l
         eVw0fBTodt1kbzv4MYBB4hWgJlOqSQfEQyZToRC1uKP4DooArBtVE27fbObknvWHUM
         P1Ee9B9KGdyRYH4Ndd75NsNei5nPK1Rt+OjQTYOEi8BIDo9kdkqlmKXUKuH+87ofdV
         crq5srBjpQ5uvcSBBxxCbFt0ZTO5MPtJV803bL0waSaNg8GJ1raszpI6W0RYzkFTdW
         VLQkZfNi4vzCnsd3fQL9iYXptgLTvj8X5Uc4EHQGSKlD34axoo0PZIDbzZ/ntuXZA7
         ivAqqV49pM8/w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 630901540474; Sun, 26 Mar 2023 20:29:36 -0700 (PDT)
Date:   Sun, 26 Mar 2023 20:29:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH RFC rcu 03/19] srcu: Begin offloading srcu_struct fields
 to srcu_update
Message-ID: <de891038-f7bb-4444-9655-12dd84fb4d13@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
 <20230324001938.3443499-3-paulmck@kernel.org>
 <80166ee7-4ee3-bb2d-c715-a8180dddee31@intel.com>
 <a0a2f6a7-b623-454c-ac65-69043a9f9f4d@paulmck-laptop>
 <20230326231858.GA19606@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326231858.GA19606@lst.de>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Mar 27, 2023 at 01:18:58AM +0200, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 01:11:47PM -0700, Paul E. McKenney wrote:
> > > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Thank you!  I will add this on my next rebase.
> > 
> > It is possible that this will be v6.5 rather than v6.4 material.
> 
> I was hoping the RCU bits could land in 6.4, so that the block
> layer work to take advantage of it can go into 6.5 without cross-tree
> dependencies.

Indeed, that patch series does hit a large chunk of SRCU, so my usual
offer of just giving you the patches is likely to run into trouble.

I will see what we can do about v6.4.

							Thanx, Paul
